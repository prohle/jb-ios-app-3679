//
//  RadioButton.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct RadioBox: Identifiable,Hashable, Codable{
    var id: Int
    var text: String
}
struct GroupRadioButton: View {
    var radioBoxs: [RadioBox]
    @Binding var selectedVal: Int
    var body: some View {
        VStack{
            ForEach(self.radioBoxs){radioBox in
                HStack(alignment: .top) {
                    Circle()
                    .fill(self.selectedVal == radioBox.id ? Color.main : Color.clear)
                    .overlay(Circle().stroke(Color.main))
                    .frame(width: 18, height: 18)
                    TextBody(text: radioBox.text)
                        .foregroundColor(Color.maintext)
                }.onTapGesture {
                    self.selectedVal = radioBox.id
                }
            }
        }
    }
}
struct RadioButton: View {
    let text: String
    @Binding var isOn: Bool
    var body: some View {
        HStack(alignment: .top) {
            Circle()
            .fill(isOn ? Color.main : Color.clear)
            .overlay(Circle().stroke(Color.main))
            .frame(width: 18, height: 18)
            TextBody(text: text)
                .foregroundColor(Color.maintext)
        }.onTapGesture {
            self.isOn.toggle()
        }
        
    }
}
