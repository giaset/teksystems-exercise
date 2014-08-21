//
//  TEKAddPinViewController.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-21.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit

class TEKAddPinViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Pin"
        
        // Setup Cancel button (top-left)
        var cancelButton = UIBarButtonItem(title: "Cancel", style: .Bordered, target: self, action: "cancelButtonPressed")
        self.navigationItem.leftBarButtonItem = cancelButton
        
        // Setup Done button (top-right)
        var doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneButtonPressed")
        doneButton.enabled = false
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func cancelButtonPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func doneButtonPressed() {
        
    }
    
}
