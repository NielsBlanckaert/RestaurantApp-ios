//
//  RestaurantCell.swift
//  RestaurantApp
//
//  Created by Admin on 28/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//
import UIKit
import Cosmos

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    var restaurant: Restaurant! {
        didSet {
            restaurantImage.image = UIImage(named: restaurant.restaurantImage)
            name.text = restaurant.name
            address.text = restaurant.straatEnNummer + ", " + restaurant.postcode + " " + restaurant.stad
            rating.rating = getRating()
            rating.text = String(describing: restaurant.amountOfRatings)
        }
    }
    
    func getRating() -> Double {
        if restaurant.amountOfRatings >= 1 {
            return round(Double(restaurant.ratingTotal/Double(restaurant.amountOfRatings))*2.0)/2.0
        } else {
            return 0.0
        }
    }
}
