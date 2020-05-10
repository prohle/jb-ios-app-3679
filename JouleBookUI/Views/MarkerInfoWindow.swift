//
//  MarkerInfoWindow.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct MarkerInfoWindow: View {
    var body: some View {

        HStack {
            Text("Image here")

            VStack {
                Text("Content 1")
                Text("Content 2")

            }

            Text("button here")
        }

    }
}

struct MarkerInfoWindow_Previews: PreviewProvider {
    static var previews: some View {
        MarkerInfoWindow()
    }
}
