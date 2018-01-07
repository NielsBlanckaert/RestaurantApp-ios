//
//  CommentsViewController.swift
//  RestaurantApp
//
//  Created by Admin on 30/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//

import Foundation
import UIKit

class CommentsViewController: UIViewController {
    
    var restaurant: Restaurant!
    var comments = [Comment]()
    
    @IBOutlet weak var tableComments: UITableView!
    
    override func viewDidLoad() {
        if restaurant == nil {
            tableComments.isHidden = true
        } else {
            comments = restaurant.comments
        }
    }
}

extension CommentsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableComments.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }
}
