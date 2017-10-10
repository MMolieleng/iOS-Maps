//
//  FirstViewController.swift
//  Kanto
//
//  Created by Mohale MOLIELENG on 2017/10/09.
//  Copyright © 2017 Mohale MOLIELENG. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    let myLocations = [
        Location(title: "42", subTitle:"Ecole trop style", latitude: -26.204938, longitude: 28.040223),
        Location(title: "FNB Bank City",subTitle:"64 Simmonds Street", latitude: -26.202792, longitude: 28.039397),
        Location(title: "Gandi Square",subTitle:"Marshalls Town", latitude: -26.206591, longitude: 28.043453),
        Location(title: "Echlo 42",subTitle:"",latitude: -26.196707, longitude: 28.047314)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.addMarkers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Appeared")
    }
    
    @IBAction func updateMapType(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            mapView.mapType = MKMapType.standard
        }
        else if sender.selectedSegmentIndex == 1{
            mapView.mapType = MKMapType.satellite
        }
        else if sender.selectedSegmentIndex == 2{
            mapView.mapType = MKMapType.hybrid
        }
    }
    
    func showCurrentPin(location: Location){
        
        print(location.title)
        
        let annotation = MKPointAnnotation()
        annotation.title = location.title
        annotation.subtitle = location.subTitle
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        mapView.addAnnotation(annotation)
        
        
        //Zoom to user location
        let noLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
        mapView.setRegion(viewRegion, animated: false)
        
    }
    
    func addMarkers(){
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let coordinates = CLLocationCoordinate2DMake(myLocations[0].latitude, myLocations[0].longitude)
        let region = MKCoordinateRegionMake(coordinates, span)
        mapView.setRegion(region, animated: true)
        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinates
//        annotation.title = "Ecole 42"
//        annotation.subtitle = "Subtitle"
//        mapView.addAnnotation(annotation)
        
        let annotations = myLocations.map { location -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.subtitle = location.subTitle
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            return annotation
        }
        mapView.addAnnotations(annotations)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations[0]
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let myLoc = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        let region = MKCoordinateRegionMake(myLoc, span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func locateUser(_ sender: Any) {
        
        mapView.showsUserLocation = !mapView.showsUserLocation
        locationManager.startUpdatingLocation()
        
        if (mapView.showsUserLocation){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }else{
            addMarkers()
            mapView.updateFocusIfNeeded()
        }
        
        //Zoom to user location
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
        mapView.setRegion(viewRegion, animated: false)
        self.locationManager.startUpdatingLocation()
        print("Location Updating")
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }

    }
    
    
    
    /*func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        
        switch status {
        case .notDetermined:
            print("NotDetermined")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("AuthorizedAlways")
        case .authorizedWhenInUse:
            print("AuthorizedWhenInUse")
            locationManager.startUpdatingLocation()
        }
    }*/
}

struct Location {
    let title: String
    let subTitle: String
    let latitude: Double
    let longitude: Double
}

extension MKPinAnnotationView {
    class func bluePinColor() -> UIColor {
        return UIColor.blue
    }
}

