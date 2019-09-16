//
//  modelStruct.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct RestarantInfo: Codable {
    let businesses: BusinessesWrapper
    
    
    struct BusinessesWrapper : Codable {
        let name : String
        let image_url: String
        let url: String
        let review_count: String
        let categories: CatWrapper
        let review: Double?
        let price: String
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
        let displayAddress: [String]?
    }
    
}

struct CuisineCategories {
    let allCategories = ["American",
        "Asian Fusion",
        "Barbeque",
        "Brazilian",
        "Breakfast & Brunch",
        "Burgers",
        "Cajun/Creole",
        "Caribbean",
        "Cheesesteaks",
        "Chinese",
        "Creperies",
        "Cuban",
        "Delis",
        "Dumplings",
        "Fast Food",
        "Fish & Chips",
        "French",
        "Gluten-Free",
        "Greek",
        "Halal",
        "Hot Pot",
        "Indian",
        "Italian",
        "Japanese",
        "Korean",
        "Latin American",
        "Mexican",
        "Noodles",
        "Pizza",
        "Portuguese",
        "Salad",
        "Sandwiches",
        "Seafood",
        "Soul Food",
        "Soup",
        "Southern",
        "Steakhouses",
        "Sushi Bars",
        "Tapas Bars",
        "Tex-Mex",
        "Thai",
        "Vegan",
        "Vietnamese",
        "Waffles",
        "Wraps"
    ]
    
    private init() {}
}





