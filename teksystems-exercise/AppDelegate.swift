//
//  AppDelegate.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-20.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Stylin'
        UINavigationBar.appearance().barTintColor = UIColor.sunflowerColor()

        self.window!.rootViewController = UINavigationController(rootViewController: TEKMapViewController())
        
        self.window!.makeKeyAndVisible()
        return true
    }
    
}

