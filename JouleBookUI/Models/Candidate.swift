//
//  Candidate.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/20/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation
import Combine
import URLImage

struct Candidate: Identifiable,Hashable, Codable{
    var id:Int
    var name: String
    var attachUrl1: String = ""
    var isInstant: Bool = false
    var rating: CGFloat = 0.00
    var ratingNumber: Int = 0
    var moneyRate: String = ""
    var memberSince: Date = Date()
    var responsiveless: String = ""
    var instantCats: [Int] = []
    var jobComplete: Int = 0
    var currentDeals: Int = 0
    var topSkills: [String] = []
    var aboutUs: String = ""
    var location: String = ""
    var licenseObjs: [ProviderLicense] = []
    var vehicleObjs: [ProviderVehicle] = []
    var skillsOne: [ProviderSkills] = []
    var skillsTwo: [ProviderSkills] = []
    var skillsThree: [ProviderSkills] = []
    var skillsFour: [ProviderSkills] = []
}
struct SimpleCandidate: Identifiable,Hashable, Codable{
    var id:Int
    var attachUrl1: String = ""
}
