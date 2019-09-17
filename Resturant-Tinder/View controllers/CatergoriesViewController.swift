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
    var relatedBusinesses = [BusinessesWrapper]()
    var imagesForBusinesses = [UIImage]()
    var businessesAndImages = [(BusinessesWrapper, UIImage)]()
    
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
        if !chosenCategories.isEmpty {
            let swipeVC = storyboard?.instantiateViewController(withIdentifier: "SwipeViewController") as! SwipeViewController
            swipeVC.userChosenCategories = chosenCategories
            self.navigationController?.pushViewController(swipeVC, animated: true)
        } else {
            return
        }
    }
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategoriesTableView()
    }
    
    //MARK: - Custom Functions
    private func configureCategoriesTableView() {
        self.categoriesTableView.dataSource = self
        self.categoriesTableView.delegate = self
    }
    
    private func getBusinesses(for category: String) {
        ResturantAPIClient.getbusinessesData(categorySearch: category) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success( let allbiz ):
                    self.relatedBusinesses += allbiz
                case .failure( let error):
                    print(error)
                }
            }
        }
    }
    
    private func getImagesFromBusiness(imageURL: String) {
        ImageHelper.shared.getImage(urlStr: imageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imagesForBusinesses.append(image)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    //MARK: - DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let currentCategory = allCategories[indexPath.row]
        cell.textLabel?.text = currentCategory
        if chosenCategories.contains(currentCategory) {
            cell.detailTextLabel?.text = "\u{2713}"
        } else {
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
