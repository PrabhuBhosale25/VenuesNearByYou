//
//  BaseVC.swift
//  VenuesNearByYou
//
//  Created by webwerks on 4/3/17.
//  Copyright © 2017 NeoSoftTech. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
        var activityView = UIActivityIndicatorView()
        var alert = UIAlertController()
        override func viewDidLoad() {
                super.viewDidLoad()
                
                // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
        }
        
        func showActivityIndicator()
        {
                DispatchQueue.main.async {
                        self.activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                        self.activityView.center = self.view.center
                        self.activityView.startAnimating()
                        self.view.addSubview(self.activityView)
                }
        }
        
        func removeActivityIndicator()
        {
                DispatchQueue.main.async {
                        self.activityView.removeFromSuperview()
                }
        }
        
        func showAlertView(message : String)
        {
                alert = UIAlertController(title: "Venues near by You", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
