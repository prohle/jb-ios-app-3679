//
//  Insurances.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct InsuranceItemRow: View {
    var insuranceObj: ProviderInsurance
    @Binding var showSheet: Bool
    @Binding var editInsuranceObj: ProviderInsurance
    var body: some View {
        VStack{
            HStack(alignment: .firstTextBaseline,spacing:10){
              TextBody(text: insuranceObj.coverage_for)
                Spacer()
              TextBody(text: insuranceObj.policy_number+" | "+insuranceObj.expiration_date)
            }.padding([.vertical],10)
            HorizontalLine(color: .border)
        }.onTapGesture {
            self.editInsuranceObj = self.insuranceObj
            self.showSheet.toggle()
        }
    }
}
struct Insurances: View {
    @EnvironmentObject var userObserved: UserProfileObserver
    @State var showSheet: Bool = false
    @State var editInsuranceObj: ProviderInsurance = ProviderInsurance()
    var body: some View {
       VStack{
            if(self.userObserved.insuranceObjs.count > 0){
                ForEach(self.userObserved.insuranceObjs) { insuranceObj in
                    InsuranceItemRow(insuranceObj: insuranceObj,showSheet: self.$showSheet,editInsuranceObj: self.$editInsuranceObj)
                }
            }
            Button(action:{},label: {
                HStack{
                    TextBold(text:"Add a new Insurance")
                    Spacer()
                    Image(systemName: "plus").resizable().frame(width: 18,height: 18)
                }
            }).onTapGesture {
                self.editInsuranceObj = ProviderInsurance()
                self.showSheet.toggle()
        }
            Spacer()
        }.padding([.vertical],5).sheet(isPresented: $showSheet) {
            AddInsuranceForm(insuranceObj: self.$editInsuranceObj, showSheet: self.$showSheet )
        }
    }
}
