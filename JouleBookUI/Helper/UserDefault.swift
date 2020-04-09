//
//  UserDefault.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/28/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import Foundation
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        } set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
