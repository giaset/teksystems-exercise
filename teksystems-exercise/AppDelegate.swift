//
//  AppDelegate.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-20.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit

extension UIColor {
        
        class func amethystColor() -> UIColor {
            return UIColor(red: 0.608, green: 0.349, blue: 0.714, alpha: 1) /*#9b59b6*/
        }
        
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Stylin'
        UINavigationBar.appearance().tintColor = UIColor.amethystColor()

        self.window!.rootViewController = UINavigationController(rootViewController: TEKMapViewController())
        
        self.window!.makeKeyAndVisible()
        return true
    }
    
}

