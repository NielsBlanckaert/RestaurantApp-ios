//
//  FavoritesViewController.swift
//  RestaurantApp
//
//  Created by Admin on 28/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [Restaurant]()
    var filteredFavorites = [Restaurant]()
    
    private var indexPathToEdit: IndexPath!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        self.tableView.rowHeight = 100.0
        favorites = DummyData.restaurants.filter({$0.favorite == true})
        filteredFavorites = favorites
        splitViewController!.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favorites = DummyData.restaurants.filter({$0.favorite == true})
        filteredFavorites = favorites
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "restaurantDetails"?:
            let restaurantDetailViewController = (segue.destination as! UINavigationController).topViewController as! RestaurantDetailViewController
            restaurantDetailViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            restaurantDetailViewController.navigationItem.leftItemsSupplementBackButton = true
            let selection = tableView.indexPathForSelectedRow!
            restaurantDetailViewController.restaurant = favorites[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        default:
            fatalError("Unknown segue")
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") {
            (action, view, completionHandler) in
            let restaurant = self.filteredFavorites[indexPath.row]
            restaurant.favorite = false
            tableView.reloadRows(at: [indexPath], with: .automatic)
            self.filteredFavorites.remove(at: indexPath.row)
            self.favorites = DummyData.restaurants.filter({$0.favorite == true})
            self.filteredFavorites = self.favorites
            tableView.reloadData()
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.restaurant = filteredFavorites[indexPath.row]
        return cell
    }
}

extension FavoritesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredFavorites = favorites
            tableView.reloadData()
            return
        }
        filteredFavorites = favorites.filter({ restaurant -> Bool in {
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
extension FavoritesViewController: UISplitViewControllerDelegate {
    
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


