//
//  welcomeViewController.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/15/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    var setUserName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

       welcomeLabel.text = setUserName 
    }
    
}
