//
//  TimeOptions.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine

struct SpecificTimeOptions: View {
    @Binding var timeOptions: [SpecificTimeOption]
    @Binding var duration: Double
    //@Binding var executionType: Int
    var body: some View {
        VStack(alignment: .leading,spacing: 15){
            Button(action:{}){
                NormalButton(btnText: "+ Time options",fontSize: .textsmall, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00))
            }.onTapGesture {
                let newId: Int = self.timeOptions.count + 1
                self.timeOptions.append(SpecificTimeOption(id: newId,  startTimes: [Date()]))
            }
            HStack{
                VStack(alignment:  .leading,spacing: 15) {
                    ForEach(0 ..< self.timeOptions.count, id: \.self) { rowIndex in
                        Group{
                            DateSelectorModal(monthIndex: 0).environmentObject(self.timeOptions[rowIndex].dealDate)
                            //if self.executionType == 2 {
                                Button(action:{}){
                                    NormalButton(btnText: "+ Add time slot",fontSize: .textsmall, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00))
                                }.onTapGesture {
                                    self.timeOptions[rowIndex].startTimes.append(Date())
                                }
                            //}
                            TimeSlots(allSlots: self.$timeOptions[rowIndex].startTimes,duration: self.$duration,parentWidth: 360)
                        }
                    }
                }
            }
        }
    }
}
struct DayOfWeekViewOnly: View{
    var text: String
    var val: String
    var selectedDays: [String]
    var body: some View {
        VStack{
            Text(text)
                .font(.textsmall)
                .fontWeight(.bold)
                .foregroundColor((self.selectedDays.count > 0 && self.selectedDays.contains(self.val)) ? Color.maintext : Color.white)
                .frame(width:20,height:20)
                .background((self.selectedDays.count > 0 && self.selectedDays.contains(self.val)) ? Color.main : Color.border)
                .cornerRadius(10)
                .padding(0)
                .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
        }
    }
}
struct DayOfWeek: View{
    var text: String
    var val: String
    @State var isSelected: Bool = false
    @Binding var selectedDays: [String]
    var isClickable: Bool
    var body: some View {
        VStack{
            if isClickable == true {
                //Button(action: {}, label: {
                    Text(text)
                        .font(.textsmall)
                        .fontWeight(.bold)
                        .foregroundColor((self.isSelected == false) ? Color.maintext : Color.white)
                        .frame(width:18,height:18)
                        .onTapGesture {
                            self.isSelected.toggle()
                            if self.isSelected == true && (self.selectedDays.count <= 0 || !self.selectedDays.contains(self.val)) {
                                self.selectedDays.append(self.val)
                            }else if self.isSelected == false && (self.selectedDays.count > 0 && self.selectedDays.contains(self.val)) {
                                if let index = self.selectedDays.firstIndex(of: self.val) {
                                    self.selectedDays.remove(at: index)
                                }
                            }
                        }.background((self.isSelected == false) ? Color.border : Color.main)
                        .cornerRadius(9)
                        .padding(0)
                        .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                /*}).onTapGesture {
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
                        y: 3)*/
            }else{
                Text(text).font(.textsmall).fontWeight(.bold).foregroundColor((self.isSelected == false) ? Color.maintext : Color.white).frame(width:18,height:18).background(Color.placeholder)
                .cornerRadius(9)
                .padding(0)
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            }
        }
    }
}
/*@State var monthIndex: Int
@EnvironmentObject var rkManager1: RKManager
    //= RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365),  mode: 0)
var body: some View {
    VStack (spacing: 25) {
        Button(action: {  }) {
            NormalButton(btnText: (self.rkManager1.selectedDate != nil) ? self.rkManager1.selectedDate.toLocalDateStr() : Date().toLocalDateStr(),fontSize: .textbody, textColor: Color.maintext, borderColor: Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00),iconLeft: "Artboard 18",iconLeftSize: 12)
            //TextBody(text: (self.rkManager1.selectedDate != nil) ? self.getTextFromDate(date: self.rkManager1.selectedDate) : self.getTextFromDate(date: Date()))
        }
        .onTapGesture {
            //self.rkManager1.selectedDates = self.selectedDs
            self.singleIsPresented.toggle()
        }
        .sheet(isPresented: self.$singleIsPresented, content: {
            RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager1,monthIndex: self.$monthIndex
            )
                //.onDisappear(perform: self.setDateV)
        })
    }
}**/
class DealDetailTimeSlotsObservable: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    @Published var timeOptions: [DealDetailTimeOption] = [DealDetailTimeOption]() {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var selectedDate: Date = Date() {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var timeslots: Set<String> = Set<String>(){
        willSet {
            objectWillChange.send()
        }
    }
    /*init(timeOptions: [DealDetailTimeOption],selectedDate: Date){
        self.timeOptions = timeOptions
        self.selectedDate = selectedDate
    }*/
}
struct SpecificDateTimeOptionDetail: View {/*Default is execution_type =2 **/
    @State var monthIndex: Int = 1
    @State var isPresented: Bool = true
    //@Binding var timeslots: Set<String>
    @Binding var timeOptions: [DealDetailTimeOption]
    //var minimumDate: Date = Date()
    //var selectedDates:[Date]
    @EnvironmentObject var rkManager: RKManager
    @Binding var selectedTimeSlots: [DealDetailTimeOption]
        //= RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*30), mode: 0)
    var body: some View {
        VStack{
            /*RKManager(calendar: Calendar.current, minimumDate: (self.getSelectedDates().count > 0) ? self.getSelectedDates()[0] : Date(), maximumDate: Date().addingTimeInterval(60*60*24*30),  selectedDates: self.getSelectedDates(),mode: 0, selectedDate: self.selectedDate)**/
            RKViewController(isPresented: self.$isPresented, rkManager: self.rkManager ,monthIndex: self.$monthIndex)
            DealDetailTimeSlotTags(allTags: self.$timeOptions, selectedDate: self.$rkManager.selectedDate, selectedTimeSlots: self.$selectedTimeSlots, parentWidth: 300, clickAble: true)
            
            
            //if self.timeOptions.count > 0 {
                /*ForEach(0 ..< self.timeOptions.count, id: \.self) { itemIndex in
                    //if self.timeOptions[itemIndex].deal_date?.utcDateStrToDate() == self.rkManager.selectedDate {
                    TextBody(text: (self.timeOptions[itemIndex].deal_date?.utcDateStrToDate() == self.rkManager.selectedDate) ? self.timeOptions[itemIndex].start_time ?? "" : "mongpv")
                    //}else{
                        //TextBody(text: "")
                    //}
                }*/
            //}
            //TagList(allTags: self.$dealDetailTimeSlotsObservable.timeslots, selectedTags: Set<String>(), editable: false, parentWidth: 250,placeHolder: "")
            //TextBody(text: self.rkManager.selectedDate?.toLocalDateStr() ?? "")
        }
        /*VStack(alignment:  .leading,spacing: 15) {
            ForEach(0 ..< self.timeOptions.count, id: \.self) { rowIndex in
                VStack{
                    
                    TextBody(text: self.timeOptions[rowIndex].deal_date?.utcDateStrToDate().toLocalDateStr() ?? "")
                    TextBody(text: self.timeOptions[rowIndex].start_time?.toLocalAmPmTime() ?? "")
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
            }
        }*/
    }
    /*func SelectedDateSlotsView()-> some View{
        var timeslots: Set<String> = Set<String>()
        if(self.timeOptions.count > 0){
            for timeoption in self.timeOptions {
                let timeDate = timeoption.getSelectedDate() ?? Date()
                if timeDate == self.rkManager.selectedDate {
                    let timeslot = timeoption.start_time ?? ""
                    if !timeslot.isEmpty {
                        timeslots.insert(timeslot)
                    }
                }
            }
        }
        return AnyView(TagList(allTags: timeSlots, selectedTags: Set<String>(), editable: false, parentWidth: 250,placeHolder: ""))
    }*/
    func getAllTimeSlots() -> Set<String>{
        var resutls = Set<String>()
        if(self.timeOptions.count > 0){
            for timeOpt in self.timeOptions {
                let startTime = timeOpt.start_time ?? ""
                if !startTime.isEmpty {
                    resutls.insert(startTime)
                }
            }
        }
        //resutls.insert("00:00")
        return resutls
    }
    func updateStates(){
        if self.getSelectedDates().count > 0 {
            self.rkManager.minimumDate = self.getSelectedDates()[0]
            self.rkManager.selectedDates = self.getSelectedDates()
        }
    }
    func getSelectedDates() -> [Date]{
        var results = [Date]()
        if(self.timeOptions.count > 0){
            for timeoption in self.timeOptions {
                results.append(timeoption.getSelectedDate() ?? Date())
            }
            results.sort()
            //self.selectedDate = results[0]
            //self.monthIndex = self.selectedDate.getMonth()
        }
        return results
    }
}
struct RepeativeTimeOptionDetailRow: View{
    //@State var isMarked: Bool = false
    var timeOption: DealDetailTimeOption
    @Binding var selectedTimeSlots: [DealDetailTimeOption]
    var index: Int
    var body: some View {
         VStack(alignment:  .leading,spacing: 10) {
            Button(action:{
                self.selectedTimeSlots[0].id = self.timeOption.id ?? -1
            }){
                HStack{
                    DayOfWeekViewOnly(text: "S", val: "SU",  selectedDays: self.timeOption.day_of_week?.components(separatedBy: ",") ?? [String]())
                    DayOfWeekViewOnly(text: "M", val: "MO",  selectedDays: self.timeOption.day_of_week?.components(separatedBy: ",") ?? [String]())
                    DayOfWeekViewOnly(text: "T", val: "TU",  selectedDays: self.timeOption.day_of_week?.components(separatedBy: ",") ?? [String]())
                    DayOfWeekViewOnly(text: "W", val: "WE",  selectedDays: self.timeOption.day_of_week?.components(separatedBy: ",") ?? [String]())
                    DayOfWeekViewOnly(text: "T", val: "TH",  selectedDays: self.timeOption.day_of_week?.components(separatedBy: ",") ?? [String]())
                    DayOfWeekViewOnly(text: "F", val: "FR",  selectedDays: self.timeOption.day_of_week?.components(separatedBy: ",") ?? [String]())
                    DayOfWeekViewOnly(text: "S", val: "SA",  selectedDays: self.timeOption.day_of_week?.components(separatedBy: ",") ?? [String]())
                    Text("")
                        .frame(width:16,height:16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.border, lineWidth: 1)
                                .background((self.selectedTimeSlots[0].id == self.timeOption.id) ? Color.main : Color.white)
                        )
                    Spacer()
                }.padding(.vertical, 5)
                TextBody(text: self.timeOption.start_time?.toLocalAmPmTime() ?? "")
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.border, lineWidth: 1)
                )
            }
        }
    }
}
struct RepeativeTimeOptionDetail: View {/*Default is execution_type = 1 **/
    @Binding var timeOptions: [DealDetailTimeOption]
    @Binding var selectedTimeSlots: [DealDetailTimeOption]
    var body: some View {
        VStack(alignment:  .leading,spacing: 15) {
            ForEach(0 ..< self.timeOptions.count, id: \.self) { rowIndex in
                RepeativeTimeOptionDetailRow(timeOption: self.timeOptions[rowIndex],selectedTimeSlots: self.$selectedTimeSlots,index: rowIndex)
                //VStack(alignment:  .leading,spacing: 10) {
                   /*if !(self.timeOptions[rowIndex].deal_date?.isEmpty ?? false) {//specific date
                        //VStack{
                            TextBody(text: self.timeOptions[rowIndex].deal_date?.utcDateStrToDate().toLocalDateStr() ?? "")
                            TextBody(text: self.timeOptions[rowIndex].start_time?.toLocalAmPmTime() ?? "")
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                            //}
                    }else{*/
                        //VStack{
                    
                            
                        //}
                    //}
                //}
            }
        
        }
    }
}
struct DayOfWeekTimeOptions: View {
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @Binding var timeOptions: [DayOfWeekTimeOption]
    @Binding var duration: Double
    @Binding var executionType: Int
    @Binding var rateBasic: Int
    var body: some View {
        VStack(alignment: .leading,spacing: 15){
            //debugPrint()
            //Text(fromDate.dayOfWeeksBetweenDatesStr(type: "utc",to: self.toDate))
            NormalButton(btnText: "+ Time options",fontSize: .textsmall, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00)).onTapGesture {
                let newId: Int = self.timeOptions.count + 1
                self.timeOptions.append(DayOfWeekTimeOption(id: newId,  fromDate: self.fromDate, toDate: self.toDate,startTimes: [Date()], dayOfWeeks: []))
            }
            HStack{
                VStack(alignment:  .leading,spacing: 15) {
                    
                    ForEach(0 ..< self.timeOptions.count, id: \.self) { rowIndex in
                        Group{
                            HStack{
                                DayOfWeek(text: "S", val: "SU",  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks,isClickable: (self.fromDate.dayOfWeeksBetweenDates(type: "utc", to: self.toDate ).contains("SU")))
                                DayOfWeek(text: "M", val: "MO",  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks,isClickable: (self.fromDate.dayOfWeeksBetweenDates(type: "utc", to: self.toDate).contains("MO")))
                                DayOfWeek(text: "T", val: "TU",  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks,isClickable: (self.fromDate.dayOfWeeksBetweenDates(type: "utc", to: self.toDate).contains("TU")))
                                DayOfWeek(text: "W", val: "WE",  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks,isClickable: (self.fromDate.dayOfWeeksBetweenDates(type: "utc", to: self.toDate).contains("WE")))
                                DayOfWeek(text: "T", val: "TH",  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks,isClickable: (self.fromDate.dayOfWeeksBetweenDates(type: "utc", to: self.toDate).contains("TH")))
                                DayOfWeek(text: "F", val: "FR",  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks,isClickable: (self.fromDate.dayOfWeeksBetweenDates(type: "utc", to: self.toDate).contains("FR")))
                                DayOfWeek(text: "S", val: "SA",  selectedDays: self.$timeOptions[rowIndex].dayOfWeeks,isClickable: (self.fromDate.dayOfWeeksBetweenDates(type: "utc", to: self.toDate).contains("SA")))
                                Spacer()
                                //Button(action:{}){
                                if self.rateBasic == 2 || (self.rateBasic == 1 && self.executionType == 0) {
                                    NormalButton(btnText: "+ Add time slot",fontSize: .textsmall, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00)).onTapGesture {
                                        self.timeOptions[rowIndex].startTimes.append(Date())
                                    }
                                }
                                
                            }.padding(.vertical, 5)
                            TimeSlots(allSlots: self.$timeOptions[rowIndex].startTimes,duration: self.$duration,parentWidth: 360)
                        }
                    }
                }
                Spacer()
            }.frame(maxWidth: .infinity)
        }
    }
}
