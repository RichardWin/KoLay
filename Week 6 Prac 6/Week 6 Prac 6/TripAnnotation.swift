//
//  TripAnnotation.swift
//  Week 6 Prac 6
//
//  Created by RICHARD THANT WIN HTET on 27/04/2017.
//  Copyright © 2017 RICHARD THANT WIN HTET. All rights reserved.
//

import UIKit
import MapKit

class TripAnnotation : NSObject, MKAnnotation {
    var tripId : Int
    var title : String?
    var subtitle : String?
    var coordinate: CLLocationCoordinate2D
    var img : UIImage?
    
    init(tripId : Int, trip : Trip , coordinate : CLLocationCoordinate2D){
        self.tripId = tripId
        self.title = trip.tripDestination
        self.subtitle = "\(trip.tripDate)"
        self.coordinate = coordinate
        self.img = trip.destinationImage
    }

}
