//
//  CheckboxField.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct CheckboxField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: Int
    var inform: Bool = false
    @Binding var isMarked: Bool
    
    //var callback: (String, Bool)->()
    
    /*init(
        id: String,
        label:String,
        size: CGFloat = 10,
        color: Color = Color.maintext,
        textSize: Int = 14,
        inform: Bool
        //callback: @escaping (String, Bool)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.inform = inform
        //self.callback = callback
    }*/
    var body: some View {
        VStack{
            if self.inform == true {
                HStack(alignment: .center, spacing: 10) {
                               Image(systemName: self.isMarked ? "checkmark.square" : "square")
                                   .renderingMode(.original)
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: self.size, height: self.size)
                               Text(label)
                                   .font(Font.system(size: size))
                               Spacer()
                           }.foregroundColor(self.color)
                            .onTapGesture {
                               self.isMarked.toggle()
                               //self.callback(self.id, self.isMarked)
                           }
            }else{
                Button(action:{
                    self.isMarked.toggle()
                    //self.callback(self.id, self.isMarked)
                }) {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: self.isMarked ? "checkmark.square" : "square")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: self.size, height: self.size)
                        Text(label)
                            .font(Font.system(size: size))
                    }.foregroundColor(self.color)
                }
            }
        }
    }
}
