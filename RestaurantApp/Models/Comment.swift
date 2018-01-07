//
//  Comment.swift
//  RestaurantApp
//
//  Created by Admin on 27/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//

import Cosmos

class Comment: NSObject {
    
    var user: String = "Anonymous"
    var rating: Double = 0.0
    var text: String = ""
    
    convenience init(user: String, rating: Double, text: String) {
        self.init()
        self.user = user
        self.rating = rating
        self.text = text
    }
}
