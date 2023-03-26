//
//  GameViewController.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var CloseGame: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func TapCloseGame(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
