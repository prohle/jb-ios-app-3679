//
//  RKViewController.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKViewController: View {
    @Binding var isPresented: Bool
    @ObservedObject var rkManager: RKManager
    @Binding var monthIndex:Int
    var body: some View {
        Group {
            HStack{
                Spacer()
                Button(action: {
                    if(self.monthIndex > 0 ) {
                        self.monthIndex -= 1
                    }
                }){
                    Image(systemName: "chevron.left.square").resizable().accentColor(Color.main).frame(width:24,height: 24)
                }.onTapGesture {
                    
                }
                Spacer()
                RKWeekdayHeader(rkManager: self.rkManager)
                Spacer()
                Button(action: {
                    if(self.monthIndex < self.numberOfMonths() ) {
                        self.monthIndex += 1
                    }
                }){
                    Image(systemName: "chevron.right.square").resizable().accentColor(Color.main).frame(width:24,height: 24)
                }
                Spacer()
            }
            Divider()
            RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: self.$monthIndex)
            if(self.rkManager.isCancleable == true){
                Divider()
                HStack{
                    Spacer()
                    Button(action: {
                         self.isPresented = false
                    }){
                        BasicButton(btnText:"Cancle",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .footnote)
                    }.frame(height: 36)
                    Spacer()
                }
            }
            /*List {
                ForEach(0..<numberOfMonths()) { index in
                    RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: index)
                }
                Divider()
            }*/
        }
    }
    
    func numberOfMonths() -> Int {
        return rkManager.calendar.dateComponents([.month], from: rkManager.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
    }
    
    func RKMaximumDateMonthLastDay() -> Date {
        var components = rkManager.calendar.dateComponents([.year, .month, .day], from: rkManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return rkManager.calendar.date(from: components)!
    }
}
/*
#if DEBUG
struct RKViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0),monthIndex: 0)
            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*32), mode: 0),monthIndex: 1)
                .environment(\.colorScheme, .dark)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
#endif*/

