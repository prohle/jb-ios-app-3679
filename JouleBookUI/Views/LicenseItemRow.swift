//
//  LicenseItemRow.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/10/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct LicenseItemRowViewOnly: View {
    var licenseObj: ProviderLicense
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        HStack{
            TextBold(text: self.licenseObj.licenseName,color: Color.textlink).frame(width:CGFloat((UIScreen.main.bounds.width * 33) / 100))
            TextBold(text: self.licenseObj.licenseNumber,color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
            TextBold(text: self.licenseObj.state,color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
            TextBold(text: self.licenseObj.expirationDate,color: Color.maintext).frame(width:CGFloat((UIScreen.main.bounds.width * 22) / 100))
        }
    }
}
struct LicenseItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var licenseObj: ProviderLicense
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        /*NavigationLink(destination: AddLicenseForm(licenseObj:licenseObj ).environmentObject(self.viewRouter)) {
          HStack(alignment: .firstTextBaseline,spacing:10){ ImageUrl(imageUrl:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",width: CGFloat((UIScreen.main.bounds.width * 12) / 120),height:CGFloat((UIScreen.main.bounds.width * 10) / 100))
              TextBold(text: licenseObj.licenseName)
              Spacer()
            TextBody(text: LicenseItemRow.taskDateFormat.string(from: LicenseItemRow.taskDateFormat.date(from: self.licenseObj.expirationDate)!))
          }
        }*/
        
        Button(action:{
            self.viewRouter.currentPage = "editlicenseform"
            self.viewRouter.objectId = self.licenseObj.id
        }){
            HStack(spacing:10){
                ImageUrlSameHeight(imageUrl:licenseObj.attach1Url,width: CGFloat((UIScreen.main.bounds.width * 25) / 100))
                TextBold(text: licenseObj.licenseName)
                Spacer()
                TextBody(text: self.licenseObj.expirationDate)
            }
        }
    }
}

struct LicenseItemRow_Previews: PreviewProvider {
    static var previews: some View {
        LicenseItemRow(licenseObj: ProviderLicense(id: 1,state: "ste", licenseNumber: "12345", licenseName: "Test", expirationDate: "2020-04-30 00:00:00", description: ""))
    }
}
