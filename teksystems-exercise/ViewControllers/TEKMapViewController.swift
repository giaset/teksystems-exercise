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
    var tableview: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Places"
        self.navigationController.navigationBar.translucent = false
        
        // Setup + button (top-right)
        var addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonPressed")
        self.navigationItem.rightBarButtonItem = addButton
        
        // Setup location manager
        locationManager.delegate = self
        // This API call does not exist in iOS < 8, so check before you call it
        if (locationManager.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        
        setupMapView()
        setupTableView()
    }
    
    func addButtonPressed() {
        
    }
    
    func setupMapView() {
        mapview = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        mapview!.scrollEnabled = false
        mapview!.zoomEnabled = false
        mapview!.userInteractionEnabled = false
        mapview!.delegate = self
        mapview!.showsUserLocation = true
        
        // Add a bottom border to the mapView to separate it from the tableView
        var bottomBorder = CALayer()
        var bottomBorderThickness: CGFloat = 1
        bottomBorder.frame = CGRect(x: 0, y: heightOfExposedMapView-bottomBorderThickness, width: self.view.frame.width, height: bottomBorderThickness)
        bottomBorder.backgroundColor = UIColor.lightGrayColor().CGColor
        mapview!.layer.addSublayer(bottomBorder)
        
        self.view.addSubview(mapview)
    }
    
    func setupTableView() {
        tableview = UITableView(frame: CGRect(x: 0, y: heightOfExposedMapView, width: self.view.frame.width, height: self.view.frame.height-heightOfExposedMapView))
        tableview!.delegate = self
        tableview!.showsVerticalScrollIndicator = false
        
        self.view.addSubview(tableview)
    }
    
}
