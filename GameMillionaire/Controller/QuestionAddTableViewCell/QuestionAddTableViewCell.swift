//
//  QuestionAddTableViewCell.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 01.04.2023.
//

import UIKit

class QuestionAddTableViewCell: UITableViewCell {
    
    @IBOutlet var question: UITextField!
    
    @IBOutlet var answer1: UITextField!
    @IBOutlet var answer2: UITextField!
    @IBOutlet var answer3: UITextField!
    @IBOutlet var answer4: UITextField!
    
    @IBOutlet var answer1Switch: UISwitch!
    @IBOutlet var answer2Switch: UISwitch!
    @IBOutlet var answer3Switch: UISwitch!
    @IBOutlet var answer4Switch: UISwitch!
    
    @IBOutlet weak var questionCost: UITextField!
    
    @IBOutlet var answersSwitch: [UISwitch]!
    
    //MARK: Button press
    @IBAction func answersSwitchPressed(_ sender: UISwitch) {
        answersSwitch.forEach{ sw in
            if sw.tag != sender.tag {
                sw.isOn = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
