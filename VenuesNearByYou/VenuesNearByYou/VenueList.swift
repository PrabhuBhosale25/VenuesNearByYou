//
//  VenueList.swift
//  VenuesNearbyYou
//
//  Created by webwerks on 4/3/17.
//  Copyright © 2017 NeoSoftTech. All rights reserved.
//

import UIKit
import CoreLocation

class VenueList: UIViewController {
        
        var locationManager:CLLocationManager!
        
        override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
                self.determineDeviceCurrentLocation()
        }
        
        func callVenueAPI(location : CLLocation)
        {
                var  parameters : Dictionary<String,String> = [:]
                parameters["ll"] = String.init(format: "%f,%f", location.coordinate.latitude, location.coordinate.longitude)
                
                ORWrapper().callWebservice(MethodType.get, param: parameters , path: AppConstants.searchEndPoint, successCompletionHandler: { (result) in
                        
                }) { (error) in
                        
                }
        }
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
        }
        
        
}

extension VenueList : CLLocationManagerDelegate
{
        func determineDeviceCurrentLocation() {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestWhenInUseAuthorization()
                
                if CLLocationManager.locationServicesEnabled() {
                        locationManager.startUpdatingLocation()
                }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let userLocation:CLLocation = locations.first! as CLLocation
                
                manager.stopUpdatingLocation()
                
                print("user latitude = \(userLocation.coordinate.latitude)")
                print("user longitude = \(userLocation.coordinate.longitude)")
                
                self.callVenueAPI(location: userLocation)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
                print("Error in finding users current location \(error)")
        }
}

