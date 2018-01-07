//
//  HomeViewController.swift
//  RestaurantApp
//
//  Created by Admin on 28/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//
import Foundation
import RealmSwift
import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //var restaurants: Results<Restaurant>!
    var restaurants = [Restaurant]()
    var filteredRestaurants = [Restaurant]()
    
    private var indexPathToComment: IndexPath!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        //clearDB()
        fillDB()
        //restaurants = try! Realm().objects(Restaurant.self)
        
        self.tableView.rowHeight = 100.0
        filteredRestaurants = restaurants
        splitViewController!.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "restaurantDetails"?:
            let restaurantDetailViewController = (segue.destination as! UINavigationController).topViewController as! RestaurantDetailViewController
            let selection = tableView.indexPathForSelectedRow!
            restaurantDetailViewController.restaurant = restaurants[selection.row]
            restaurantDetailViewController.indexPathToComment = self.indexPathToComment
            tableView.deselectRow(at: selection, animated: true)
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindFromAddComment(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddComment"?:
            tableView.reloadRows(at: [indexPathToComment], with: .automatic)
        default:
            fatalError("Unkown segue")
        }
    }

    
    func fillDB() -> Void {
        /*let realm = try! Realm()
        try! realm.write {
            let r1 = Restaurant(name: "Hof van Cleve", address: "Riemegemstraat 1, 9770 Kruishoutem", amountOfRatings: 0, ratingTotal: 0, restaurantImage: "hof-van-cleve")
            let r2 = Restaurant(name: "Chaflo & Co", address: "Dendermondesteenweg 336, 9070 Destelbergen", amountOfRatings: 0, ratingTotal: 0, restaurantImage: "chaflo")
            let r3 = Restaurant(name: "The Jane", address: "Paradeplein 1, 2018 Antwerpen", amountOfRatings: 0, ratingTotal: 0, restaurantImage: "thejane")
            realm.add([r1, r2, r3])
        }*/
        
        restaurants = DummyData.restaurants
    }
    
    func clearDB() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }

}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPathToComment = indexPath
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addToFavoritesAction = UIContextualAction(style: .normal, title: "") {
            (action, view, completionHandler) in
            let restaurant = self.restaurants[indexPath.row]
            if restaurant.favorite == true {
                let alertController = UIAlertController(title: "Error", message: "Already in list of favorites", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                restaurant.favorite = true
            }
            completionHandler(true)
        }
        addToFavoritesAction.image = UIImage(named: "addFavorites")
        return UISwipeActionsConfiguration(actions: [addToFavoritesAction])
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.restaurant = filteredRestaurants[indexPath.row]
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredRestaurants = restaurants
            tableView.reloadData()
            return
        }
        filteredRestaurants = restaurants.filter({ restaurant -> Bool in {
            restaurant.name.lowercased().contains(searchText.lowercased()) ||
            restaurant.stad.lowercased().contains(searchText.lowercased()) ||
                restaurant.postcode.lowercased().contains(searchText.lowercased()) }()
        })
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
}

//HpTerm: https://stackoverflow.com/questions/25831832/uinavigationcontroller-inside-a-uitabbarcontroller-inside-a-uisplitviewcontroller
extension HomeViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
        if (splitViewController.isCollapsed) {
            let master = splitViewController.viewControllers[0] as! UITabBarController
            let masterNavigationController = master.selectedViewController as! UINavigationController
            
            let detailViewControllerNavigationController = (vc as! UINavigationController).viewControllers[0] as UIViewController
            
            masterNavigationController.pushViewController(detailViewControllerNavigationController, animated: true)
            
            return true
        } else {
            return false
        }
    }
}

