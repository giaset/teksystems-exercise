//
//  TEKPlace.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-25.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import Foundation
import MapKit

class TEKPlace: NSObject, NSCoding {
    
    var title: String
    var subtitle: String
    var coordinate: CLLocationCoordinate2D
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(subtitle, forKey: "subtitle")
        aCoder.encodeObject(coordinate.latitude, forKey: "lat")
        aCoder.encodeObject(coordinate.longitude, forKey: "lng")
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("title") as String
        subtitle = aDecoder.decodeObjectForKey("subtitle") as String
        var lat: CLLocationDegrees = aDecoder.decodeObjectForKey("lat") as CLLocationDegrees
        var lng: CLLocationDegrees = aDecoder.decodeObjectForKey("lng") as CLLocationDegrees
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        super.init()
    }
    
    init(annotation: MKAnnotation) {
        title = annotation.title!
        subtitle = annotation.subtitle!
        coordinate = annotation.coordinate
        
        super.init()
    }
    
}
