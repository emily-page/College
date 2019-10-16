//
//  mapViewController.swift
//  colleges
//
//  Created by ios6 on 3/17/17.
//  Copyright © 2017 ios6. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    let locationManager = CLLocationManager()
    var coordinate = CLLocationCoordinate2D()
    var mapCollege : College!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.mapType = .satellite
        mapView.showsCompass = true
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.userLocation.title = "My Location"
        mapView.showsUserLocation = true
        setCenterOfMap(location: coordinate)
        addPin(location: coordinate)
//        let geoCode = CLGeocoder()
//        let address = "Grand Canyon"
//        geoCode.geocodeAddressString(address)
//        { (placemarks, error) in
//            for i in placemarks!
//            {
//                let grandCanyonAnnotation = MKPointAnnotation()
//                grandCanyonAnnotation.coordinate = (i.location?.coordinate)!
//                grandCanyonAnnotation.title = i.name
//                self.mapView.addAnnotation(grandCanyonAnnotation)
//            }
//        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        for i in locations
        {
        print(i)
        }
        print(locationManager.location!)
    }
    
    func setCenterOfMap (location: CLLocationCoordinate2D)
    {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func addPin(location: CLLocationCoordinate2D)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = mapCollege.name
        annotation.subtitle = mapCollege.location
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if annotation is MKUserLocation
        {
            return nil
        }
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView?.canShowCallout = true
            pinView?.image = mapCollege.crest
            let detailButton = UIButton(type: .detailDisclosure) as UIView
            pinView?.rightCalloutAccessoryView = detailButton
            return pinView
    }
}
