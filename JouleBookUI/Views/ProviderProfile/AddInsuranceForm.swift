//
//  AddInsuranceForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct AddInsuranceForm: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State  var insuranceObj : ProviderInsurance
    @State private var birthDate = Date()
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
                            TextBody(text: "Policy Number")
                            Spacer()
                            TextField("Set Policy Number", text: $insuranceObj.policyNumber)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            TextBody(text: "Coverage For")
                            Spacer()
                            TextField("Set Coverage For", text: $insuranceObj.coverageFor)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                            TextBody(text: "Expiration Date")
                        }
                    }
                }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: InsuranceHomeLeftTopTabbar(), trailing: InsuranceTopSaveTabbar())
            
        }.onAppear(perform: onAppearForm)
        .onDisappear {
            print("ContentView disappeared!")
        }
    }
    func onAppearForm(){
        print("ContentView appeared!")
    }
}
struct InsuranceTopSaveTabbar: View {
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
