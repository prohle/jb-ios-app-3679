//
//  Colors.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import SwiftUI
extension Color {
    public static let main = Color(red: 254 / 255, green: 87 / 255, blue: 34 / 255)
    public static let textlink =  Color(red: 11 / 255, green: 118 / 255, blue: 204 / 255)
    public static let maintext =  Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255)
    public static let placeholder =  Color(red: 196 / 255, green: 196 / 255, blue: 196 / 255)
    public static let subtext =  Color(red: 128 / 255, green: 128 / 255, blue: 128 / 255)
    public static let instant =  Color(red: 57 / 255, green: 181 / 255, blue: 74 / 255)
    public static let mainback =  Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255)
    public static let border =  Color(red: 208 / 255, green: 208 / 255, blue: 208 / 255)
}
extension Color {

    func uiColor() -> UIColor {

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}
