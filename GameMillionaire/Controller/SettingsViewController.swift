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
    
    //MARK: IBOutlets
    @IBOutlet weak var questionShowSegmentControl: UISegmentedControl!
    
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
        
        self.questionShowSegmentControl.selectedSegmentIndex = gameSingleton.questionShow.index ?? 0
        
        questionShowSegmentControl.addTarget(self, action: #selector(SettingsViewController.indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        gameSingleton.setQuestionShow(self.selectQuestionShow)
    }

}
