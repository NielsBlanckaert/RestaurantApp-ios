//
//  CommentCell.swift
//  RestaurantApp
//
//  Created by Admin on 30/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//

import UIKit
import Cosmos

class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var user: UILabel!
    
    @IBOutlet weak var rating: CosmosView!
    
    @IBOutlet weak var tekst: UITextView!
    
    var comment: Comment! {
        didSet {
            user.text = comment.user
            rating.rating = comment.rating
            tekst.text = comment.text
        }
    }
}
