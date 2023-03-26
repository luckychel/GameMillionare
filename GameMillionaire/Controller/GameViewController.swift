//
//  GameViewController.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import UIKit

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
    let questionsStructure = QuestionsData()
    var gameSingleton = Game.shared
    weak var gameDelegate: GameViewControllerDelegate?

    var currentQuestion = 0
    var sumAllQuestion = 0
    var isCorrect: Bool?
    var answerTag: Int!

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
        takeCashLbl.isHidden = true
        fiftyFiftyButton.isHidden = true
        hallHelpButton.isHidden = true
        callFriendButton.isHidden = true
        timerLabel.isHidden = true
        EllipseImg.isHidden = true
        
        sumAllQuestion = questionsStructure.questions.count
        
        self.gameSingleton.session = GameSession(correctAnswer: 0, questionQuantity: sumAllQuestion, moneyEarned: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addQuestion(currentQuestion);
    }
    
    //MARK: Button press
    @IBAction func answerBtnPressed(_ sender: UIButton) {
        answerTag = sender.tag
        if answerTag == questionsStructure.questions[currentQuestion].rightAnswer {
            self.gameSingleton.session?.correctAnswer += 1
            self.gameSingleton.session?.moneyEarned = questionsStructure.questions[currentQuestion].cash
            isCorrect = true
        } else {
            isCorrect = false
        }
        answersBtn.forEach {$0.isEnabled = false}
        answerIsChecking()
    }
    
    //MARK: Methods
    private func addQuestion(_ index: Int) {
        
        guard sumAllQuestion > index else {
            return
        }
        
        getQuestion(index)
        setButtonsBackToDefault()
        numbOfQuestion.text = ("Вопрос ") + String(index + 1)
        cash.text = ("Сумма  ") + String(questionsStructure.questions[index].cash)
    }
    
    private func getQuestion(_ index: Int) {

        questionLbl.text = questionsStructure.questions[index].question
        questionLbl.numberOfLines = 0
        
        //takeCashLbl.setTitle("Забрать деньги", for: .normal)
        //takeCashLbl.layer.cornerRadius = 20
        
        answersLbl[0].text = questionsStructure.questions[index].answers[0]
        answersLbl[1].text = questionsStructure.questions[index].answers[1]
        answersLbl[2].text = questionsStructure.questions[index].answers[2]
        answersLbl[3].text = questionsStructure.questions[index].answers[3]
    }

    private func setButtonsBackToDefault() {
        (answerOne.isHidden, answerTwo.isHidden, answerThree.isHidden, answerFour.isHidden) = (false, false, false, false)
        
        answersBtn.forEach {$0.isEnabled = true}
        
        answersBtn.forEach {$0.setBackgroundImage(UIImage(named: RectangleImages.blue.rawValue), for: .normal) }
    }
    
    private func answerIsChecking() {

        if isCorrect == true {
            answersBtn[answerTag - 1].setBackgroundImage(UIImage(named: RectangleImages.green.rawValue), for: .normal)
            
            currentQuestion += 1
            
            guard sumAllQuestion > currentQuestion else {
                gameDelegate?.didEndGame(withResult: Result(procent: self.gameSingleton.session?.correctAnswerProcent() ?? 0,
                                                            correctAnswerCount: self.gameSingleton.session?.correctAnswer ?? 0,
                                                            moneyEarned: self.gameSingleton.session?.moneyEarned ?? 0, allAnswerCount: self.gameSingleton.session?.questionQuantity ?? 0))
                self.gameSingleton.session = nil
                return
            }
            _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {[weak self] timer in
                guard let self = self else { return }
                self.addQuestion(self.currentQuestion);
            }
        }
        else {
            answersBtn[answerTag - 1].setBackgroundImage(UIImage(named: RectangleImages.red.rawValue), for: .normal)
            answersBtn[questionsStructure.getRightAnswerIndex(questionNumber: currentQuestion)].setBackgroundImage(UIImage(named: RectangleImages.green.rawValue), for: .normal)
            
            _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {[weak self] timer in
                guard let self = self else { return }
                self.gameDelegate?.didEndGame(withResult: Result(procent: self.gameSingleton.session?.correctAnswerProcent() ?? 0,
                                                                 correctAnswerCount: self.gameSingleton.session?.correctAnswer ?? 0,
                                                                 moneyEarned: self.gameSingleton.session?.moneyEarned ?? 0,
                                                                 allAnswerCount: self.gameSingleton.session?.questionQuantity ?? 0))
                self.gameSingleton.session = nil
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    

    
   
    

}