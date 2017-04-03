//
//  Venue.swift
//  VenuesNearbyYou
//
//  Created by webwerks on 4/3/17.
//  Copyright © 2017 NeoSoftTech. All rights reserved.
//

import UIKit
import ObjectMapper

struct Location
{
        var lat : Double = 0
        var lng : Double = 0
}
class Venue: Mappable {
        dynamic var id = ""
        dynamic var name = ""
        dynamic var address = ""
        dynamic var crossStreet = ""
        dynamic var distance = 0
        var location : Location  = Location()

        required convenience init?(map: Map)
        {
                self.init()
        }

        func mapping(map: Map)
        {
                id                      <-      map["id"]
                name                <-      map["name"]
                address            <-      map["address"]
                crossStreet        <-      map["crossStreet"]
                location.lat    <-      map["lat"]
                location.lng   <-       map["lng"]
                distance  <-       map["distance"]
        }
}
