//
//  Restaurant.swift
//  RestaurantApp
//
//  Created by Admin on 27/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//

import Foundation
import RealmSwift
import Firebase
import FirebaseAuth
import UIKit

class Restaurant: NSObject {
    
    var name: String = ""
    var straatEnNummer: String = ""
    var postcode: String = ""
    var stad: String = ""
    var restaurantImage: String = "hof-van-cleve"
    var amountOfRatings: Int = 0
    var ratingTotal: Double = 0
    var favorite: Bool = false
    var beschrijving: String = ""
    var chefkok: String = "?"
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var comments = [Comment]()
    
    convenience init(name: String, straatEnNummer: String, postcode: String, stad: String, amountOfRatings: Int, ratingTotal: Double, restaurantImage: String, favorite: Bool, beschrijving: String, chefkok: String, latitude: Double, longitude: Double, comments: [Comment]?) {
        self.init()
        self.name = name
        self.straatEnNummer = straatEnNummer
        self.postcode = postcode
        self.stad = stad
        self.amountOfRatings = amountOfRatings
        self.ratingTotal = ratingTotal
        self.restaurantImage = restaurantImage
        self.favorite = favorite
        self.beschrijving = beschrijving
        self.chefkok = chefkok
        self.latitude = latitude
        self.longitude = longitude
        self.comments = comments == nil ? [Comment]() : comments!
    }

}

