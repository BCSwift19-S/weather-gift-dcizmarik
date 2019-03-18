//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Daniel Cizmarik on 3/1/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import UIKit
import CoreLocation

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0 {
            getLocation()
        }
    }
    
    func updateUserInterface() {
        locationLabel.text = locationsArray[currentPage].name
        dateLabel.text = locationsArray[currentPage].coordinates
    }
    
}

extension DetailVC: CLLocationManagerDelegate {
    
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        handleLocationAuthorizationStatus(status: status)
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("Sorry, location cannot be shown. User has not authorized it.")
        case .restricted:
            print("Access denied.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        var place = ""
        
        currentLocation = locations.last!
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
        let currentCoordinates = "\(currentLatitude),\(currentLongitude)"
        print(currentCoordinates)
        dateLabel.text = currentCoordinates
        
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler:
            {placemarks, error in
                if placemarks != nil {
                    let placemark = placemarks?.last
                    place = (placemark?.name)!
                } else {
                    print("Error retrieving place. Error code \(error!)")
                    place = "Unknown Weather Location"
                }
                self.locationsArray[0].name = place
                self.locationsArray[0].coordinates = currentCoordinates
                self.updateUserInterface()
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location")
    }
    
    
}
