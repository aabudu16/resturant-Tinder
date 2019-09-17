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
    var chosenCategories = [String]()
    
    //MARK: - IBOutlets
    @IBOutlet var categoriesTableView: UITableView!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var selectButton: UIBarButtonItem!
    
    //MARK: - IBActions
    @IBAction func selectbuttonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Select All" {
            chosenCategories = allCategories
            sender.title = "Deselect All"
        } else {
            chosenCategories = [String]()
            sender.title = "Select All"
        }
        categoriesTableView.reloadData()
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let swipeScreenVC = storyboard?.instantiateViewController(withIdentifier: "SwipeViewController") as! SwipeViewController
        //TODO: swipeScreenVC.categoriesArray = [All cases of Categories]
        self.navigationController?.pushViewController(swipeScreenVC, animated: true)
    }
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategoriesTableView()
        loaddata()
        
    }
    

    private func loaddata() {
        ResturantAPIClient.getbusinessesData { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success( let allbiz ):
                    print(allbiz.count)
                case .failure( let error):
                    print(error)
                }
            }
        }
    }

    //MARK: - Custom Functions
    private func configureCategoriesTableView() {
        self.categoriesTableView.dataSource = self
        self.categoriesTableView.delegate = self
    }

    //MARK: - DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let currentCategory = allCategories[indexPath.row]
        cell.textLabel?.text = currentCategory
        if chosenCategories == allCategories {
            cell.detailTextLabel?.text = "\u{2713}"
        } else if chosenCategories.isEmpty {
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    //MARK: - Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCategory = allCategories[indexPath.row]
        
        if chosenCategories.contains(currentCategory) {
            chosenCategories = chosenCategories.filter { $0 != currentCategory }
            categoriesTableView.cellForRow(at: indexPath)?.detailTextLabel?.text = ""
        } else {
            chosenCategories.append(currentCategory)
            categoriesTableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "\u{2713}"
        }
    }
    
    

}
