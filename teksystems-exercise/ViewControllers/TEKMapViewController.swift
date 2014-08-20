//
//  TEKMapViewController.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-20.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit

class TEKMapViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Places"
        
        var addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonPressed")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func addButtonPressed() {
        
    }
    
}
