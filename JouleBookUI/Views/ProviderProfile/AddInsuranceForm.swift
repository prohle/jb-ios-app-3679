//
//  AddInsuranceForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct AddInsuranceForm: View {
    @Binding  var insuranceObj : ProviderInsurance
    @Binding  var showSheet : Bool
    
    @ObservedObject var expirationDate : RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*1000),  mode: 0)
    var body: some View {
        //NavigationView {
                Form{
                    Section{
                        HStack{
                            TextBody(text: "Policy Number")
                            Spacer()
                            TextField("Set Policy Number", text: $insuranceObj.policy_number)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            TextBody(text: "Coverage For")
                            Spacer()
                            TextField("Set Coverage For", text: $insuranceObj.coverage_for)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: nil,text: "Expiration Date", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            DateSelectorModal(monthIndex: 0).environmentObject(self.expirationDate)
                        }
                        BasicButton(btnText:"Save Insurance",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody).onTapGesture {
                            if self.insuranceObj.saveInsurance(expirationDate: self.expirationDate) {
                                self.showSheet = false
                            }
                        }
                    }
                }.onTapGesture {
                    self.endEditing()
                }
            /*.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: InsuranceHomeLeftTopTabbar(), trailing: InsuranceTopSaveTabbar(insuranceObj: self.insuranceObj,expirationDate: self.expirationDate))
            
        }*/
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
}
struct InsuranceTopSaveTabbar: View {
    var insuranceObj: ProviderInsurance
    var expirationDate: RKManager
    var body: some View {
        HStack{
            Button(action: {
                self.insuranceObj.saveInsurance(expirationDate: self.expirationDate)
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
struct InsuranceHomeLeftTopTabbar: View {
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
struct AddInsuranceForm_Previews: PreviewProvider {
    static var previews: some View {
        AddInsuranceForm()
    }
}*/
