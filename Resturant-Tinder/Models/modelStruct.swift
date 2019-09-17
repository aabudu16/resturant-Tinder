//
//  modelStruct.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct RestaurantInfo: Codable {
    
    let businesses: [BusinessesWrapper]
        
}


struct BusinessesWrapper : Codable {
    let name : String
    let image_url: String
    let url: String
    let review_count: Int
    let categories: [CatWrapper]
    let rating: Double?
    let price: String?
    let location: locationWrapper
}
    
    struct CatWrapper: Codable {
        let alias: String
        let title: String
    }
    
    struct locationWrapper: Codable {
        let address1: String
        let city: String
        let country: String
        let state: String
//        let displayAddress: [String]?
    }


struct CuisineCategories {
    let allCategories = ["American",
        "Asian",
        "Barbeque",
        "Brazilian",
        "Breakfast",
        "Burgers",
        "Cajun",
        "Caribbean",
        "Cheesesteaks",
        "Chinese",
        "Creperies",
        "Cuban",
        "Delis",
        "Dumplings",
        "French",
        "Greek",
        "Halal",
        "Indian",
        "Italian",
        "Japanese",
        "Korean",
        "Mexican",
        "Noodles",
        "Pizza",
        "Portuguese",
        "Salad",
        "Sandwiches",
        "Seafood",
        "Soup",
        "Southern",
        "Steakhouses",
        "Thai",
        "Vegan",
        "Vietnamese",
        "Waffles",
        "Wraps"
    ]
    
    init() {}
}





