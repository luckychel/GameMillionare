//
//  GameViewController.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import UIKit

//MARK: Delegate
protocol GameViewControllerDelegate: AnyObject {
    
    func didEndGame (withResult result: Result)
}

class GameViewController: UIViewController {
    
    //MARK: Enums
    enum RectangleImages: String {
        case blue = "RectangleBlue"
        case green = "RectangleGreen"
        case purple = "RectanglePurple"
        case red = "RectangleRed"
        case yellow = "RectangleYellow"
    }

    //MARK: Private variables
    var gameSingleton = Game.shared
    weak var gameDelegate: GameViewControllerDelegate?
    
    private var questions: [Question] = []
    var currentQuestion = 0
    var isCorrect: Bool?
    var answerTag: Int!
    
    //MARK: Private properties
    private var createquestionShowStrategy: QuestionShowStrategy {
        switch self.gameSingleton.questionShow {
            case .consistently:
                return ConsistentlyQuestionsStrategy()
            case .chaotic:
                return ChaoticQuestionsStrategy()
            }
    }

    //MARK: IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var EllipseImg: UIImageView!
    @IBOutlet weak var cash: UILabel!
    @IBOutlet weak var numbOfQuestion: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var answerOne: UILabel!
    @IBOutlet weak var answerTwo: UILabel!
    @IBOutlet weak var answerThree: UILabel!
    @IBOutlet weak var answerFour: UILabel!
    
    @IBOutlet weak var answerOneBtn: UIButton!
    @IBOutlet weak var answerTwoBtn: UIButton!
    @IBOutlet weak var answerThreeBtn: UIButton!
    @IBOutlet weak var answerFourBtn: UIButton!
    
    @IBOutlet weak var fiftyFiftyButton: UIButton!
    @IBOutlet weak var hallHelpButton: UIButton!
    @IBOutlet weak var callFriendButton: UIButton!
    
    @IBOutlet var answersLbl: [UILabel]!
    @IBOutlet var answersBtn: [UIButton]!
    
    @IBOutlet weak var takeCashLbl: UIButton!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.hidesBackButton = true
        fiftyFiftyButton.isHidden = true
        hallHelpButton.isHidden = true
        callFriendButton.isHidden = true
        timerLabel.isHidden = true
        EllipseImg.isHidden = true

        self.questions = self.createquestionShowStrategy.mixQuestion(self.gameSingleton.questionShow)
        self.gameSingleton.session = GameSession(allQuestionQuantity: self.questions.count)
        
        gameSingleton.session?.correctAnswer.addObserver(self, options: [.new, .initial]) {[weak self] (correctAnswer, _) in
            guard let self = self, let session = self.gameSingleton.session else { return }
            self.numbOfQuestion.text = "Вопрос \(correctAnswer) из \(session.allQuestionQuantity)"
        }
        gameSingleton.session?.moneyEarned.addObserver(self, options: [.new, .initial]) {[weak self] (moneyEarned, _) in
            guard let self = self else { return }
            self.cash.text = "Сумма  \(moneyEarned)"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addQuestion();
    }
    
    //MARK: Button press
    @IBAction func answerBtnPressed(_ sender: UIButton) {
        answerTag = sender.tag
        if answerTag == self.questions[currentQuestion].rightAnswer {
            isCorrect = true
        } else {
            isCorrect = false
        }
        answersBtn.forEach {$0.isEnabled = false}
        answerIsChecking()
    }
    
    @IBAction func takeMoneyPressed(_ sender: UIButton) {
       
        let alertController = UIAlertController(title: title, message: "Уверены, что хотите забрать деньги?", preferredStyle: .alert)

        let action1 = UIAlertAction(title: "Да", style: .default) { action in
            
            guard let session = self.gameSingleton.session else { return }

            session.correctAnswer.value = self.currentQuestion
            session.moneyEarned.value -= self.questions[self.currentQuestion].cash
            
            let alertController = UIAlertController(title: self.title, message: "Ваш выигрыш: \(session.moneyEarned.value)", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Ok", style: .default) { action in
                self.dismiss(animated: true)
                self.endGame(session.moneyEarned.value)
            }

            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        
        let action2 = UIAlertAction(title: "Нет", style: .default) { action in
            self.dismiss(animated: true)
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)

        present(alertController, animated: true)
    }
    
    //MARK: Methods
    private func addQuestion() {
        
        guard let session = self.gameSingleton.session, session.allQuestionQuantity > self.currentQuestion else {
            return
        }
        
        getQuestion()
        setButtonsBackToDefault()
        
        session.correctAnswer.value = self.currentQuestion + 1
        session.moneyEarned.value += self.questions[self.currentQuestion].cash

    }
    
    private func getQuestion() {

        questionLbl.text = self.questions[self.currentQuestion].question
        questionLbl.numberOfLines = 0
        
        if let session = self.gameSingleton.session {
            takeCashLbl.setTitle("Забрать деньги \(session.moneyEarned.value)", for: .normal)
            takeCashLbl.layer.cornerRadius = 20
        }

        answersLbl[0].text = self.questions[self.currentQuestion].answers[0]
        answersLbl[1].text = self.questions[self.currentQuestion].answers[1]
        answersLbl[2].text = self.questions[self.currentQuestion].answers[2]
        answersLbl[3].text = self.questions[self.currentQuestion].answers[3]
    }

    private func setButtonsBackToDefault() {
        (answerOne.isHidden, answerTwo.isHidden, answerThree.isHidden, answerFour.isHidden) = (false, false, false, false)
        
        answersBtn.forEach {$0.isEnabled = true}
        
        answersBtn.forEach {$0.setBackgroundImage(UIImage(named: RectangleImages.blue.rawValue), for: .normal) }
    }
    
    private func answerIsChecking() {

        if isCorrect == true {
            answersBtn[answerTag - 1].setBackgroundImage(UIImage(named: RectangleImages.green.rawValue), for: .normal)
            
            self.currentQuestion += 1
            
            guard let session = self.gameSingleton.session else { return }
            guard session.allQuestionQuantity > self.currentQuestion else {
                self.endGame(session.moneyEarned.value)
                return
            }

            _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {[weak self] timer in
                guard let self = self else { return }
                self.addQuestion();
            }
        }
        else {
            answersBtn[answerTag - 1].setBackgroundImage(UIImage(named: RectangleImages.red.rawValue), for: .normal)
            answersBtn[QuestionsData().getRightAnswerIndex(questionNumber: currentQuestion)].setBackgroundImage(UIImage(named: RectangleImages.green.rawValue), for: .normal)

            _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {[weak self] timer in
                
                guard let self = self else { return }
                guard let session = self.gameSingleton.session else { return }
                
                session.correctAnswer.value = self.currentQuestion
                session.moneyEarned.value -= self.questions[self.currentQuestion].cash
                self.endGame(0);
            }
        }
    }
    
    private func endGame(_ moneyEarned: Double) {
        guard let session = self.gameSingleton.session else { return }
        self.gameDelegate?.didEndGame(withResult: Result(procent: session.correctAnswerProcent(),
                                                         correctAnswerCount: session.correctAnswer.value,
                                                         moneyEarned: moneyEarned,
                                                         allAnswerCount: session.allQuestionQuantity))
        self.gameSingleton.session = nil
        self.navigationController?.popViewController(animated: true)
    }

}
