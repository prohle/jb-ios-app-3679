//
//  Fonts.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/26/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

extension Font{
    public static let textbody = Font.system(size: 14)
    public static let textheader = Font.system(size: 23)
    public static let texttitle = Font.system(size: 18)
    public static let textsmall = Font.system(size: 11)
    public static let bighomereport = Font.system(size: 30)
}
/*
extension UIFont.TextStyle{
    public static let textbody = UIFont.TextStyle(size:14)
}*/
extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

extension View{
    func getTextFromDate(date: Date!,format: String?) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = (format != "") ? format : "MM-d-yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
}
