//
//  RestaurantDetailViewController.swift
//  RestaurantApp
//
//  Created by Admin on 29/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Cosmos
import PopupDialog

class RestaurantDetailViewController: UITableViewController {
    
    @IBOutlet weak var chefkok: UILabel!
    
    @IBOutlet weak var beschrijving: UILabel!
    
    @IBOutlet weak var rating: CosmosView!
    
    @IBOutlet weak var postcodeEnStad: UILabel!
    
    @IBOutlet weak var straatEnNummer: UILabel!
    
    var restaurant: Restaurant!
    
    @IBOutlet weak var map: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    @IBOutlet weak var addCommentButton: UIBarButtonItem!
    
    var commentsViewController: CommentsViewController!
    
    var indexPathToComment: IndexPath!
    
    override func viewDidLoad() {
        if restaurant == nil {
            tableView.isHidden = true
        } else {
            title = restaurant?.name
            chefkok.text = restaurant?.chefkok
            beschrijving.text = restaurant?.beschrijving
            rating.rating = getRating()
            rating.text = String(describing: restaurant.amountOfRatings)
            postcodeEnStad.text = (restaurant?.postcode)! + " " + (restaurant?.stad)!
            straatEnNummer.text = restaurant?.straatEnNummer
            annotation.coordinate = CLLocationCoordinate2D(latitude: (restaurant?.latitude)!, longitude: (restaurant?.longitude)!)
            map.addAnnotation(annotation)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func getRating() -> Double {
        if restaurant.amountOfRatings >= 1 {
            return round(Double(restaurant!.ratingTotal/Double(restaurant!.amountOfRatings))*2.0)/2.0
        } else {
            return 0.0
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showComments"?:
            self.commentsViewController = segue.destination as! CommentsViewController
            self.commentsViewController.restaurant = self.restaurant
        case "showPopup"?:
            let ratingViewController = segue.destination as! RatingViewController
            ratingViewController.restaurant = self.restaurant
        default:
            fatalError("Unknown segue")
        }
    }
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        return true
    }
    
    
    @IBAction func unwindFromAddComment(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddComment"?:
            let ratingViewController = segue.source as! RatingViewController
            restaurant.comments.append(ratingViewController.commentObject!)
            self.commentsViewController.comments.append(ratingViewController.commentObject!)
            restaurant.amountOfRatings = restaurant.amountOfRatings + 1
            restaurant.ratingTotal = restaurant.ratingTotal + (ratingViewController.commentObject?.rating)!
            
            self.commentsViewController.tableComments.insertRows(at: [IndexPath(row: self.commentsViewController.comments.count - 1, section: 0)], with: .automatic)
            self.commentsViewController.tableComments.reloadData()
        default:
            fatalError("Unkown segue")
        }
    }
}
