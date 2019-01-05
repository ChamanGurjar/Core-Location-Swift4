//
//  ViewController.swift
//  AccessUserCurrentLocation-Core-Location-Swift4
//
//  Created by Chaman Gurjar on 05/01/19.
//  Copyright © 2019 Chaman Gurjar. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    private let locationManager =  CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationManager()
        
        locationManager.startUpdatingLocation()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        
        getAddressFromLocation(userLocation)
        
        showUserCurrentLocationOnMap(userLocation)
    }
    
    /** CLGeocoder -> used to get Address from CLLocation
     */
    private func getAddressFromLocation(_ userLocation: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placeMarks, error) in
            if error != nil {
                print("Error in getting Adreess : \(error!)")
            } else {
                if let placeMark  = placeMarks?[0] {
                    print(placeMark)
                    
                    var subThoroughfare = ""
                    if placeMark.subThoroughfare != nil {
                        subThoroughfare = placeMark.subThoroughfare!
                    }
                    
                    var thoroughfare = ""
                    if placeMark.thoroughfare != nil {
                        thoroughfare = placeMark.thoroughfare!
                    }
                    
                    var subLocality = ""
                    if placeMark.subLocality != nil {
                        subLocality = placeMark.subLocality!
                    }
                    
                    var subAdministrativeArea = ""
                    if placeMark.subAdministrativeArea != nil {
                        subAdministrativeArea = placeMark.subAdministrativeArea!
                    }
                    
                    var postalCode = ""
                    if placeMark.postalCode != nil {
                        postalCode = placeMark.postalCode!
                    }
                    
                    var country = ""
                    if placeMark.country != nil {
                        country = placeMark.country!
                    }
                    
                    print(subThoroughfare + " " + thoroughfare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country)
                }
            }
        }
    }
    
    private func showUserCurrentLocationOnMap(_ userLocation: CLLocation) {
        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude
        
        let letDelta: CLLocationDegrees = 0.05
        let longDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: letDelta, longitudeDelta: longDelta)
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
        
        showAnnotationOnUserCurrentLocation(coordinates)
    }
    
    private func showAnnotationOnUserCurrentLocation(_ coordinates: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = "Currently you are here!"
        annotation.subtitle = "\(NSDate())"
        annotation.coordinate = coordinates
        
        map.addAnnotation(annotation)
    }
    
}

