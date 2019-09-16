//
//  CatergoriesViewController.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CatergoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: Properties
    let allCategories = CuisineCategories().allCategories
    
    //MARK: - IBOutlets
    @IBOutlet var categoriesTableView: UITableView!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var selectButton: UIBarButtonItem!
    
    //MARK: - IBActions
    @IBAction func selectbuttonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        
    }
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategoriesTableView()
    }
    
    //MARK: - DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Define numRows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Define tableViewCell
        return UITableViewCell()
    }
    
    //MARK: - Delegate Methods
    
    //MARK: - Custom Functions
    private func configureCategoriesTableView() {
        self.categoriesTableView.dataSource = self
        self.categoriesTableView.delegate = self
    }

}
