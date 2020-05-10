//
//  AddVehicleForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct AddVehicleForm: View {
    @Binding  var vehicleObj : ProviderVehicle
    @Binding  var showSheet : Bool
    var body: some View {
        //NavigationView {
                Form{
                    Section{
                        HStack{
                            TextBody(text: "Car Make")
                            Spacer()
                            TextField("Set Brand Car", text: $vehicleObj.car_make)
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
                            TextField("Set Plate Number", text: $vehicleObj.plate_number)
                                .font(.textbody)
                                .foregroundColor(Color.maintext)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                        }
                        BasicButton(btnText:"Save Vehicle",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody).onTapGesture {
                            if self.vehicleObj.saveVehicle() {
                                self.showSheet = false
                            }
                        }
                    }
                }.onTapGesture {
                    self.endEditing()
                }
            /*.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: VehicleHomeLeftTopTabbar(), trailing: VehicleTopSaveTabbar(vehicleObj: self.$vehicleObj))
            
        }*/
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
}

struct VehicleTopSaveTabbar: View {
    @Binding var vehicleObj : ProviderVehicle
    var body: some View {
        HStack{
            Button(action: {
                self.vehicleObj.saveVehicle()
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
