//
//  View.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/20/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation

import SwiftUI
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
