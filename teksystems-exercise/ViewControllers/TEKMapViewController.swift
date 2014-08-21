//
//  TEKMapViewController.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-20.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import QuartzCore

class TEKMapViewController: UIViewController, MKMapViewDelegate, UIScrollViewDelegate, CLLocationManagerDelegate {
    
    let heightOfExposedMapView: CGFloat = 200
    
    let locationManager = CLLocationManager()
    
    var mapview: MKMapView?
    var mapViewBottomBorder = CALayer()
    
    var tableview: UITableView?
    
    var dummyView: UIView?
    
    var isFullscreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Places"
        self.navigationController.navigationBar.translucent = false
        
        // Setup + button (top-right)
        var addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonPressed")
        self.navigationItem.rightBarButtonItem = addButton
        
        setupMapView()
        setupTableView()
    }
    
    func addButtonPressed() {
        
    }

    func setupMapView() {
        mapview = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        mapview!.delegate = self
        
        // Add a bottom border to the mapView to separate it from the tableView
        var bottomBorderThickness: CGFloat = 1
        mapViewBottomBorder.frame = CGRect(x: 0, y: heightOfExposedMapView-bottomBorderThickness, width: self.view.frame.width, height: bottomBorderThickness)
        mapViewBottomBorder.backgroundColor = UIColor.lightGrayColor().CGColor
        mapview!.layer.addSublayer(mapViewBottomBorder)
        
        // We need a CLLocationManager in iOS 8 to request location authorization before we can set showsUserLocation = true
        locationManager.delegate = self
        // This API call does not exist in iOS < 8, so check before you call it
        if (locationManager.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            // If not in iOS8, we can just call this right away
            mapview!.showsUserLocation = true
        }
        
        self.view.addSubview(mapview)
        
        // When the mapView is tapped, go fullscreen. Use a dummy view for this, because the mapView has userInteractionEnabled set to 'false'
        dummyView = UIView(frame: mapview!.frame)
        var singleTap = UITapGestureRecognizer(target: self, action: "goFullscreen")
        dummyView!.addGestureRecognizer(singleTap)
        
        self.view.addSubview(dummyView)
        
        println(mapview!.centerCoordinate.latitude)
        println(mapview!.centerCoordinate.longitude)
    }
    
    func setupTableView() {
        tableview = UITableView(frame: CGRect(x: 0, y: heightOfExposedMapView, width: self.view.frame.width, height: self.view.frame.height-heightOfExposedMapView+50))
        tableview!.delegate = self
        tableview!.showsVerticalScrollIndicator = false
        
        self.view.addSubview(tableview)
    }
    
    func goFullscreen() {
        if (!isFullscreen) {
            // First, hide the custom border we have drawn over the mapView
            // We use removeFromSuperLayer first because modifying 'hidden' or 'opacity' seems to be animated by default...
            mapViewBottomBorder.removeFromSuperlayer()
            mapViewBottomBorder.hidden = true
            
            // Next, animate the tableView dropping down out of sight
            setTableViewYTo(self.view.frame.height, onComplete: {
                didFinish in
                if (didFinish) {
                    self.isFullscreen = true
                }
                })
            
            // Lastly, give us a back button to exit fullscreen mode
            var backButton = UIBarButtonItem(title: "Close", style: .Bordered, target: self, action: "exitFullscreen")
            self.navigationItem.leftBarButtonItem = backButton
            
            // One more thing... Disable the dummyView so it doesn't intercept touches over the map when in fullscreen
            self.dummyView!.userInteractionEnabled = false
        }
    }
    
    func exitFullscreen() {
        if (isFullscreen) {
            // Bring the tableView back to its original position
            setTableViewYTo(heightOfExposedMapView, onComplete: {
                didFinish in
                if (didFinish) {
                    self.isFullscreen = false
                    
                    // Show the mapView's bottom Border again
                    self.mapview!.layer.addSublayer(self.mapViewBottomBorder)
                    self.mapViewBottomBorder.hidden = false
                }
                })
            
            // Hide the back button when not in fullscreen mode
            self.navigationItem.leftBarButtonItem = nil
            
            // Re-enable the gestureRecognizer on the dummyView
            self.dummyView!.userInteractionEnabled = true
        }
    }
    
    func setTableViewYTo(newY: CGFloat, onComplete: (Bool) -> ()) {
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: nil, animations: { self.tableview!.frame.origin.y = newY }, completion: onComplete)
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        
    }
    
    // In iOS8, need to wait until user has authorized location before calling showsUserLocation = true
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == .AuthorizedWhenInUse) {
            mapview!.showsUserLocation = true
        }
    }
    
}
