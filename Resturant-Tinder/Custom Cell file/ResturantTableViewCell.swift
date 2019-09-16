//
//  ResturantTableViewCell.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ResturantTableViewCell: UITableViewCell {

    @IBOutlet var ratings: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var resturantName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
