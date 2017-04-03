//
//  VenueListVC.swift
//  VenuesNearbyYou
//
//  Created by webwerks on 4/3/17.
//  Copyright © 2017 NeoSoftTech. All rights reserved.
//

import UIKit
import CoreLocation

class VenueListVC: BaseVC {
        
        var locationManager:CLLocationManager!
        @IBOutlet weak var venueTable: UITableView!
        var venueObjects : [Venue] = []
        
        override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
                self.determineDeviceCurrentLocation()
                
                self.title = "Venues near by You"
        }
        
        func callVenueAPI(location : CLLocation)
        {
                var  parameters : Dictionary<String,String> = [:]
                parameters["ll"] = String.init(format: "%f,%f", location.coordinate.latitude, location.coordinate.longitude)
                print("location parameters \(parameters)")
                ORWrapper().callWebservice(MethodType.get, param: parameters , path: AppConstants.searchEndPoint, successCompletionHandler: { (result) in
                        if result.count > 0
                        {
                                 self.venueObjects = result.sorted(by: { $0.distance < $1.distance })
                                self.venueTable.reloadData()
                                self.removeActivityIndicator()
                        }
                        else
                        {
                                self.showAlertView(message: "Venues not found")
                                self.removeActivityIndicator()
                        }
                }) { (error) in
                        self.showAlertView(message: "Location services are not enabled")
                        self.removeActivityIndicator()
                }
        }
        func redirectToDetailsVC(_ venue : Venue)
        {
                let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "VenueDetailsVC") as! VenueDetailsVC
                detailsVC.selectedVenue = venue
                self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        
        func determineDeviceCurrentLocation()
        {
                self.showActivityIndicator()
                
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestWhenInUseAuthorization()
                
                if CLLocationManager.locationServicesEnabled()
                {
                        locationManager.startUpdatingLocation()
                }
                else
                {
                        self.showAlertView(message: "Location services are not enabled")
                }
        }
        
        override func didReceiveMemoryWarning()
        {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
        }        
}

extension VenueListVC : CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate
{
        //MARK : Location manage delegate
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let userLocation:CLLocation = locations.first! as CLLocation
                
                manager.stopUpdatingLocation()
                
                self.callVenueAPI(location: userLocation)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
                print("Error in finding users current location \(error)")
                self.showAlertView(message: "Location services are failed to get location")
                self.removeActivityIndicator()
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
                cell!.detailTextLabel?.textColor = UIColor.gray
                cell!.detailTextLabel?.text =  String.init(format: "%d meters", venue.distance)  //String(venue.distance)
                return cell!
        }
        
        //MARK : Tableview data source
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
                let venue : Venue = venueObjects[indexPath.row]
                self.redirectToDetailsVC(venue)
         }
}

