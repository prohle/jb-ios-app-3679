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
struct LicenseItemRowViewOnly: View {
    var licenseObj: ProviderLicense
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        HStack{
            TextBold(text: self.licenseObj.license_name ?? "",color: Color.textlink).frame(width:CGFloat((UIScreen.main.bounds.width * 33) / 100))
            TextBold(text: self.licenseObj.license_number ?? "",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
            TextBold(text: self.licenseObj.state ?? "",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
            TextBold(text: self.licenseObj.expiration_date ?? "",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
        }
    }
}
struct LicensesViewOnly: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var licenseObjs:[ProviderLicense]
    var body: some View {
        VStack{
            HStack{
                TextBold(text: "Licenses",color: Color.textlink).frame(width:CGFloat((UIScreen.main.bounds.width * 33) / 100))
                TextBold(text: "No",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
                TextBold(text: "County - State",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
                TextBold(text: "Expiration Date",color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
            }
            if(self.licenseObjs.count > 0){
                ForEach(self.licenseObjs) { licenseObj in
                    LicenseItemRowViewOnly(licenseObj: licenseObj)
                    HorizontalLine(color: .border)
                }
            }
        }.onAppear(perform: {self.getLicenses()})
    }
    func getLicenses(){
        
    }
}
struct LicenseItemRow: View {
    //@EnvironmentObject var viewRouter: ViewRouter
    var licenseObj: ProviderLicense
    @Binding var showSheet: Bool
    @Binding var editLicenseObj: ProviderLicense
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        HStack(spacing:10){
            ImageUrlSameHeight(imageUrl:licenseObj.attach_1_url ?? "https://i1-vnexpress.vnecdn.net/2020/05/07/hocsinhjpg-1588827055-15888270-2855-2033-1588827076.jpg?w=680&h=408&q=100&dpr=1&fit=crop&s=nTQokr3b2-_96Er_rjXD5A",width: CGFloat((UIScreen.main.bounds.width * 25) / 100))
            TextBold(text: licenseObj.license_name ?? "")
            Spacer()
            TextBody(text: self.licenseObj.expiration_date?.utcDateStrToDate().toLocalDateStr() ?? "")
        }.padding([.vertical],5)
        .onTapGesture {
            self.editLicenseObj = self.licenseObj
            self.showSheet.toggle()
        }
    }
}
struct Licenses: View {
    @EnvironmentObject var userObserved: UserProfileObserver
    //@State var licenseObjs:[ProviderLicense] = [ProviderLicense]()
    //@EnvironmentObject var viewRouter: ViewRouter
    @State var showSheet: Bool = false
    @State var editLicenseObj: ProviderLicense = ProviderLicense()
    var body: some View {
        VStack{
            if(self.userObserved.licenseObjs.count > 0){
                ForEach(self.userObserved.licenseObjs) { licenseObj in
                    LicenseItemRow(licenseObj: licenseObj, showSheet: self.$showSheet, editLicenseObj: self.$editLicenseObj)
                    HorizontalLine(color: .border)
                }
            }
            Button(action:{},label: {
                HStack{
                    TextBold(text:"Add a new License")
                    Spacer()
                    Image(systemName: "plus").resizable().frame(width: 18,height: 18)
                }
            }).onTapGesture {
                self.editLicenseObj = ProviderLicense()
                self.showSheet.toggle()
            }
            Spacer()
        }.sheet(isPresented: $showSheet) {
            AddLicenseForm(licenseObj: self.$editLicenseObj,showSheet: self.$showSheet)
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
