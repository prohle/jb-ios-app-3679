//
//  InstantCategoryRow.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct InstantCategoryRow: View {
    var body: some View {
        VStack{
            //ZStack{
            Image("Artboard52").frame(width: 120,height: 120)
            Text("Test cat").bold().foregroundColor(Color.maintext)
            
            /*overlay(
                HStack {
                    Text("Artichokes").foregroundColor(Color.white)
                    Spacer()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black.opacity(0.9)).frame(height:3), alignment: .bottom
                )
                .shadow(radius: 10)*/
            //}
        }
    }
}

struct InstantCategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        InstantCategoryRow()
    }
}
