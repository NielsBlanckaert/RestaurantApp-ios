//
//  User.swift
//  RestaurantApp
//
//  Created by Admin on 27/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//
import Foundation
import RealmSwift

class User: Object {
    
    var email: String?
    var favorites = [Restaurant]()
}
