//
//  SettingsViewController.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 28.03.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Private variables
    var gameSingleton = Game.shared
    var questions: [Question] = []
    
    //MARK: IBOutlets
    @IBOutlet weak var questionShowSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    @IBAction func AddQuestion(_ sender: UIButton) {
        var tempQuestions: [Question] = []
        if self.questions.count > 0 {
            tempQuestions = getQuestionsFromTable()
        }
        tempQuestions.append(Question(question: "", answers: [], rightAnswer: 0, cash: 0.0))
        self.questions = tempQuestions
        self.tableView.reloadData()
    }

    @IBAction func SaveQuestions(_ sender: UIButton) {
        var questions = getQuestionsFromTable()
        if (!questions.isEmpty && checkQuestionAddArrays(questions)) {
            questions.forEach{res in
                gameSingleton.addQuestion(res)
            }
            self.questions = []
            self.tableView.reloadData()
        }
    }
    
    func checkQuestionAddArrays(_ questions: [Question]) -> Bool {
        var res: Bool = true
        questions.forEach { quest in
            if quest.question.isEmpty {
                res = false
                return
            }
            if quest.answers.filter({$0 == ""}).count > 0 {
                res = false
                return
            }
            if quest.rightAnswer == 0 {
                res = false
                return
            }
            if quest.cash == 0.0 {
                res = false
                return
            }
        }
        var message = ""
        if (!res) {
           message = "В форме добавления вопроса присутствуют ошибки, не заполнены обязательные поля!"
        }
        else {
            message = "Вопросы сохранены!"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "ОК", style: .default) { action in
            self.dismiss(animated: true)
        }
        alertController.addAction(action1)
        present(alertController, animated: true)
        return res
    }
    
    func getQuestionsFromTable() -> [Question] {
        
        var tempQuestions: [Question] = []
        guard let cells = tableView.cells as? [QuestionAddTableViewCell] else { return tempQuestions }
        
        cells.forEach { cell in
            var answers: [String] = []
            answers.append(cell.answer1.text ?? "")
            answers.append(cell.answer2.text ?? "")
            answers.append(cell.answer3.text ?? "")
            answers.append(cell.answer4.text ?? "")
            var rightAnswer = 0
            cell.answersSwitch.forEach{sw in
                if sw.isOn {
                    rightAnswer = sw.tag + 1
                }
            }
            tempQuestions.append(Question(question: cell.question.text ?? "",
                                          answers: answers,
                                          rightAnswer: rightAnswer,
                                          cash: cell.questionCost.text?.toDouble ?? 0.0))
        }
        return tempQuestions
    }
    
   
    
    //MARK: Private properties
    public var selectQuestionShow: QuestionShow {
        switch questionShowSegmentControl.selectedSegmentIndex {
        case 0:
            return .consistently
        case 1:
            return .chaotic
        default:
            return .consistently
        }
    }

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "QuestionAddTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionAddXIB")
        
        self.questionShowSegmentControl.selectedSegmentIndex = gameSingleton.questionShow.index ?? 0
        
        questionShowSegmentControl.addTarget(self, action: #selector(SettingsViewController.indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        gameSingleton.setQuestionShow(self.selectQuestionShow)
    }

}
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionAddXIB", for: indexPath) as? QuestionAddTableViewCell else {
              preconditionFailure("Error")
          }

          cell.question.text = self.questions[indexPath.row].question
//          cell.answer1.text = self.questions[indexPath.row].answers[0]
//          cell.answer2.text = self.questions[indexPath.row].answers[1]
//          cell.answer3.text = self.questions[indexPath.row].answers[2]
//          cell.answer4.text = self.questions[indexPath.row].answers[3]
          cell.answer1Switch.isOn = self.questions[indexPath.row].rightAnswer == 1
          cell.answer2Switch.isOn = self.questions[indexPath.row].rightAnswer == 2
          cell.answer3Switch.isOn = self.questions[indexPath.row].rightAnswer == 3
          cell.answer4Switch.isOn = self.questions[indexPath.row].rightAnswer == 4

          return cell
    }

}

extension String {
    var toDouble: Double {
        return Double(self) ?? 0.0
    }
}

extension UITableView {
    /**
     * Returns all cells in a table
     * ## Examples:
     * tableView.cells // array of cells in a tableview
     */
    public var cells: [UITableViewCell] {
      (0..<self.numberOfSections).indices.map { (sectionIndex: Int) -> [UITableViewCell] in
          (0..<self.numberOfRows(inSection: sectionIndex)).indices.compactMap { (rowIndex: Int) -> UITableViewCell? in
              self.cellForRow(at: IndexPath(row: rowIndex, section: sectionIndex))
          }
      }.flatMap { $0 }
    }
}
