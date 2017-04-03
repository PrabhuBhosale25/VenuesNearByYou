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
        @IBOutlet weak var venueTable: UITableView!
        var venueObjects : [Venue] = []

        func determineDeviceCurrentLocation() {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestWhenInUseAuthorization()
                
                if CLLocationManager.locationServicesEnabled() {
                        locationManager.startUpdatingLocation()
                }
        }
        
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
                        if result.count > 0
                        {
                                self.venueObjects = result
                                self.venueTable.reloadData()
                        }
                }) { (error) in
                        
                }
        }
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
        }
        
        
}

extension VenueList : CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate
{
        //MARK : Location manage delegate
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
        
        //MARK : Tableview data source
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
               return self.venueObjects.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cellReuseIdentifier: String = "VenueCell"
                let venue : Venue = venueObjects[indexPath.row]
                var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
                if (cell == nil) {
                        cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:cellReuseIdentifier)
                }
                cell!.textLabel!.text = venue.name
                cell?.detailTextLabel?.text =  String(venue.distance)
                return cell!
        }
}

