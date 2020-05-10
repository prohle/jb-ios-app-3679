//
//  AddLicenseForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/12/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
struct AddLicenseForm: View {
    @Binding  var licenseObj : ProviderLicense
    @Binding var showSheet: Bool
    let states = ["State 1", "State 2", "State 3"]
    @ObservedObject var expirationDate : RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*1000),  mode: 0)
    @State private var selectedState = 0
    //@State private var saveButtonText: String = "Save License"
    var body: some View {
        //NavigationView {
                Form{
                    Section{
                        HStack{
                            TextBody(text: "License Name")
                            Spacer()
                            TextField("Set License Name", text: $licenseObj.license_name ?? "")
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            TextBody(text: "License Number")
                            Spacer()
                            TextField("Set License Number", text: $licenseObj.license_number ?? "")
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        Picker(selection: $licenseObj.state, label: TextBody(text:"State")) {
                            ForEach(0 ..< states.count) {
                                Text(self.states[$0]).tag($0)
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                        HStack{
                            IconText(imageIconLeft: nil,text: "Expiration Date", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            DateSelectorModal(monthIndex: 0).environmentObject(self.expirationDate)
                        }
                        /*DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                            TextBody(text: "Expiration Date")
                        }*/
                        BasicButton(btnText:"Save License",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody)
                            .onTapGesture {
                                if self.licenseObj.saveLicense(expirationDate: self.expirationDate) {
                                    self.showSheet = false
                                }
                        }
                    }
                }.onTapGesture {
                    self.endEditing()
                }
            /*.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: LicenseHomeLeftTopTabbar(), trailing: LicenseTopSaveTabbar(licenseObj: self.$licenseObj,expirationDate: self.expirationDate))
            
        }*/
    }
    
    func endEditing(){
        UIApplication.shared.endEditing()
    }
}
struct LicenseTopSaveTabbar: View {
    @Binding  var licenseObj : ProviderLicense
    var expirationDate : RKManager
    var body: some View {
        HStack{
            Button(action: {
                self.licenseObj.saveLicense(expirationDate: self.expirationDate)
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
struct LicenseHomeLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "providerprofile"
            }) {
                Image("Artboard 3").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
/*
struct AddLicenseForm_Previews: PreviewProvider {
    static var previews: some View {
        AddLicenseForm(licenseObj: ProviderLicense(id: 2,state: "ste", licenseNumber: "12345", licenseName: "Test", expirationDate: "2020-04-30 00:00:00", description: ""))
    }
}*/
