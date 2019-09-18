//
//  ResturantDetailViewController.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ResturantDetailViewController: UIViewController {
    
    var restDetails: BusinessesWrapper!
    

    @IBOutlet var resturantName: UILabel!
    @IBOutlet var address: UITextView!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var ratings: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var foodImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        resturantName.text = restDetails.name.capitalized
        address.text = "\(restDetails.location.address1.capitalized) \n \(restDetails.location.city.capitalized), \(restDetails.location.state.capitalized)"
//        phone number not being decoded in model yet. will not add right now
        ratings.text = "Rating: \(restDetails.rating)"
        price.text = restDetails.price
        category.text = "\(restDetails.categories[0])"
//        foodImage.image = UIImage
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    



}
