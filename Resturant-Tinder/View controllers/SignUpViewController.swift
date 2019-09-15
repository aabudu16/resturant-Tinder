//
//  SignUpViewController.swift
//  AppStoreUsingStoryBoard
//
//  Created by Mr Wonderful on 9/7/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var input:String?{
        didSet{
            emailTextField.text = input
        }
    }
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var cancelButtonImage: UIButton!
    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var emailTextFieldView: UIView!
    @IBOutlet var continueButtonView: UIView!
    @IBOutlet var fullNameTextFieldView: UIView!
    @IBOutlet var passwordTextFieldView: UIView!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var avatorImage
    : UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmailSignupView()
        setupDesignView()
        setupAvatorImage()
    }
    private func setupAvatorImage(){
        avatorImage.layer.cornerRadius = 75
        avatorImage.clipsToBounds = true
        avatorImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatorImage.addGestureRecognizer(tapGesture)
    }
    
    @objc private func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
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
        
        fullNameTextFieldView.layer.shadowColor = UIColor.black.cgColor
        fullNameTextFieldView.layer.shadowOpacity = 1
        fullNameTextFieldView.layer.shadowOffset = .zero
        fullNameTextFieldView.layer.shadowRadius = 10
        
        continueButtonView.layer.shadowColor = UIColor.gray.cgColor
        continueButtonView.layer.shadowOpacity = 1
        continueButtonView.layer.shadowOffset = .zero
        continueButtonView.layer.shadowRadius = 10
        
    }
    
    
    
    private func configureEmailSignupView(){
        continueButton.layer.cornerRadius = 25
        continueButton.setTitleColor(.black, for: .highlighted)
        
        emailTextField.keyboardType = .emailAddress
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        //        self.presentingViewController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            avatorImage.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            avatorImage.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

