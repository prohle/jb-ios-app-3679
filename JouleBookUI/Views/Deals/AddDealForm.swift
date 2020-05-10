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

struct AddDealForm: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var dealObj : Deal
    @State var catid: Int
    var dealSoldDate : RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365),  mode: 0)
    //let categories : [Category] = instantCats
    let serviceTypes: [ServiceType] = [ServiceType(id:1,name: "Individual"),ServiceType(id:2,name: "Group")]
    let rateBasics: [RateBasic] = [RateBasic(id: 1,name: "Hourly"),RateBasic(id: 2,name: "Flat rate")]
    /*static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()*/
    var body: some View {
       NavigationView {
            Form{
                Section{
                    Group{
                        AddImageBtn(text: "Add Deal Photo",maxImg: 12,parentWidth: 360)
                        HStack{
                            TextField("Deal Name", text: $dealObj.name)
                                .font(Font.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                                Spacer()
                            Text(String(dealObj.name.count)).font(.textbody).foregroundColor(Color.main)+Text("/70").font(.textbody).foregroundColor(Color.maintext)
                        }
                        TextBody(text: "Need more 10 characters",color: Color.main)
                        HStack{
                            TextField("Deal Description - Example: This deal give you 100 photos with original files. Contact me for customized quote for more photos and or longer time", text: $dealObj.txtDescription).font(Font.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                                Spacer()
                            Text(String(self.dealObj.txtDescription.count)).font(.textbody).foregroundColor(Color.main)+Text("/250").font(.textbody).foregroundColor(Color.maintext)
                        }
                        TextBody(text: "Need more 70 characters",color: Color.main)
                        HStack{
                            Picker(selection: self.$dealObj.categoryId, label: IconText(imageIconLeft: "Artboard 29",text: "Categories", iconLeftSize: 16, color: Color.maintext)) {
                                ForEach(0 ..< instantCats.count) {
                                    Text(instantCats[$0].name).tag(instantCats[$0].id)
                                }
                            }
                        }
                        /*https://gist.github.com/wilsoncusack/6e80af92cf86bfae768bda7c64009789*/
                        HStack{
                            Picker(selection: $dealObj.serviceType, label: IconText(imageIconLeft: "Artboard 24",text: "Deal type", iconLeftSize: 16, color: Color.maintext)) {
                                ForEach(0 ..< serviceTypes.count) {
                                    Text(self.serviceTypes[$0].name).tag(self.serviceTypes[$0].id)
                                }
                            }
                        }
                    }
                    Group{
                        HStack{
                            IconText(imageIconLeft: "Artboard 34",text: "Normal Price", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("$0.0",value: $dealObj.normalPrice,formatter: NumberFormatter())
                            .font(.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: "Artboard 31",text: "Deal Price", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("$0.0",value: $dealObj.dealPrice,formatter: NumberFormatter()).font(.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: "Artboard 26",text: "Deal Rate Basic", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            Picker(selection: $dealObj.rateBasis, label: EmptyView()) {
                                ForEach(0 ..< rateBasics.count) {
                                    Text(self.rateBasics[$0].name).tag(self.rateBasics[$0].id)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                            .labelsHidden()
                        }
                        HStack{
                            IconText(imageIconLeft: "Artboard 32",text: "Approveximate duration per time slot", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("0.0 hour", value: $dealObj.approxDuration, formatter: NumberFormatter()).font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: "Artboard 25",text: "Deal will be show until", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            DateSelectorModal(monthIndex: 0).environmentObject(self.dealSoldDate)
                        }
                        /*DatePicker(selection: self.$dealSoldDate, in: ...Date(), displayedComponents: .date){
                            IconText(imageIconLeft: "Artboard 25",text: "Deal will be show until", iconLeftSize: 16, color: Color.maintext)
                        }*/
                    }
                    Group{
                        TimeOptions(timeOptions: [TimeOption(id: 1,index: 1,  startTimes: [Date()], dayOfWeeks: [])])
                    }
                }
                
            }
            
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: DealHomeLeftTopTabbar(), trailing: DealTopSaveTabbar())
        }.onAppear(perform: getDealDetail)
         .onDisappear {
            print("ContentView disappeared!")
        }
    }
    func getDealDetail(){
        print("OK")
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
    //var providerProfileModel: ProviderProfileModel
    var body: some View {
        HStack{
            Button(action: {
                //debugPrint(self.providerProfileModel.skillsOne.count)
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
