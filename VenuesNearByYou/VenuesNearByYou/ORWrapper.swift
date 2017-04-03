//
//  ORWrapper.swift
//  VenuesNearbyYou
//
//  Created by webwerks on 4/3/17.
//  Copyright © 2017 NeoSoftTech. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

enum MethodType
{
        case get
        case post
        case put
        case delete
}

class ORWrapper: NSObject {

        func callWebservice(_ method: MethodType, param: Dictionary<String, String>, path : String, successCompletionHandler: @escaping (_ r: [Venue]) -> Void, failureCompletionHandler: @escaping (_ r: Dictionary<String, AnyObject>) -> Void)
        {
                let url = AppConstants.baseUrl + path
                
                var  parameters : Dictionary<String,String> = param
                parameters["ll"]  = "19.021469, 72.842714"
                parameters["client_id"]  = AppConstants.appInformation().CLIENT_ID
                parameters["client_secret"]  = AppConstants.appInformation().CLIENT_SECRET
                parameters["v"]  = AppConstants.convertDateInFormat()
                
                Alamofire.request(url,method: .get, parameters: parameters, encoding: URLEncoding.default) .responseString(completionHandler: { (dataresponse) in
                        
                        let result :  [String: AnyObject]? = self.convertToDictionary(text: dataresponse.value!)
                        if ((result) != nil)
                        {
                                if let meta = result?["meta"] as? Dictionary<String, AnyObject>
                                {
                                        if let code = meta["code"] as? String
                                        {
                                                if code != "200"
                                                {
                                                        print("error \(meta["errorDetail"])")
                                                        failureCompletionHandler(meta)
                                                }
                                                else
                                                {
                                                        if let response = result?["response"] as? Dictionary<String, Any>
                                                        {
                                                                if let venue = response["venue"] as? [Dictionary<String, Any>]
                                                                {
                                                                        let venueObjArray = Mapper<Venue>(context: nil).mapArray(JSONArray: venue)
                                                                        successCompletionHandler(venueObjArray!)
                                                                }
                                                        }
                                                        else
                                                        {
                                                                failureCompletionHandler(meta)
                                                        }
                                                }
                                        }
                                }
                                else
                                {
                                         print("invalid json data")
                                }
                        }
                        else
                        {
                                print("invalid json data")
                        }
                })
        }
}

extension ORWrapper
{
        func convertToDictionary(text: String) -> [String: AnyObject]? {
                if let data = text.data(using: .utf8) {
                        do {
                                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        } catch {
                                print(error.localizedDescription)
                        }
                }
                return nil
        }
}
