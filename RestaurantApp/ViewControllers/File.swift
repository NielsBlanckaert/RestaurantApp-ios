//
//  File.swift
//  RestaurantApp
//
//  Created by Admin on 7/01/18.
//  Copyright © 2018 Niels. All rights reserved.
//

import UIKit

//Darth Philou: https://stackoverflow.com/questions/25580981/ios8-tabbarcontroller-inside-a-uisplitviewcontroller-master
class CustomSplitViewController: UISplitViewController {
    
    override func showDetailViewController(_ vc: UIViewController, sender: Any!) {
        
        if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact) {
            if let tabBarController = self.viewControllers[0] as? UITabBarController {
                if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                    navigationController.show(vc, sender: sender)
                    return
                }
            }
        }
        
        super.showDetailViewController(vc, sender: sender)
    }
}
