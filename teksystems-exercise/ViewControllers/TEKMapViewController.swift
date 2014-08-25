//
//  TEKMapViewController.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-20.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit
import MapKit

class TEKMapViewController: UIViewController, MKMapViewDelegate, UIActionSheetDelegate {
    
    var mapview: MKMapView?
    
    var userLocationHasBeenFound = false
    
    var blackOverlayView: UIView?
    
    var popup: UIView?
    var addressTextField: FUITextField?
    var descriptionTextField: FUITextField?
    
    var selectedAnnotation: MKAnnotation?
    
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
        plusButton.addTarget(self, action: "openPopup", forControlEvents: .TouchUpInside)
        
        view.addSubview(plusButton)
    }
    
    func openPopup() {
        // make sure textfields are cleared
        addressTextField!.text = ""
        descriptionTextField!.text = ""
        
        setBlackOverlayViewAlphaTo(0.5)
        
        setPopupVerticalPositionTo(60) // meh, just guessed a value to center the popup between navbar and keyboard...
        addressTextField!.becomeFirstResponder()
    }
    
    func closePopup() {
        setBlackOverlayViewAlphaTo(0)
        setPopupVerticalPositionTo(600)
        view.endEditing(true)
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
        let buttonPadding = 10
        let popupPadding = 20
        
        let buttonHeight = 44
        let popupHeight = (4*buttonPadding)+(3*buttonHeight)
        
        let popupWidth = Int(view.frame.width)-(2*popupPadding)
        
        popup = UIView(frame: CGRect(x: popupPadding, y: 600, width: popupWidth, height: popupHeight))
        popup!.backgroundColor = UIColor.midnightBlueColor()
        
        let buttonWidth = (popupWidth-(3*buttonPadding))/2
        let buttonY = popupHeight-buttonPadding-buttonHeight
        
        /* STREET/CITY/PROVINCE TEXTFIELD*/
        var addressField = FUITextField(frame: CGRect(x: buttonPadding, y: buttonPadding, width: buttonPadding+(buttonWidth*2), height: buttonHeight))
        addressField.textFieldColor = UIColor.whiteColor()
        addressField.textColor = UIColor.asbestosColor()
        addressField.placeholder = "Street, City, Province"
        addressField.edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addressField.font = UIFont.flatFontOfSize(14)
        addressField.autocorrectionType = .No
        addressTextField = addressField
        popup!.addSubview(addressField)
        
        /* DESCRIPTION TEXTFIELD*/
        var descriptionField = FUITextField(frame: CGRect(x: buttonPadding, y: (2*buttonPadding)+buttonHeight, width: buttonPadding+(buttonWidth*2), height: buttonHeight))
        descriptionField.textFieldColor = UIColor.whiteColor()
        descriptionField.textColor = UIColor.asbestosColor()
        descriptionField.placeholder = "Description"
        descriptionField.edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        descriptionField.font = UIFont.flatFontOfSize(14)
        descriptionField.autocorrectionType = .No
        descriptionTextField = descriptionField
        popup!.addSubview(descriptionField)
        
        /* CLOSE BUTTON */
        var closeButton = FUIButton(frame: CGRect(x: buttonPadding, y: buttonY, width: buttonWidth, height: buttonHeight))
        closeButton.buttonColor = UIColor.cloudsColor()
        closeButton.shadowColor = UIColor.asbestosColor()
        closeButton.shadowHeight = 3
        closeButton.cornerRadius = 6
        closeButton.setTitle("Close", forState: .Normal)
        closeButton.titleLabel.font = UIFont.boldFlatFontOfSize(16)
        closeButton.setTitleColor(UIColor.asbestosColor(), forState: .Normal)
        closeButton.addTarget(self, action: "closePopup", forControlEvents: .TouchUpInside)
        popup!.addSubview(closeButton)
        
        /* SUBMIT BUTTON */
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
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: nil, animations: {
            self.popup!.frame.origin.y = newY
            }, completion: nil)
    }
    
    func submitButtonPressed() {
        closePopup()
        
        var geocodoer = CLGeocoder()
        
        geocodoer.geocodeAddressString(addressTextField!.text, completionHandler: {
            (placemarks: AnyObject[]!, err: NSError!) in
            if (!err) {
                var placemarksArray = placemarks as NSArray
                if (placemarksArray.count > 0) {
                    var topResult = placemarksArray.objectAtIndex(0) as CLPlacemark
                    var mapPlacemark = MKPlacemark(placemark: topResult)
                    
                    // Create a MKPointAnnotation from this placemark, so that we can set custom title
                    var pointAnnotation = MKPointAnnotation()
                    pointAnnotation.coordinate = mapPlacemark.coordinate
                    if (self.descriptionTextField!.text == "") {
                        pointAnnotation.title = "Untitled Place"
                    } else {
                        pointAnnotation.title = self.descriptionTextField!.text
                    }
                    pointAnnotation.subtitle = mapPlacemark.title
                    
                    // Zoom and center on new pin
                    var region = MKCoordinateRegionMakeWithDistance(pointAnnotation.coordinate, 100, 100)
                    self.mapview!.addAnnotation(pointAnnotation)
                    self.mapview!.setRegion(region, animated: true)
                }
            } else {
                self.popError(err)
            }
            })
    }
    
    func popError(error: NSError!) {
        // Legacy support for UIAlertViews, which are deprecated starting in iOS8
        var errorAlert = UIAlertView()
        errorAlert.title = "Error"
        errorAlert.message = error.description
        errorAlert.addButtonWithTitle("Ok")
        
        errorAlert.show()
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        // Don't override user location blue dot
        if (annotation.isKindOfClass(MKUserLocation)) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("Annotation")
        if (!annotationView) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Annotation")
        }
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIButton
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        selectedAnnotation = view.annotation
        
        var actionSheet = UIActionSheet()
        actionSheet.delegate = self
        
        actionSheet.addButtonWithTitle("Share Place")
        actionSheet.destructiveButtonIndex = actionSheet.addButtonWithTitle("Delete Place")
        actionSheet.cancelButtonIndex = actionSheet.addButtonWithTitle("Cancel")
        
        actionSheet.showInView(view)
    }
    
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0: // share
            var stringToShare = selectedAnnotation!.title!+" ("+selectedAnnotation!.subtitle!+") - "+selectedAnnotation!.coordinate.latitude+", "+selectedAnnotation!.coordinate.longitude
            var activityVC = UIActivityViewController(activityItems: [stringToShare], applicationActivities: nil)
            presentViewController(activityVC, animated: true, completion: nil)
        case 1: // delete
            mapview!.removeAnnotation(selectedAnnotation)
        case 2: // cancel
            break
        default:
            break
        }
    }
    
}
