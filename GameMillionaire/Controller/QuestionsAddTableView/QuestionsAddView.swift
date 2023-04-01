//
//  QuestionsAddControllerTableViewController.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 01.04.2023.
//

import UIKit

class QuestionsAddView: UIView, UITableViewDelegate, UITableViewDataSource {
    
   

    override init() {
        super.init()
        //tableView.register(UINib(nibName: "QuestionAddTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionAddXIB")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    
    

    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return self.questions.count
//    }


//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        //MARK: перешли на XIB
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionAddXIB", for: indexPath) as? QuestionAddTableViewCell else {
//            preconditionFailure("Error")
//        }
//
//        cell.question.text = self.questions[indexPath.row].question
//        cell.answer1.text = self.questions[indexPath.row].answers[0]
//        cell.answer2.text = self.questions[indexPath.row].answers[1]
//        cell.answer3.text = self.questions[indexPath.row].answers[2]
//        cell.answer4.text = self.questions[indexPath.row].answers[3]
//        cell.answer1Switch.isOn = self.questions[indexPath.row].rightAnswer == 1
//        cell.answer2Switch.isOn = self.questions[indexPath.row].rightAnswer == 2
//        cell.answer3Switch.isOn = self.questions[indexPath.row].rightAnswer == 3
//        cell.answer4Switch.isOn = self.questions[indexPath.row].rightAnswer == 4
//
//        return cell
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
