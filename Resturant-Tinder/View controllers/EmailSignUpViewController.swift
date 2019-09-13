//
//  SignUpViewController.swift
//  AppStoreUsingStoryBoard
//
//  Created by Mr Wonderful on 9/7/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class EmailSignUpViewController: UIViewController {
    
    var input:String?{
        didSet{
            emailTextField.text = input
        }
    }
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var subscribeLabel: UILabel!
    @IBOutlet var cancelButtonImage: UIButton!
    @IBOutlet var emailTextFieldView: UIView!
    
    @IBOutlet var continueButtonView: UIView!
    @IBOutlet var cancelView: UIView!
    @IBOutlet var passwordTextFieldView: UIView!
    
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var subscribeButton: UIButton!
    @IBOutlet var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmailSignupView()
        configureSubscribeButton()
        setupDesignView()
        
    }
    
    private func setupDesignView(){
        emailTextFieldView.layer.shadowColor = UIColor.black.cgColor
        emailTextFieldView.layer.shadowOpacity = 1
        emailTextFieldView.layer.shadowOffset = .zero
        emailTextFieldView.layer.shadowRadius = 10
        
        passwordTextFieldView.layer.shadowColor = UIColor.black.cgColor
        passwordTextFieldView.layer.shadowOpacity = 1
        passwordTextFieldView.layer.shadowOffset = .zero
        passwordTextFieldView.layer.shadowRadius = 10
        
        cancelView.layer.shadowColor = UIColor.black.cgColor
        cancelView.layer.shadowOpacity = 1
        cancelView.layer.shadowOffset = .zero
        cancelView.layer.shadowRadius = 10
        
        continueButtonView.layer.shadowColor = UIColor.gray.cgColor
        continueButtonView.layer.shadowOpacity = 1
        continueButtonView.layer.shadowOffset = .zero
        continueButtonView.layer.shadowRadius = 10
        
    }
    
    
    
    private func configureEmailSignupView(){
        continueButton.layer.cornerRadius = 25
        continueButton.setTitleColor(.black, for: .highlighted)
        
        emailTextField.keyboardType = .emailAddress
        backgroundImage.image = UIImage(named: "signup image")
    }
    
    private func configureSubscribeButton(){
        subscribeButton.layer.cornerRadius = 10
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
       self.dismiss(animated: true, completion: nil)
    }
    
}
