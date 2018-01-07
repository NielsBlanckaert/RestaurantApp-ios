//
//  RatingViewController.swift
//  PopupDialog
//
//  Created by Martin Wildfeuer on 11.07.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import UIKit
import Cosmos

class RatingViewController: UIViewController {
    
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var rating: CosmosView!
    
    var commentObject: Comment?
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPopup.layer.borderWidth = 0.3
        viewPopup.layer.borderColor = UIColor.blue.cgColor
        viewPopup.layer.cornerRadius = 10
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commentAction(_ sender: Any) {
        commentObject = Comment(user: "Anonymous", rating: self.rating.rating, text: self.comment.text!)
        dismiss(animated: true, completion: nil)
    }
    
}
