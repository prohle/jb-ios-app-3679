//
//  Vehicles.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/23/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct VehicleItemRowViewOnly: View {
    var vehicleObj: ProviderVehicle
    var body: some View {
        HStack{
            TextBold(text: self.vehicleObj.car_make,color: Color.maintext)
            Spacer()
            TextBold(text: "\(self.vehicleObj.model) | \(self.vehicleObj.color) - \(self.vehicleObj.plate_number)",color: Color.maintext)
        }
    }
}
struct VehicleItemRow: View {
    var vehicleObj: ProviderVehicle
    @Binding var showSheet: Bool
    @Binding var editVehicleObj: ProviderVehicle
    var body: some View {
        VStack{
            HStack(alignment: .firstTextBaseline,spacing:10){
              TextBody(text: vehicleObj.car_make)
              Spacer()
              TextBody(text: vehicleObj.model+" | "+vehicleObj.color+" - "+vehicleObj.plate_number)
            }.padding([.vertical],10)
            HorizontalLine(color: .border)
        }.onTapGesture {
            self.showSheet.toggle()
            self.editVehicleObj = self.vehicleObj
        }
    }
}
struct Vehicles: View {
    @EnvironmentObject var userObserved: UserProfileObserver
    @State var editVehicleObj: ProviderVehicle = ProviderVehicle()
    @State var showSheet: Bool = false
    var body: some View {
        VStack{
           // List{
            if(self.userObserved.vehicleObjs.count > 0){
                ForEach(self.userObserved.vehicleObjs) { vehicleObj in
                    VehicleItemRow(vehicleObj: vehicleObj,showSheet: self.$showSheet,editVehicleObj: self.$editVehicleObj)
                }
            }
            Button(action:{},label: {
                HStack{
                    TextBold(text:"Add a new Vehicle")
                    Spacer()
                    Image(systemName: "plus").resizable().frame(width: 18,height: 18)
                }
            }).onTapGesture {
                self.editVehicleObj = ProviderVehicle()
                self.showSheet.toggle()
            }
            Spacer()
        }.sheet(isPresented: $showSheet) {
            AddVehicleForm(vehicleObj: self.$editVehicleObj ,showSheet: self.$showSheet)
        }
    }
    
}
/*
struct Vehicles_Previews: PreviewProvider {
    static var previews: some View {
        Vehicles()
    }
}*/
