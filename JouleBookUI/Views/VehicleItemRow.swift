//
//  VehicleItemRow.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct VehicleItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var vehicleObj: ProviderVehicle
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        NavigationLink(destination: AddVehicleForm(vehicleObj:vehicleObj ).environmentObject(self.viewRouter)) {
          HStack(alignment: .firstTextBaseline,spacing:10){
              TextBody(text: vehicleObj.carMake)
              Spacer()
            TextBody(text: vehicleObj.model+" | "+vehicleObj.color+" - "+vehicleObj.plateNumber)
          }
        }
    }
}

struct VehicleItemRow_Previews: PreviewProvider {
    static var previews: some View {
        VehicleItemRow(vehicleObj: ProviderVehicle(id: 1,carMake: "Toyota", color: "Grey", model: "Camry", plateNumber: "1440A"))
    }
}
