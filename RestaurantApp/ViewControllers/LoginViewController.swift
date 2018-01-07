//
//  LoginViewController.swift
//  RestaurantApp
//
//  Created by Admin on 27/12/17.
//  Copyright © 2017 Niels. All rights reserved.
//
import UIKit
import Foundation
import Firebase
import FirebaseAuth
import RealmSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Check if logged in
        if Auth.auth().currentUser == nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Start")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if logged in
        if Auth.auth().currentUser == nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Start")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check if logged in
        if Auth.auth().currentUser == nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Start")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {

            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully logged in")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Start")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
}

// Put this piece of code anywhere you like
// https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


