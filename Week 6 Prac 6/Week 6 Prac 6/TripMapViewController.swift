//
//  TripMapViewController.swift
//  Week 6 Prac 6
//
//  Created by RICHARD THANT WIN HTET on 27/04/2017.
//  Copyright © 2017 RICHARD THANT WIN HTET. All rights reserved.
//

import UIKit
import MapKit

class TripMapViewController: UIViewController, LocationObserver, MKMapViewDelegate {
    

    @IBOutlet weak var tripsMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.loadTrips()
        self.tripsMap.delegate = self
        
        tripsMap.setCenter(tripsMap.userLocation.coordinate,
                          animated: true)
        
        for i in 0 ... Utilities.trips.count - 1 {
            let trip = Utilities.trips[i]
            
            CLGeocoder().geocodeAddressString(trip.tripDestination, completionHandler: {
                (placeMark, error) in
                let tripLocation = placeMark![0].location?.coordinate
                self.tripsMap.addAnnotation(TripAnnotation(tripId: i, trip: trip, coordinate: tripLocation!))
                }
    )
    }
        LocationService.shared.registerLocationObserver(locationObserver: self)
        // Do any additional setup after loading the view.
}
    
    func locationDidChange(newLocations: [CLLocation]) {
        self.tripsMap.setCenter(newLocations[0].coordinate, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let reuseId = "tripAnnoation"
        
        let tripAnnotation : TripAnnotation? = (annotation as? TripAnnotation)
        if tripAnnotation == nil{
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
           if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView?.image = tripAnnotation?.img
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            annotationView?.canShowCallout = true
        }
        else{
            annotationView!.annotation = tripAnnotation
        }
        return annotationView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
