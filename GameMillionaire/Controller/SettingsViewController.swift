//
//  SettingsViewController.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 28.03.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    var gameSingleton = Game.shared
    
    @IBOutlet weak var questionShowSegmentControl: UISegmentedControl!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionShowSegmentControl.selectedSegmentIndex = gameSingleton.questionShow.index ?? 0
        
        questionShowSegmentControl.addTarget(self, action: #selector(SettingsViewController.indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        gameSingleton.questionShow = self.selectQuestionShow
    }

}
