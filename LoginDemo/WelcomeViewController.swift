//
//  WelcomeViewController.swift
//  LoginDemo
//
//  Created by MingXin Liu on 2023/7/8.
//

import UIKit

class WelcomeViewController: UIViewController {

    var user: User!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var passwordLevelLabel: UILabel!
    @IBOutlet weak var passwordProgress: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.accountLabel.text = user.account
        
        let score = PasswordLevel.calculateScore(password: user.password)
        let level = PasswordLevel.calculatePasswordLevel(password: user.password, score: score)
        self.passwordProgress.progress = Float(score) / 100
        self.passwordProgress.tintColor = level.color
        self.passwordLevelLabel.text = level.title
    }

}
