//
//  QuantityBox.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 5/8/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct QuantityBox: View {
    @Binding var value: Int
    var body: some View {
        HStack(spacing: 10){
            Button(action:{
                self.value = (self.value > 0) ? self.value - 1 : 0
            }){
                Image(systemName: "minus.circle").accentColor(Color.border).frame(width:18, height:18)
            }
            TextBody(text: "\(self.value)")
            Button(action:{
                self.value+=1
            }){
                Image(systemName: "plus.circle").accentColor(Color.border).frame(width:18, height:18)
            }
        }
    }
}
/*
struct QuantityBox_Previews: PreviewProvider {
    static var previews: some View {
        QuantityBox(value: <#Binding<Int>#>)
    }
}*/
