//
//  DateFunc.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/19/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

extension Date {
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
    var iso8601withDateOnly: String { return Formatter.iso8601withDateOnly.string(from: self) }
    func getMonth()-> Int{
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    /// Returns the amount of years from another date
    func dayOfWeeksBetweenDatesStr(type: String, to toDate: Date) -> String{
        var dayOfWeeks: String = ""
        var date = self
        var calendar = Calendar.current
        calendar.timeZone = ((type == "utc") ? TimeZone(abbreviation: "UTC") : TimeZone.current)!
        while date <= toDate {
            guard let newDate = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            
            let dayOfWeek = newDate.toDayOfWeek(type: type)
            //if dayOfWeeks.contains(dayOfWeek) == false {
                dayOfWeeks.append(contentsOf: dayOfWeek)
                dayOfWeeks.append(", ")
           // }
            date = newDate
        }
        return dayOfWeeks
    }
    func dayOfWeeksBetweenDates(type: String, to toDate: Date) -> [String]{
        var dayOfWeeks = [String]()
        var date = self
        var calendar = Calendar.current
        calendar.timeZone = ((type == "utc") ? TimeZone(abbreviation: "UTC") : TimeZone.current)!
        while date <= toDate {
            guard let newDate = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            let dayOfWeek = newDate.toDayOfWeek(type: type)
             //debugPrint("Day Of WEEk ",dayOfWeek)
            if dayOfWeeks.contains(dayOfWeek) == false {
                dayOfWeeks.append(dayOfWeek)
            }
            date = newDate
        }
       
        return dayOfWeeks
    }
    func checkTimeSlotDuration(ortherSlots: [Date], duration: Double) -> Bool{
        let calendar = Calendar.current
        let crrhours = calendar.component(.hour, from: self)
        let crrmins = calendar.component(.minute, from: self)
        let duration1: Double = Double(crrhours) + Double(crrmins)/60
        debugPrint("TimeSlot1: ",self.toUTCDateStr(), duration1)
        for slot in ortherSlots {
            if(slot != self){
                let hours = calendar.component(.hour, from: slot)
                let mins = calendar.component(.minute, from: slot)
                let durationn: Double = Double(hours) + Double(mins)/60
                debugPrint("TimeSlotN: ",slot.toUTCDateStr(), durationn)
                if abs(durationn - duration1) < duration {
                    return false
                }
            }
        }
        return true
    }
    
func toUTCDateTimeStr() -> String{
    return self.iso8601withFractionalSeconds
    /*let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = String.utcDateTimeFormat
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    let dateStr = formatter.string(from: self)
    return dateStr.replacingOccurrences(of: "+0000", with: "Z")*/
}
func toUTCDateStr() -> String{
    return self.iso8601withDateOnly
    /*let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = String.utcDateFormat
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.string(from: self)*/
}
func toLocalDateTimeStr() -> String{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = String.localDateTimeFormat
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    return formatter.string(from: self)
}
func toDayOfWeek(type: String)-> String{
    var calendar = Calendar.current
    calendar.timeZone = ((type == "utc") ? TimeZone(abbreviation: "UTC") : TimeZone.current)!
    
    var dayOfWeek = calendar.component(.weekday, from: self) + 1 - calendar.firstWeekday
   // debugPrint("WEEKDAYS:",calendar.component(.weekday, from: Date()), " -> ", calendar.firstWeekday)
    if dayOfWeek <= 0 {
        dayOfWeek += 7
    }
    switch dayOfWeek {
    case 1:
        return  "SU"
    case 2:
        return  "MO"
    case 3:
        return  "TU"
    case 4:
        return  "WE"
    case 5:
        return  "TH"
    case 6:
        return  "FR"
    case 7:
        return  "SA"
    default:
        return  ""
    }
}
func toLocalTimeStr() -> String{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = String.localTimeFormat
    return formatter.string(from: self)
}
func toUtcTimeStr() -> String{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    //formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = String.utcTimeFormat
    return formatter.string(from: self)
}
func toLocalDateStr() -> String{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = String.localDateFormat
    return formatter.string(from: self)
}
func years(from date: Date) -> Int {
    return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
}
/// Returns the amount of months from another date
func months(from date: Date) -> Int {
    return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
}
/// Returns the amount of weeks from another date
func weeks(from date: Date) -> Int {
    return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
}
/// Returns the amount of days from another date
func days(from date: Date) -> Int {
    return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
}
/// Returns the amount of hours from another date
func hours(from date: Date) -> Int {
    return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
}
/// Returns the amount of minutes from another date
func minutes(from date: Date) -> Int {
    return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
}
/// Returns the amount of seconds from another date
func seconds(from date: Date) -> Int {
    return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
}
/// Returns the amount of nanoseconds from another date
func nanoseconds(from date: Date) -> Int {
    return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
}
/// Returns the a custom time interval description from another date
func offset(from date: Date) -> String {
    var result: String = ""
            if years(from: date)   > 0 { return "\(years(from: date))y"   }
            if months(from: date)  > 0 { return "\(months(from: date))M"  }
            if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
    if seconds(from: date) > 0 { return "\(seconds(from: date))" }
            if days(from: date)    > 0 { result = result + " " + "\(days(from: date)) D" }
            if hours(from: date)   > 0 { result = result + " " + "\(hours(from: date)) H" }
            if minutes(from: date) > 0 { result = result + " " + "\(minutes(from: date)) M" }
           if seconds(from: date) > 0 { return "\(seconds(from: date))" }
    return ""
 }
}
