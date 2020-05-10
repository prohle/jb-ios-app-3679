//
//  AddVehicleForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct AddVehicleForm: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State  var vehicleObj : ProviderVehicle
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
                            TextBody(text: "Car Make")
                            Spacer()
                            TextField("Set Brand Car", text: $vehicleObj.carMake)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            TextBody(text: "Car Model")
                            Spacer()
                            TextField("Set Car Model", text: $vehicleObj.model)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            TextBody(text: "Color")
                            Spacer()
                            TextField("Set Car Color", text: $vehicleObj.color)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        HStack{
                            TextBody(text: "Plate Number")
                            Spacer()
                            TextField("Set Plate Number", text: $vehicleObj.plateNumber)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                    }
                }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: VehicleHomeLeftTopTabbar(), trailing: VehicleTopSaveTabbar())
            
        }.onAppear(perform: onAppearForm)
        .onDisappear {
            print("ContentView disappeared!")
        }
    }
    func onAppearForm(){
        print("ContentView appeared!")
    }
}

struct VehicleTopSaveTabbar: View {
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
struct VehicleHomeLeftTopTabbar: View {
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
struct AddVehicleForm_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleForm()
    }
}*/
