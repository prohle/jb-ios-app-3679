//
//  Licenses.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/10/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
struct LicensesViewOnly: View {
    @Binding var licenseObjs:[ProviderLicense]
    var body: some View {
        VStack{
            HStack{
                TextBold(text: "Licenses",color: Color.textlink).frame(width:CGFloat((UIScreen.main.bounds.width * 33) / 100))
                TextBold(text: "No",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
                TextBold(text: "County - State",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
                TextBold(text: "Expiration Date",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
            }
            ForEach(licenseObjs) { licenseObj in
                LicenseItemRowViewOnly(licenseObj: licenseObj)
                HorizontalLine(color: .border)
            }
        }
    }
}
struct Licenses: View {
    @Binding var licenseObjs:[ProviderLicense]
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            HStack{
              TextBold(text: "Licenses",color: Color.main)
                 Spacer()
             }.padding(CGFloat.stVpadding).background(Color.mainback)
           // List{
            ForEach(licenseObjs) { licenseObj in
                LicenseItemRow(licenseObj: licenseObj).environmentObject(self.viewRouter)
                HorizontalLine(color: .border)
            }
            Button(action:{
                self.viewRouter.currentPage = "editlicenseform"
                self.viewRouter.objectId = -1
                //self.presentForm = true
                //self.licenseObjs.append(ProviderLicense(id: 6,state: "ste", licenseNumber: "12345", licenseName: "Test", expirationDate: "2019-12-07 00:00:00", description: ""))
            },label: {
                HStack{
                    TextBold(text:"Add a new License")
                    Spacer()
                    Image(systemName: "plus").resizable().frame(width: 18,height: 18)
                }
                //HorizontalLine(color: .border)
            })
            //}.frame(height: CGFloat( licenseObjs.count * 50))
            Spacer()
        }.onAppear(perform: loadLicenses)
        /*.sheet(isPresented: $presentForm) {
            EditLicenseForm()
        }*/
    }
    private func loadLicenses() {
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
                debugPrint(response)
                break
            }
        }
    }
}

/*
 https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-uiimagepickercontroller
 https://www.iosapptemplates.com/blog/swiftui/photo-camera-swiftui
struct Licenses_Previews: PreviewProvider {
    static var previews: some View {
        Licenses(licenseObjs: [ProviderLicense(id: 1,state: "ste", licenseNumber: "12345", licenseName: "Test", expirationDate: "2019-12-07 00:00:00", description: ""),ProviderLicense(id:2 ,state: "ste", licenseNumber: "12345", licenseName: "Test 2", expirationDate: "2019-12-07 00:00:00", description: "")])
    }
}*/
