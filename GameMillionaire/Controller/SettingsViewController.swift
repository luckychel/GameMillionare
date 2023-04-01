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
        self.questions.append(Question(question: "", answers: [], rightAnswer: 0, cash: 0))
        self.tableView.reloadData()
    }

    @IBAction func SaveQuestions(_ sender: UIButton) {
        var cells = [QuestionAddTableViewCell]()
        for i in 0...tableView.numberOfSections-1
        {
           for j in 0...tableView.numberOfRows(inSection: i)-1
           {
               if let cell = tableView.cellForRow(at: NSIndexPath(row: j, section: i) as IndexPath) as? QuestionAddTableViewCell {
                  cells.append(cell)
               }
           }
        }
        cells.forEach{ cell in
            print(cell.question.text as Any)
        }
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
