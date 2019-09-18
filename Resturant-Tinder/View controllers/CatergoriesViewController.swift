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
            swipeVC.chosenCategories = chosenCategories
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
    
    private func getBusinesses() {
        print("Getting businesses")
        print("Chosen categories count: \(chosenCategories.count)")
        guard let searchTerm = chosenCategories.popLast() else { return }
        print("the search term is \(searchTerm)")
        ResturantAPIClient.getbusinessesData(categorySearch: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let allbiz):
                    print("Success: got \(allbiz)")
                    self.relatedBusinesses += allbiz
                    if self.chosenCategories.isEmpty {
                        dump(self.relatedBusinesses)
                        //full array done
                        //                        self.getImagesFromBusinesses()SwipeViewController
                        return
                    } else {
                        print("recursively calling get businesses: current cat count: \(self.chosenCategories.count)")
                        self.getBusinesses()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getImagesFromBusinesses() {
        var copyOfRelatedBusinesses = self.relatedBusinesses
        guard let businessOfInterest = copyOfRelatedBusinesses.popLast() else { return }
        ImageHelper.shared.getImage(urlStr: businessOfInterest.image_url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imagesForBusinesses.append(image)
                    if copyOfRelatedBusinesses.isEmpty {
                        dump(self.imagesForBusinesses)
                        return
                    } else {
                        self.getImagesFromBusinesses()
                    }
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
