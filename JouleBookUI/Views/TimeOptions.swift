//
//  TimeOptions.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
struct TimeOption{
//: Hashable, Identifiable {
    var id: Int = 0
    var index: Int = 0
    var fromDate: RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365),  mode: 0)
    var toDate: RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365),   mode: 0, selectedDate: Date().addingTimeInterval(7*86400))
    var startTimes: [Date]
    var dayOfWeeks: [Int]
    //var test: RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*60),  mode: 0)
}
class TimeOptiona: ObservableObject {
    let objectWillChange = PassthroughSubject<TimeOptiona,Never>()
    var fromDate : Date = Date(){
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    var toDate : Date =  Date(){
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
}
/*RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)*/
struct DayOfWeek: View{
    var text: String
    var val: Int
    @State var isSelected: Bool = false
    @Binding var selectedDays: [Int]
    var body: some View {
        Button(action: {}, label: {
            Text(text).font(.textsmall).fontWeight(.bold).foregroundColor((self.isSelected == false) ? Color.maintext : Color.white).frame(width:18,height:18)
        }).onTapGesture {
            self.isSelected.toggle()
            if self.isSelected == true && !self.selectedDays.contains(self.val) {
                self.selectedDays.append(self.val)
            }else if self.isSelected == false && self.selectedDays.contains(self.val){
                if let index = self.selectedDays.firstIndex(of: self.val) {
                    self.selectedDays.remove(at: index)
                }
            }
        }
        .background((self.isSelected == false) ? Color.border : Color.main)
        .cornerRadius(9)
        .padding(0)
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 3,
                y: 3)
    }
}
struct TimeOptions: View {
    @State var timeOptions: [TimeOption]
    var body: some View {
        VStack(alignment: .leading,spacing: 15){
            Button(action:{}){
                NormalButton(btnText: "+ Time options",fontSize: .textsmall, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00))
            }.onTapGesture {
                let newId: Int = self.timeOptions.count + 1
                self.timeOptions.append(TimeOption(id: newId, index: newId,  startTimes: [Date()], dayOfWeeks: []))
            }
            HStack{
                VStack(alignment:  .leading,spacing: 15) {
                    ForEach(0 ..< self.timeOptions.count, id: \.self) { rowIndex in
                        Group{
                            HStack{
                                TextBody(text: "From: ")
                                DateSelectorModal(monthIndex: 0).environmentObject(self.timeOptions[rowIndex].fromDate)
                                Spacer()
                                TextBody(text: "To: ")
                                DateSelectorModal(monthIndex: 0).environmentObject(self.timeOptions[rowIndex].toDate)
                            }
                            
                            /*HStack{
                                Button(action:{}){
                                    TextBody(text: "Test it")
                                }.onTapGesture {
                                    //let range = self.timeOptions[rowIndex].fromDate.selectedDate...self.timeOptions[rowIndex].toDate.selectedDate
                                    
                                    //print(self.getTextFromDate(date: self.timeOptions[rowIndex].fromDate.selectedDate ))
                                    //print(self.getTextFromDate(date: self.timeOptions[rowIndex].toDate.selectedDate ))
                                }
                                Spacer()
                            }*/
                            //TextBody(text: self.getTextFromDate(date: self.timeOptions[rowIndex].test.selectedDate))
                            /*DatePicker(selection: self.$timeOptions[rowIndex].fromDate, in: ...Date(), displayedComponents: .date){
                                TextBody(text: "From Date")
                            }.font(.textbody).foregroundColor(.maintext)
                            
                            DatePicker(selection: self.$timeOptions[rowIndex].toDate, in: ...Date(), displayedComponents: .date){
                                TextBody(text: "To Date")
                            }.font(.textbody).foregroundColor(.maintext)
                            */
                            HStack{
                                DayOfWeek(text: "S", val: 0,  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks)
                                DayOfWeek(text: "M", val: 1,  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks)
                                DayOfWeek(text: "T", val: 2,  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks)
                                DayOfWeek(text: "W", val: 3,  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks)
                                DayOfWeek(text: "T", val: 4,  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks)
                                DayOfWeek(text: "F", val: 5,  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks)
                                DayOfWeek(text: "S", val: 6,  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks)
                                Spacer()
                                Button(action:{}){
                                    NormalButton(btnText: "+ Add time slot",fontSize: .textsmall, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00))
                                }.onTapGesture {
                                    let calendar = Calendar.current
                                    var matchingDates = [Date]()
                                    let components = DateComponents(hour: 0, minute: 0, second: 0)
                                    calendar.enumerateDates(startingAfter: self.timeOptions[rowIndex].fromDate.selectedDate, matching: components, matchingPolicy: .nextTime) { (date, strict, stop) in
                                        if let date = date {
                                            if date <= self.timeOptions[rowIndex].toDate.selectedDate {
                                                let weekDay = calendar.component(.weekday, from: date)
                                                //print(date, weekDay)
                                                if self.timeOptions[rowIndex].dayOfWeeks.contains(weekDay) == true {
                                                    //selectedWeekdays.append(weekDay)
                                                    matchingDates.append(date)
                                                }
                                            } else {
                                                stop = true
                                            }
                                        }
                                    }
                                    print(matchingDates)
                                    self.timeOptions[rowIndex].startTimes.append(Date())
                                }
                                
                            }.padding(.vertical, 5)
                            TimeSlots(allSlots: self.$timeOptions[rowIndex].startTimes,parentWidth: 360)
                            
                            /*ForEach(0 ..< self.timeOptions.count, id: \.self) { rowIndex in
                                TimeSlots(allSlots: self.$timeOptions[rowIndex].startTimes,parentWidth: 240)
                            }*/
                        }
                    }
                }
                Spacer()
            }.frame(maxWidth: .infinity)
        }
    }
}

struct TimeOptions_Previews: PreviewProvider {
    static var previews: some View {
        TimeOptions(timeOptions: [TimeOption(id: 1, index:1, startTimes: [Date()], dayOfWeeks: [0,2])])
    }
}
