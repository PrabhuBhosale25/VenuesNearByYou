//
//  VenueDetailsVC.swift
//  VenuesNearByYou
//
//  Created by webwerks on 4/3/17.
//  Copyright © 2017 NeoSoftTech. All rights reserved.
//

import UIKit

class VenueDetailsVC: UIViewController {

        @IBOutlet weak var addressLabel: UILabel!
        var selectedVenue : Venue?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configureUI()
    {
        self.title = self.selectedVenue?.name
        self.addressLabel.numberOfLines = 0
        self.addressLabel.text = (self.selectedVenue?.address)! + "\n" + (self.selectedVenue?.crossStreet)!
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
