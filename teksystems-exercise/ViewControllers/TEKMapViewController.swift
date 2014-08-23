//
//  TEKMapViewController.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-20.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit
import MapKit

class TEKMapViewController: UIViewController, MKMapViewDelegate {
    
    var mapview: MKMapView?
    
    var userLocationHasBeenFound = false
    
    var blackOverlayView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Places"
        
        navigationController.navigationBar.translucent = false
        
        setupMapView()
        setupButton()
        setupBlackOverlayView()
    }

    func setupMapView() {
        mapview = MKMapView(frame: view.frame)
        mapview!.delegate = self
        mapview!.showsUserLocation = true
        
        view.addSubview(mapview)
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        // Only run this once
        if (!userLocationHasBeenFound) {
            userLocationHasBeenFound = true
            
            // Zoom and center on user's location
            var region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
            mapView.setRegion(region, animated: false)
        }
    }
    
    func setupButton() {
        let padding = 5
        let buttonHeight = 44
        let statusAndNavBarHeight = 64
        
        var plusButton = FUIButton(frame: CGRect(x: padding, y: Int(view.frame.height)-padding-buttonHeight-statusAndNavBarHeight, width: Int(view.frame.width)-(2*padding), height: buttonHeight))
        plusButton.buttonColor = UIColor.turquoiseColor()
        plusButton.shadowColor = UIColor.greenSeaColor()
        plusButton.shadowHeight = 3
        plusButton.cornerRadius = 6
        plusButton.setTitle("+ ADD ADDRESS", forState: .Normal)
        plusButton.titleLabel.font = UIFont.boldFlatFontOfSize(16)
        plusButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        plusButton.addTarget(self, action: "plusButtonPressed", forControlEvents: .TouchUpInside)
        
        view.addSubview(plusButton)
    }
    
    func plusButtonPressed() {
        setBlackOverlayViewAlphaTo(0.5)
    }
    
    func setupBlackOverlayView() {
        blackOverlayView = UIView(frame: view.frame)
        blackOverlayView!.backgroundColor = UIColor.blackColor()
        blackOverlayView!.alpha = 0
        
        view.addSubview(blackOverlayView)
    }
    
    func setBlackOverlayViewAlphaTo(alpha: CGFloat) {
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: nil, animations: { self.blackOverlayView!.alpha = alpha }, completion: nil)
    }
    
}
