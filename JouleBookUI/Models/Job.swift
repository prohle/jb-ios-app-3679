//
//  Job.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/26/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation
import Combine
import URLImage
//import ImageStore

struct Job: Identifiable,Hashable, Codable{
    var id:Int
    var name: String
    var imageName:String
    var coordinates:Coordinates
    var category: Int
    var locationCoordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}
