//
//  AddDealForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
import Combine

struct AddDealForm: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var dealObservable = DealObservable()
    @ObservedObject var effectiveDateStart : RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*100),  mode: 0)
    @ObservedObject var effectiveDateEnd : RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(timeInterval: 28*24*60*60, since: Date()), maximumDate: Date().addingTimeInterval(60*60*24*100),  mode: 0)
    let serviceTypeA: [ServiceType] = [ServiceType(id:1,name: "Group"),ServiceType(id:2,name: "Individual")]
    let rateBasics: [RateBasic] = [RateBasic(id: 1,name: "Flat rate per time option"),RateBasic(id: 2,name: "Flat rate per time slot")]
    @State var showSheet: Bool = false
    var body: some View {
       NavigationView {
            Form{
                Section{
                        AddImageBtn(text: "Add Photo",maxImg: 12,parentWidth: 376)
                        HStack{
                            TextField("Deal Name", text: $dealObservable.name)
                                .font(Font.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                                Spacer()
                            Text(String(self.dealObservable.name.count)).font(.textbody).foregroundColor(Color.main)+Text("/70").font(.textbody).foregroundColor(Color.maintext)
                        }
                        TextBody(text: "Need more 10 characters",color: Color.main)
                        HStack{
                            TextField("Deal Description - Example: This deal give you 100 photos with original files. Contact me for customized quote for more photos and or longer time", text: $dealObservable.description).font(Font.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                                Spacer()
                            Text(String(self.dealObservable.description.count)).font(.textbody).foregroundColor(Color.main)+Text("/250").font(.textbody).foregroundColor(Color.maintext)
                        }
                        TextBody(text: "Need more 70 characters",color: Color.main)
                }
                Section{
                        Picker(selection: self.$dealObservable.category_id, label: IconText(imageIconLeft: "Artboard 29",text: "Categories", iconLeftSize: 16, color: Color.maintext)) {
                            /*ForEach(0 ..< instantCats.count, id: \.self) {
                                TextBody(text: instantCats[$0].name).tag(instantCats[$0].id)
                            }*/
                            ForEach(instantCats, id: \.self){instantCat in
                                TextBody(text: instantCat.name).tag(instantCat.id)
                            }
                        }
                        Picker(selection: $dealObservable.service_type, label: IconText(imageIconLeft: "Artboard 24",text: "Deal type", iconLeftSize: 16, color: Color.maintext)) {
                            ForEach(serviceTypeA, id: \.self){serviceType in
                                TextBody(text: serviceType.name).tag(serviceType.id)
                            }
                            /*ForEach(0 ..< serviceTypeA.count, id: \.self) {
                                TextBody(text: self.serviceTypeA[$0].name).tag(self.serviceTypeA[$0].id)
                            }*/
                        }
                        HStack{
                             IconText(imageIconLeft: "Artboard 34",text: "Normal Price", iconLeftSize: 16, color: Color.maintext)
                             Spacer()
                             FormattedTextField(
                                 "0.00",
                                 value: $dealObservable.normal_price,
                                 formatter: CurrencyTextFieldFormatter()
                             )
                         }
                        HStack{
                             IconText(imageIconLeft: "Artboard 31",text: "Deal Price", iconLeftSize: 16, color: Color.maintext)
                             Spacer()
                             FormattedTextField(
                                 "0.00",
                                 value: $dealObservable.deal_price,
                                 formatter: CurrencyTextFieldFormatter()
                             )
                         }
                        HStack{
                             IconText(imageIconLeft: "Artboard 31",text: "Tax rate", iconLeftSize: 16, color: Color.maintext)
                             Spacer()
                             FormattedTextField(
                                 "0.00",
                                 value: $dealObservable.tax_rate,
                                 formatter: DoubleTextFieldFormatter()
                             )
                         }
                    if self.dealObservable.service_type == 1 {
                        HStack{
                            IconText(imageIconLeft: "Artboard 31",text: "Seats", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            FormattedTextField(
                                "Set number of avaiable seats",
                                value: $dealObservable.seats_number,
                                formatter: IntTextFieldFormatter()
                            )
                        }
                    }
                        HStack{
                            IconText(imageIconLeft: "Artboard 26",text: "Deal Rate Basic", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            Picker(selection: $dealObservable.rate_basis, label: EmptyView()) {
                                ForEach(rateBasics, id: \.self){rateBasic in
                                    TextBody(text: rateBasic.name).tag(rateBasic.id)
                                }
                            }.labelsHidden()
                        }
                        HStack{
                            IconText(imageIconLeft: "Artboard 32",text: "Length per session", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            FormattedTextField(
                                "0.00",
                                value: $dealObservable.approx_duration,
                                formatter: DoubleTextFieldFormatter()
                            )
                        }
                        
                    }
                Section(header: TextBody(text: "Time Options")){
                    HStack{
                        IconText(imageIconLeft: "Artboard 36",text: "Service Date Config", iconLeftSize: 16, color: Color.maintext)
                        Spacer()
                        Toggle(isOn: self.$dealObservable.date_type) {
                            TextBody(text: ((self.dealObservable.date_type) ? "Day of week" : "Specific date"), color: Color.maintext)
                        }.padding()
                    }
                    
                    if self.dealObservable.date_type == true {
                        HStack{
                            IconText(imageIconLeft: "Artboard 25",text: "Deal Effective", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            DateSelectorModal(monthIndex: 0).environmentObject(self.effectiveDateStart)
                            DateSelectorModal(monthIndex: 0).environmentObject(self.effectiveDateEnd)
                        }
                        DayOfWeekTimeOptions(fromDate: $effectiveDateStart.selectedDate,toDate: $effectiveDateEnd.selectedDate,timeOptions: $dealObservable.dayOfWeekTimeOptions, duration: $dealObservable.approx_duration, executionType: $dealObservable.execution_type,rateBasic: $dealObservable.rate_basis)
                    }else{
                       SpecificTimeOptions(timeOptions: $dealObservable.specificTimeOptions, duration: $dealObservable.approx_duration)
                    }
                }
                    Section(header: IconText(imageIconLeft: "Artboard 30",text: "Location of service", iconLeftSize: 16, color: Color.maintext)){
                        HStack(spacing: 5){
                            CheckboxField(id: "address_provider_choice",label: "My Choice",size: 14,color: Color.maintext,textSize: 14,inform: true, isMarked: self.$dealObservable.is_address_provider_choice)
                            //callback: self.checkboxSelected,
                            Spacer()
                            TextBody(text:(self.dealObservable.selectedAddress.id > 0 ) ? self.dealObservable.selectedAddress.getFullAddress() : "Select Address", color: Color.textlink)
                            .onTapGesture {
                                self.dealObservable.is_address_provider_choice = true
                                self.showSheet.toggle()
                            }.sheet(isPresented: $showSheet) {
                                MySelectableAddress(selectedAddress: self.$dealObservable.selectedAddress,showSheet: self.$showSheet)
                            }
                        }
                        CheckboxField(id: "address_customer_choice",label: "Customer Choice",size: 14,color: Color.maintext,textSize: 14,inform: true, isMarked: self.$dealObservable.is_address_customer_choice)
                        CheckboxField(id: "address_remote",label: "Remote",size: 14,color: Color.maintext,textSize: 14,inform: true, isMarked: self.$dealObservable.is_address_remote)
                        TextBody(text: "Max Potential Gross Income").padding([.leading],16)
                        TextBody(text: self.dealObservable.getMaxIncome())
                        //if(!self.getMaxIncome().isEmpty ){
                            /*TextBody(text: self.getMaxIncome() )
                                padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .strokeBorder(
                                            style: StrokeStyle(
                                                lineWidth: 2,
                                                dash: [5]
                                            )
                                        )
                                        .foregroundColor(.main)
                                )*/
                        //}
                        BasicButton(btnText:"Create Deal",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody).onTapGesture {
                            if self.dealObservable.execution_type == 1 {
                                self.dealObservable.start_time = self.effectiveDateStart.selectedDate?.toUTCDateTimeStr() ?? Date().toUTCDateTimeStr()
                                self.dealObservable.expire_time = self.effectiveDateEnd.selectedDate?.toUTCDateTimeStr() ??  Date().toUTCDateTimeStr()
                            }else{
                                self.dealObservable.start_time = Date().toUTCDateTimeStr()
                                self.dealObservable.expire_time = Date(timeIntervalSinceNow: 28*24*60*60).toUTCDateTimeStr()
                            }
                            //self.dealObservable.execution_type = self.dealObservable.rate_basis
                            self.dealObservable.submitDeal()
                        }
                    }
            }.onTapGesture {
                self.endEditing()
            }
        
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: DealHomeLeftTopTabbar(), trailing: DealTopSaveTabbar().environmentObject(self.dealObservable))
        }
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
    /*func getMaxIncome() -> String{
        var maxIncome: Double = 0
        self.dealObservable.timeOptionToDealTimes()
        let countSeat: Int = (self.dealObservable.service_type == 1) ? self.dealObservable.seats_number : 1
        let countTime: Int = (self.dealObservable.deal_times.count > 0) ? self.dealObservable.deal_times.count : 1
        maxIncome = (self.dealObservable.deal_price > 0) ? self.dealObservable.deal_price * Double(countSeat) * Double(countTime) : 0
        if(maxIncome > 0) {
            let incomeStr = (self.dealObservable.execution_type == 1) ? "time option(s)" : "time slot(s)"
            let incomeStr2 = (self.dealObservable.execution_type == 1) ? "option" : "slot"
            return ((countSeat > 1) ? "\(countTime) \(incomeStr) x \(countSeat) seat(s) x \(self.dealObservable.deal_price)/seat = \(maxIncome)" : "\(countTime) \(incomeStr) x \(self.dealObservable.deal_price)/\(incomeStr2) = \(maxIncome)")
        }
        return "Mong pv ptt"
    }*/
    func checkboxSelected(id: String, isMarked: Bool){
        switch id {
        case "address_customer_choice":
            self.dealObservable.is_address_customer_choice = isMarked
        case "address_provider_choice":
            self.dealObservable.is_address_provider_choice = isMarked
        case "address_remote":
            self.dealObservable.is_address_remote = isMarked
        default:
            self.dealObservable.is_address_customer_choice = false
            self.dealObservable.is_address_provider_choice = false
            self.dealObservable.is_address_remote = false
        }
        print("\(id) is marked: \(isMarked)")
    }
}

struct ServiceType: Codable, Hashable{
    var id: Int
    var name: String
}
struct RateBasic: Codable, Hashable{
    var id: Int
    var name: String
}
struct DealTopSaveTabbar: View {
    @EnvironmentObject var dealObservable: DealObservable
    var body: some View {
        HStack{
            Button(action: {
                self.dealObservable.submitDeal()
            }) {
                Image( "Artboard 8")
                    .resizable()
                    .imageScale(.small)
                    .frame(width:20,height:20)
                    .accentColor(Color.main)
            }
        }
    }
}
struct DealHomeLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "deals"
            }) {
                Image("Artboard 3").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
/*
struct AddDealForm_Previews: PreviewProvider {
    static var previews: some View {
        AddDealForm(dealObj: Deal(id:1,categoryId: 1,dealPrice: 200,name:"Test", normalPrice: 250,userId: 1))
    }
}*/
