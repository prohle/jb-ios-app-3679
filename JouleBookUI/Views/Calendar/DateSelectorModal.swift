//
//  DateSelectorModal.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct DateSelectorModal: View {
    @State var singleIsPresented = false
    //@Binding var selectedDs: [Date]
    @State var monthIndex: Int
    @EnvironmentObject var rkManager1: RKManager
        //= RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365),  mode: 0)
    var body: some View {
        VStack (spacing: 25) {
            Button(action: {  }) {
                NormalButton(btnText: (self.rkManager1.selectedDate != nil) ? self.getTextFromDate(date: self.rkManager1.selectedDate, format: "MM-d-yyyy") : self.getTextFromDate(date: Date(), format: "MM-d-yyyy"),fontSize: .textbody, textColor: Color.maintext, borderColor: Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00),iconLeft: "Artboard 18",iconLeftSize: 16)
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
    }
    /*func setDateV(){
        _selectedDs = Binding.constant(rkManager1.selectedDates)
        print(selectedDs)
    }*/
}
/*
struct DateSelectorModal_Previews: PreviewProvider {
    static var previews: some View {
        DateSelectorModal()
    }
}*/
