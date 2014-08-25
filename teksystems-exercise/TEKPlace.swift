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
    
    init(coder decoder: NSCoder!) {
        title = decoder.decodeObjectForKey("title") as String
        subtitle = decoder.decodeObjectForKey("subtitle") as String
        var lat: CLLocationDegrees = decoder.decodeObjectForKey("lat") as CLLocationDegrees
        var lng: CLLocationDegrees = decoder.decodeObjectForKey("lng") as CLLocationDegrees
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        super.init()
    }
    
    func encodeWithCoder(encoder: NSCoder!) {
        encoder.encodeObject(title, forKey: "title")
        encoder.encodeObject(subtitle, forKey: "subtitle")
        encoder.encodeObject(coordinate.latitude, forKey: "lat")
        encoder.encodeObject(coordinate.longitude, forKey: "lng")
    }
    
    init(annotation: MKAnnotation) {
        title = annotation.title!
        subtitle = annotation.subtitle!
        coordinate = annotation.coordinate
        
        super.init()
    }
    
}
