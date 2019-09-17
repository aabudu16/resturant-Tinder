//
//  welcomeViewController.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/15/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    //dont touch
    @IBOutlet var selectCatergoryButtonView: UIView!
    //dont touch
    @IBOutlet var randomButtonView: UIView!
    
    //MARK: - IBOutlets
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var selectCatergoryButton: UIButton!
    @IBOutlet var welcomeLabel: UILabel!
    
    //MARK: - IBActions
    @IBAction func pressedRandomButton(_ sender: UIButton) {
        let swipeScreenVC = storyboard?.instantiateViewController(withIdentifier: "SwipeViewController") as! SwipeViewController
        //TODO: swipeScreenVC.categoriesArray = [All cases of Categories]
        self.navigationController?.pushViewController(swipeScreenVC, animated: true)
    }
    
    @IBAction func pressedSelectCategoryButton(_ sender: UIButton) {
        let categoriesSelectionVC = storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CatergoriesViewController
        self.navigationController?.pushViewController(categoriesSelectionVC, animated: true)
    }
    
    //MARK: - Properties
    var setUserName:String!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWelcomeViews()
    }
    
    //MARK: - Custom Functions
    private func setUpWelcomeViews() {
        self.selectCatergoryButton.setTitle("Select Cuisine Types", for: .normal)
        self.randomButton.setTitle("Surprise Me!", for: .normal)
        self.welcomeLabel.text = setUserName
    }
    
    
}
