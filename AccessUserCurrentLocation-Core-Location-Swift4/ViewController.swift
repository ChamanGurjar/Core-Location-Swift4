//
//  ViewController.swift
//  AccessUserCurrentLocation-Core-Location-Swift4
//
//  Created by Chaman Gurjar on 05/01/19.
//  Copyright © 2019 Chaman Gurjar. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
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
        print(userLocation)
    }
    
    
}

