//
//  AppConstants.swift
//  VenuesNearbyYou
//
//  Created by webwerks on 4/3/17.
//  Copyright © 2017 NeoSoftTech. All rights reserved.
//

import UIKit

class AppConstants: NSObject {
        
        struct appInformation
        {
                let APP_NAME = "VenuesNearByYou"
                let CLIENT_ID = "0KZBXSZBMLFI25XQ0VLIOQHHOCW1BK2YNRZTPOOD52YLQMTO"
                let CLIENT_SECRET = "QK2WJLQHVCVEGM3YFNSSDFTS451OPFZSB2W3DFOPMDBOIGD4"
        }
        
        static let baseUrl = "https://api.foursquare.com/v2/"
        static let searchEndPoint = "venues/search/"
        
        class func convertDateInFormat() -> String {
               
                let date = Date()

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                                
                return dateFormatter.string(from: date)
        }
}
