//
//  InsuranceItemRow.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct InsuranceItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var insuranceObj: ProviderInsurance
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        NavigationLink(destination: AddInsuranceForm(insuranceObj:insuranceObj ).environmentObject(self.viewRouter)) {
          HStack(alignment: .firstTextBaseline,spacing:10){
              TextBody(text: insuranceObj.coverageFor)
              Spacer()
            TextBody(text: insuranceObj.policyNumber+" | "+insuranceObj.expirationDate)
          }
        }
    }
}
struct InsuranceItemRow_Previews: PreviewProvider {
    static var previews: some View {
        InsuranceItemRow(insuranceObj: ProviderInsurance(id: 1,policyNumber: "C900303", expirationDate: "2020-04-22 00:00:00", coverageFor: "General Handyman Service"))
    }
}
