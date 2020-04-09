//
//  TimeSlots.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import ClockTimePicker
struct TimeSlots: View {
    @Binding var allSlots: [Date]
    var parentWidth: CGFloat
    
    //private var orderedTags: [Date] { allSlots.sorted() }
    //@Binding var teststate: CGFloat
    private func rowCounts() -> [Int] {
        TimeSlots.rowCounts(tags: self.allSlots, padding: 5, parentWidth: parentWidth)
    }
    private func tagslot(rowCounts: [Int], rowIndex: Int, itemIndex: Int) -> Date {
        let sumOfPreviousRows = rowCounts.enumerated().reduce(0) { total, next in
            if next.offset < rowIndex {
                return total + next.element
            } else {
                return total
            }
        }
        let orderedTagsIndex = sumOfPreviousRows + itemIndex
        guard self.allSlots.count > orderedTagsIndex else { return Date() }
        return self.allSlots[orderedTagsIndex]
    }

    var body: some View {
        VStack(alignment:  .leading) {
            /*
            HStack{
                Button(action:{
                    //let day = String(Int.random(in: 10 ..< 28))
                    //let month = String(Int.random(in: 1 ..< 12))
                    //let year = String(Int.random(in: 1986 ..< 2019))
                    //print(year + "-" + month + "-" + day)
                    //LicenseItemRow.taskDateFormat.date(from: year + "-" + month + "-" + day)!
                    //let hourse = String(Int.random(in: 1 ..< 9))
                    //let mins = String(Int.random(in: 10 ..< 59))
                    //self.allSlots.insert("0"+hourse + ":" + mins)
                    
                }){
                    TextBody(text:"Add Time Slot")
                }.onTapGesture {
                    self.allSlots.append(Date())
                }
                Button(action:{}){
                    TextBody(text: "Print slots")
                }.onTapGesture {
                   print(self.allSlots)
                }
            }*/
            
                VStack(alignment:  .leading) {
                    ForEach(0 ..< self.rowCounts().count, id: \.self) { rowIndex in
                        HStack (spacing: 10){
                            Spacer()
                            ForEach(0 ..< self.rowCounts()[rowIndex], id: \.self) { itemIndex in
                                TimeSlotButton( dateSlot: self.tagslot(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex), allSlots: self.$allSlots)
                            }
                            Spacer()
                        }.padding(.vertical, 5)
                    }
                }
            
        }
        //.onAppear(perform: loadDemoDatas)
    }
    func getDateFromString(dateStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD hh:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.date(from: dateStr)!
    }
}
extension TimeSlots {
    static func rowCounts(tags: [Date], padding: CGFloat, parentWidth: CGFloat) -> [Int] {
        var currentLineTotal: CGFloat = 0
        var currentRowCount: Int = 0
        var result: [Int] = []

        for _ in tags {
            let effectiveWidth = CGFloat(100)
            if currentLineTotal + effectiveWidth <= parentWidth {
                currentLineTotal += effectiveWidth
                currentRowCount += 1
                guard result.count != 0 else { result.append(1); continue }
                result[result.count - 1] = currentRowCount
            } else {
                currentLineTotal = effectiveWidth
                currentRowCount = 1
                result.append(1)
            }
        }
        return result
    }
}
/*
final class SelectionChange: ObservableObject {
    var dateStr: String = ""
    var selection: Date = Date() {
        didSet {
            date_formate(slectedate: selection)
        }
    }
    
    func date_formate(slectedate: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        self.dateStr = formatter.string(from: slectedate)
        print(self.dateStr)
    }
    
}*/
struct TimeSlotButton: View {
    //@State var dateStr: String
    //@ObservedObject var value = SelectionChange()
    @State var dateSlot: Date
    @Binding var allSlots: [Date]
    @State var showActionSheet: Bool = false
    private let vPad: CGFloat = 5
    private let hPad: CGFloat = 10
    private let radius: CGFloat = 5
    /*static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()*/
    var canEdit: Bool = true
    var body: some View {
        ZStack {
            Button(action: {
                //self.showActionSheet = true
            }) {
                TextBody(text: self.getDateString())
            }.onTapGesture {
               self.showActionSheet = true
            }
            /*DatePicker("Select Date",selection: $dateSlot ,  displayedComponents: .hourAndMinute)
                .font(.textbody)
                .labelsHidden()
            Button(action: {
                //self.allSlots.remove(self.dateStr)
            }){
                Image("Artboard 84")
                .resizable()
                .accentColor(Color.main)
                .frame(width:13, height:13)
                .background(Color.main)
                .clipShape(Circle())
            }
             
             */
        }.foregroundColor(.maintext)
        .padding(5)
        .background(Color.white)
        .cornerRadius(radius)
        .overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(Color.border, lineWidth: 1)
        )
        .sheet(isPresented: $showActionSheet) {
            ModalTimePicker(date: self.$dateSlot,showActionSheet: self.$showActionSheet)
        }
    }
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: dateSlot)
    }
}
struct ModalTimePicker: View {
    @Binding var date: Date
    @Binding var showActionSheet: Bool
    @State var showTime = false
    @ObservedObject var options = ClockLooks()
    
    var body: some View {
        VStack{
            ClockPickerView(date: self.$date, options: self.options)
            Spacer()
            Button(action:{
                self.showActionSheet = false
            }){
                Text("Done")
            }
        }.onAppear(perform: loadOptions)
    }
    func loadOptions() {
            // for clock with hands
            options.backgroundColor = .main
            options.hourTickMarkColor = .blue
            options.hourTickMarkWidth = CGFloat(10)
            options.hourDotMarkSize = CGFloat(46)
            options.hourDotMarkColor = .blue
            options.hourHandColor = .blue
            options.minuteHandColor = .blue
            options.labelColor = .maintext
            options.labelFont = Font.custom("Didot-Bold", size: 30)
            options.circleWidth = CGFloat(2)
            options.hourHandleColor = .maintext
            options.minuteHandleColor = .maintext
            options.centerBackgroundColor = .maintext
            options.centerTextFont = Font.custom("Helvetica", size: 20)
            options.hourHandWidth = CGFloat(10)
            options.minuteHandWidth = CGFloat(8)
            options.handleSize = CGFloat(15)
            options.ampmTintColor = UIColor.blue
            options.impactFeedbackOn = true
      
        }

        
}
