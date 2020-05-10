//
//  LocationUpdate.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/12/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import Foundation
import SwiftUI
import CoreLocation
import Combine
import KeychainAccess
class LocationUpdate: NSObject,ObservableObject {
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void,Never>()
    private let geocoder = CLGeocoder()
    
    @Published var placemark: CLPlacemark? /*{
      willSet { objectWillChange.send() }
    }*/
    
    @Published var status: CLAuthorizationStatus? /*{
      willSet { objectWillChange.send() }
    }*/
    
    @Published var location: CLLocation? /*{
       didSet {
            objectWillChange.send()
        }
    }*/
    var statusString: String {
        switch status {
            case .notDetermined: return "notDetermined"
            case .authorizedWhenInUse: return "authorizedWhenInUse"
            case .authorizedAlways: return "authorizedAlways"
            case .restricted: return "restricted"
            case .denied: return "denied"
            default: return "unknown"
        }
    }
    override init() {
      super.init()
      self.locationManager.delegate = self
      self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
      self.locationManager.requestWhenInUseAuthorization()
      self.locationManager.distanceFilter = 1000
      self.locationManager.startUpdatingLocation()
    }
    private func geocode() {
      guard let location = self.location else { return }
      let keychain = Keychain(service: "ISOWEB.JouleBookUI")
      geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
        if error == nil {
          self.placemark = places?[0]
            /*open var name: String? { get } // eg. Apple Inc.
             
            open var thoroughfare: String? { get } // street name, eg. Infinite Loop

            open var subThoroughfare: String? { get } // eg. 1

            open var locality: String? { get } // city, eg. Cupertino

            open var subLocality: String? { get } // neighborhood, common name, eg. Mission District

            open var administrativeArea: String? { get } // state, eg. CA

            open var subAdministrativeArea: String? { get } // county, eg. Santa Clara

            open var postalCode: String? { get } // zip code, eg. 95014

            open var isoCountryCode: String? { get } // eg. US

            open var country: String? { get } // eg. United States**/
            /*self.placemark?.postalCode
            self.placemark?.locality //city
            self.placemark?.administrativeArea //state
            location.coordinate.latitude
            location.coordinate.longitude*/
            var addressObj = AddressObj()
            addressObj.address_name  = self.placemark?.name ?? ""
            addressObj.city = self.placemark?.locality ?? ""
            addressObj.state = self.placemark?.administrativeArea ?? ""
            debugPrint("Location Updated: ","\(String(location.coordinate.latitude)), ","\(String(location.coordinate.longitude))")
            do {
                try keychain.set("\(String(location.coordinate.latitude))", key: "current_lat")
                try keychain.set("\(String(location.coordinate.longitude))", key: "current_lon")
            }
            catch let error {
                print(error)
            }
            addressObj.latitude = String(location.coordinate.latitude)
            addressObj.longitude = String(location.coordinate.longitude)
            
            addressObj.zip_code = self.placemark?.postalCode ?? ""
            addressObj.address = addressObj.getFullAddress()
            let defaultDddress = try! keychain.getString("default_address") ?? ""
            if(defaultDddress == ""){
                do {
                    let jsonData = try! JSONEncoder().encode(addressObj)
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    print("JSON String : " + jsonString!)
                    try keychain.set(jsonString ?? "", key: "default_address")
                }
                catch let error {
                    print(error)
                }
            }
        } else {
          self.placemark = nil
        }
      })
    }
}
extension LocationUpdate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
    }
}
extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
