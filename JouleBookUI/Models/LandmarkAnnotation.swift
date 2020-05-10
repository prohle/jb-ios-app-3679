//
//  LandmarkAnnotation.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/11/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import Foundation
import MapKit

class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
