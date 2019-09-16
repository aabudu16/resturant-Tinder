//
//  ForgotPasswordViewController.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/14/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var emailTextFieldView: UIView!
    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDesignView()
    }
    private func setupDesignView(){
        emailTextFieldView.layer.shadowColor = UIColor.black.cgColor
        emailTextFieldView.layer.shadowOpacity = 1
        emailTextFieldView.layer.shadowOffset = .zero
        emailTextFieldView.layer.shadowRadius = 10
    }
   
    @IBAction func resetPasswordPressed(_ sender: UIButton) {
        
        if emailTextField.text == ""{
            messageTextView.isHidden = false
            messageTextView.textColor = .red
            messageTextView.text = "Please enter a valid email address"
        }else{
            
            messageTextView.isHidden = false
            messageTextView.textColor = .green
            messageTextView.text = "A message has been sent to you. Please check your email for further instructions"
          
            print("Password reset")
        }
       
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
