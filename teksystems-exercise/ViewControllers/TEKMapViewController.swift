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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupStatusBar()
    }

    func setupMapView() {
        mapview = MKMapView(frame: view.frame)
        mapview!.delegate = self
        mapview!.showsUserLocation = true
        
        view.addSubview(mapview)
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        if (!userLocationHasBeenFound) {
            userLocationHasBeenFound = true
            
            // Zoom and center on user's location
            var region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.setRegion(region, animated: false)
        }
    }
    
    func setupStatusBar() {
        var statusBarHeight: CGFloat = 20
        var statusBar = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: statusBarHeight))
        statusBar.backgroundColor = UIColor.flatCarrotColor()
        statusBar.alpha = 0.85
 
        view.addSubview(statusBar)
    }
    
}
