//
//  StaticStrings.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/1/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import SwiftUI

let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}
extension Formatter {
    //, .withFractionalSeconds
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime])
    static let iso8601withDateOnly = ISO8601DateFormatter([.withFullDate])
}

extension String{
    public static let  s3asseturl = "https://joulebook.s3.us-west-2.amazonaws.com/"
    public static let utcDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    public static let utcDateFormat = "yyyy-MM-dd"
    public static let localDateTimeFormat = "MM/dd/yyyy HH:mm a"
    public static let localDateFormat = "MM/dd/yyyy"
    public static let localTimeFormat = "HH:mm a"
    public static let utcTimeFormat = "HH:mm:ss"
    public static let rsapublickey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFjOHrK7zBkY9biyIuKj+Ze3ljIXX2wnsuTPCsjQRlXLEGgLTGlqs+Bc+8FrkCmVMeSru0JPv0mXuhB19AdeXQO4jplPeo4hWQkiL/UjtUEbMNN4H/hgQH0yDzIFFPL0LvzqXDZLjq88KL/sfYVBtsXxNYP9naPLdzKCXX574s3QIDAQAB"
}
extension String {
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
    var iso8601withDateOnly: Date? { return Formatter.iso8601withDateOnly.date(from: self) }
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
    func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    func toLocalAmPmTime() -> String{
        let timeArr = self.components(separatedBy: ":")
        let hour = Int(timeArr[0]) ?? 0
        let mins = Int(timeArr[1]) ?? 0
        return (hour <= 12) ? ((hour < 10 ) ? "0\(hour):\(mins) am" : "\(hour):\(mins) am") : ((hour < 10 ) ? "0\(hour):\(mins) pm" : "\(hour):\(mins) pm")
    }
    func localTimeSlotToDate() -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = String.utcDateTimeFormat
        let localDateTimeStr = Date().toLocalDateStr() + " "+self
        return localDateTimeStr.localDateStrToDate()
    }
    func utcDateTimeStrToDate() -> Date{
        
        /*let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = String.utcDateTimeFormat
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        debugPrint("UTCDATETIME",self," - >>>>", formatter.date(from: self))*/
        debugPrint("UTCDATETIME - /Constants/StacticStrings ",self)
        guard let date = self.iso8601withFractionalSeconds else {
          preconditionFailure("Take a look to your format")
        }
        return date
        //return (!self.isEmpty) ? formatter.date(from: self) ?? Date() : Date()
    }
    func utcDateStrToDate() -> Date{
        guard let date = self.iso8601withDateOnly else {
          preconditionFailure("Take a look to your format")
        }
        return date
        /*let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = String.utcDateFormat
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return (!self.isEmpty) ? formatter.date(from: self) ?? Date() : Date()*/
    }
    func localDateTimeStrToDate() -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = String.localDateTimeFormat
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        //return (!self.isEmpty) ? formatter.date(from: self) ?? Date() : Date()
        guard let date = formatter.date(from: self) else {
          preconditionFailure("Take a look to your format")
        }
        return date
    }
    func localDateStrToDate() -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = String.localDateFormat
        guard let date = formatter.date(from: self) else {
          preconditionFailure("Take a look to your format")
        }
        return date
    }
}

/*
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
extension View {
    func dismissKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}*/
