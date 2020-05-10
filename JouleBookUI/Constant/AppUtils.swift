//
//  AppUtils.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/16/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import SwiftUI
import GoogleMaps
struct AppUtils {
    func locationWithBearing(bearing:Double, distanceMeters:Double, origin:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let distRadians = distanceMeters / (6372797.6)
        let rbearing = bearing * .pi / 180.0
        let lat1 = origin.latitude * .pi / 180
        let lon1 = origin.longitude * .pi / 180
        let lat2 = asin(sin(lat1) * cos(distRadians) + cos(lat1) * sin(distRadians) * cos(rbearing))
        let lon2 = lon1 + atan2(sin(rbearing) * sin(distRadians) * cos(lat1), cos(distRadians) - sin(lat1) * sin(lat2))
        return CLLocationCoordinate2D(latitude: lat2 * 180 / .pi, longitude: lon2 * 180 / .pi)
    }
}
extension Dictionary {
    init<S>(_ values: S, uniquelyKeyedBy keyPath: KeyPath<S.Element, Key>) where S : Sequence, S.Element == Value {
        let keys = values.map { $0[keyPath: keyPath] }

        self.init(uniqueKeysWithValues: zip(keys, values))
    }
}

// Unordered example
extension Sequence {
    func merge<T: Sequence, U: Hashable>(mergeWith: T, uniquelyKeyedBy: KeyPath<T.Element, U>) -> [Element] where T.Element == Element {
        let dictOld = Dictionary(self, uniquelyKeyedBy: uniquelyKeyedBy)
        let dictNew = Dictionary(mergeWith, uniquelyKeyedBy: uniquelyKeyedBy)

        return dictNew.merging(dictOld, uniquingKeysWith: { old, new in old }).map { $0.value }
    }
}

// Ordered example
extension Array {
    mutating func mergeWithOrdering<U: Hashable>(mergeWith: Array, uniquelyKeyedBy: KeyPath<Array.Element, U>) {
        let dictNew = Dictionary(mergeWith, uniquelyKeyedBy: uniquelyKeyedBy)

        for (key, value) in dictNew {
            guard let index = firstIndex(where: { $0[keyPath: uniquelyKeyedBy] == key }) else {
                append(value)
                continue
            }

            self[index] = value
        }
    }
}
