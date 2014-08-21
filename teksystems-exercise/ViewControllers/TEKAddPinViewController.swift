//
//  TEKAddPinViewController.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-21.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit

class TEKAddPinViewController: UIViewController {
    
    var streetTextField: UITextField?
    var cityTextField: UITextField?
    var stateProvinceTextField: UITextField?
    var postalCodeTextField: UITextField?
    var countryTextField: UITextField?
    var descritionTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Pin"
        
        view.backgroundColor = UIColor(red: 0.925, green: 0.941, blue: 0.945, alpha: 1)
        
        // Setup Cancel button (top-left)
        var cancelButton = UIBarButtonItem(title: "Cancel", style: .Bordered, target: self, action: "cancelButtonPressed")
        self.navigationItem.leftBarButtonItem = cancelButton
        
        // Setup Done button (top-right)
        var doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneButtonPressed")
        doneButton.enabled = false
        self.navigationItem.rightBarButtonItem = doneButton
        
        setupTextViews()
    }
    
    func cancelButtonPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func doneButtonPressed() {
        
    }
    
    func setupTextViews() {
        streetTextField = UITextField(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: 44))
        streetTextField!.backgroundColor = UIColor.whiteColor()
        streetTextField!.placeholder = "Street"
        streetTextField!.borderStyle = .RoundedRect
        view.addSubview(streetTextField)
        
        cityTextField = UITextField(frame: CGRect(x: 0, y: 108, width: view.frame.width, height: 44))
        cityTextField!.backgroundColor = UIColor.whiteColor()
        cityTextField!.placeholder = "City"
        cityTextField!.borderStyle = .RoundedRect
        view.addSubview(cityTextField)
        
        stateProvinceTextField = UITextField(frame: CGRect(x: 0, y: 152, width: view.frame.width, height: 44))
        stateProvinceTextField!.backgroundColor = UIColor.whiteColor()
        stateProvinceTextField!.placeholder = "State/Province"
        stateProvinceTextField!.borderStyle = .RoundedRect
        view.addSubview(stateProvinceTextField)
        
        postalCodeTextField = UITextField(frame: CGRect(x: 0, y: 196, width: view.frame.width, height: 44))
        postalCodeTextField!.backgroundColor = UIColor.whiteColor()
        postalCodeTextField!.placeholder = "Postal Code"
        postalCodeTextField!.borderStyle = .RoundedRect
        view.addSubview(postalCodeTextField)
        
        countryTextField = UITextField(frame: CGRect(x: 0, y: 240, width: view.frame.width, height: 44))
        countryTextField!.backgroundColor = UIColor.whiteColor()
        countryTextField!.placeholder = "Country"
        countryTextField!.borderStyle = .RoundedRect
        view.addSubview(countryTextField)
        
        descritionTextField = UITextField(frame: CGRect(x: 0, y: 284, width: view.frame.width, height: 88))
        descritionTextField!.backgroundColor = UIColor.whiteColor()
        descritionTextField!.placeholder = "Description"
        descritionTextField!.borderStyle = .RoundedRect
        view.addSubview(descritionTextField)
    }
    
}
