//
//  QuestionAddTableViewController.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 01.04.2023.
//

import UIKit

class QuestionAddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
extension QuestionAddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        return UITableViewCell()
    }
    
    
}
extension QuestionAddViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
        performSegue(withIdentifier: "addGroupToAll", sender: nil)

    }
}
