//
//  EditLicenseForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/12/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
struct EditLicenseForm: View {
    //@Binding var licenseId: Int
    @EnvironmentObject var viewRouter: ViewRouter
    @State  var licenseObj : ProviderLicense
    //@ObservedObject var licenseObj = ProviderLicenseObservable()
    let states = ["State 1", "State 2", "State 3"]
    @State private var birthDate = Date()
    @State private var selectedState = 0
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        NavigationView {
                Form{
                    Section{
                        HStack{
                            TextBody(text: "License Name")
                            Spacer()
                            TextField("Set License Name", text: $licenseObj.licenseName)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            TextBody(text: "License Number")
                            Spacer()
                            TextField("Set License Number", text: $licenseObj.licenseNumber)
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
                        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                            TextBody(text: "Expiration Date")
                        }
                    }
                }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: LicenseHomeLeftTopTabbar(), trailing: LicenseTopSaveTabbar())
            
        }.onAppear(perform: getUserLicense)
        .onDisappear {
            print("ContentView disappeared!")
        }
    }
    func getUserLicense(){
        //self.licenseObj.licenseNumber = "1234"
        //self.licenseObj.licenseName = "test"
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        let interceptor = RequestInterceptor(storage: keychain, viewrouter: viewRouter)
        AF.request("https://api-gateway.joulebook.com/api-gateway/user/v1.0/users/licenses",
        method: .get,
        //parameters: {},
        //encoder: JSONParameterEncoder.default,
        interceptor: interceptor
        
        ).validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON{response in
            switch response.result{
            case .failure(let f):
                self.viewRouter.currentPage = "home"
                //debugPrint(response)
                break
            case .success(let s):
                print(">> SUCCESS: ",s)
                break
            }
            //debugPrint(response)
        }
    }
}
struct LicenseTopSaveTabbar: View {
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

struct EditLicenseForm_Previews: PreviewProvider {
    static var previews: some View {
        EditLicenseForm(licenseObj: ProviderLicense(id: 2,state: "ste", licenseNumber: "12345", licenseName: "Test", expirationDate: Date(), description: ""))
    }
}
