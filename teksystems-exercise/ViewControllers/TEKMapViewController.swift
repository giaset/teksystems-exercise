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
    
    var popup: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Places"
        
        navigationController.navigationBar.translucent = false
        
        setupMapView()
        setupButton()
        setupBlackOverlayView()
        setupPopup()
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
            var region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100)
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
        setPopupVerticalPositionTo((view.frame.height/2) - (popup!.frame.height/2))
    }
    
    func closeButtonPressed() {
        setBlackOverlayViewAlphaTo(0)
        setPopupVerticalPositionTo(600)
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
    
    func setupPopup() {
        let popupPadding = 20
        let popupHeight = 250
        let popupWidth = Int(view.frame.width)-(2*popupPadding)
        
        popup = UIView(frame: CGRect(x: popupPadding, y: 600, width: popupWidth, height: popupHeight))
        popup!.backgroundColor = UIColor.midnightBlueColor()
        
        let buttonPadding = 10
        let buttonHeight = 44
        let buttonWidth = (popupWidth-(3*buttonPadding))/2
        let buttonY = popupHeight-buttonPadding-buttonHeight
        
        var closeButton = FUIButton(frame: CGRect(x: buttonPadding, y: buttonY, width: buttonWidth, height: buttonHeight))
        closeButton.buttonColor = UIColor.cloudsColor()
        closeButton.shadowColor = UIColor.asbestosColor()
        closeButton.shadowHeight = 3
        closeButton.cornerRadius = 6
        closeButton.setTitle("Close", forState: .Normal)
        closeButton.titleLabel.font = UIFont.boldFlatFontOfSize(16)
        closeButton.setTitleColor(UIColor.asbestosColor(), forState: .Normal)
        closeButton.addTarget(self, action: "closeButtonPressed", forControlEvents: .TouchUpInside)
        popup!.addSubview(closeButton)
        
        var submitButton = FUIButton(frame: CGRect(x: (2*buttonPadding)+buttonWidth, y: buttonY, width: buttonWidth, height: buttonHeight))
        submitButton.buttonColor = UIColor.turquoiseColor()
        submitButton.shadowColor = UIColor.greenSeaColor()
        submitButton.shadowHeight = 3
        submitButton.cornerRadius = 6
        submitButton.setTitle("Submit", forState: .Normal)
        submitButton.titleLabel.font = UIFont.boldFlatFontOfSize(16)
        submitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        submitButton.addTarget(self, action: "submitButtonPressed", forControlEvents: .TouchUpInside)
        popup!.addSubview(submitButton)
        
        view.addSubview(popup)
    }
    
    func setPopupVerticalPositionTo(newY: CGFloat) {
        UIView.animateWithDuration(0.85, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: nil, animations: {
            self.popup!.frame.origin.y = newY
            }, completion: nil)
    }
    
    func submitButtonPressed() {
        
    }
    
}
