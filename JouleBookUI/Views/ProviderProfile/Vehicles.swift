//
//  Vehicles.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/23/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct VehicleItemRowViewOnly: View {
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
struct Vehicles: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Vehicles_Previews: PreviewProvider {
    static var previews: some View {
        Vehicles()
    }
}
