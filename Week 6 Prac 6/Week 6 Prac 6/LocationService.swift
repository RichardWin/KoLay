//
//  LocationService.swift
//  Week 6 Prac 6
//
//  Created by RICHARD THANT WIN HTET on 27/04/2017.
//  Copyright © 2017 RICHARD THANT WIN HTET. All rights reserved.
//

import Foundation
import MapKit

protocol LocationObserver{
    func locationDidChange (newLocations : [CLLocation])
}

class LocationService: NSObject, CLLocationManagerDelegate {
    var locationObservers : [LocationObserver] = []
    var locationManager = CLLocationManager.init()
    static let shared: LocationService = LocationService()
    
    override private init(){
        super.init()
        locationManager.desiredAccuracy = 100
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func registerLocationObserver(locationObserver : LocationObserver) {
        locationObservers.append(locationObserver)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        for observer in locationObservers{
            observer.locationDidChange(newLocations: locations)
        }
    }
}
