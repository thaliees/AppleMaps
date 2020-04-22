//
//  ViewController.swift
//  Maps
//
//  Created by Thaliees on 4/22/20.
//  Copyright © 2020 Thaliees. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var buttonCoordinates: UIButton!
    @IBOutlet weak var buttonAddress: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        latitude.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        longitude.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        address.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @IBAction func openMapsCoordinates(_ sender: UIButton) {
        let lat = latitude.text!
        let lon = longitude.text!
        
        let appleURL = "http://maps.apple.com/?daddr=\(lat),\(lon)"
        UIApplication.shared.open(URL(string:appleURL)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func openMapsAddress(_ sender: UIButton) {
        let geocoder = CLGeocoder()
        let locationString = self.address.text!
        
        geocoder.geocodeAddressString(locationString) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                if let location = placemarks?.first?.location {
                    let query = "?daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)"
                    let path = "http://maps.apple.com/" + query
                    if let appleURL = URL(string: path) {
                        UIApplication.shared.open(appleURL, options: [:], completionHandler: nil)
                        
                    }
                    else { print("Could not construct url") }
                }
                else { print("Could not get a location from the geocode request") }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
            case address:
                buttonAddress.isEnabled = true
                buttonCoordinates.isEnabled = false
                
            default:
                buttonCoordinates.isEnabled = true
                buttonAddress.isEnabled = false
        }
    }
}
