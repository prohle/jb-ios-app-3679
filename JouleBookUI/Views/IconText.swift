//
//  IconText.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct IconText: View {
    var imageIconLeft:String?
    var imageIconRight:String?
    var text:String!
    var iconLeftSize:CGFloat?
    var iconRightSize:CGFloat?
    var spacing:CGFloat?
    var fontz: Font?
    var color: Color?
    var body: some View {
        HStack(spacing: spacing ?? 5){
            if imageIconLeft != nil {
                Image(imageIconLeft!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accentColor((color != nil ) ? color : Color.main)
                .frame(width:iconLeftSize!)
                //.clipShape(Circle())
                .shadow(radius: iconLeftSize!/2)
            }
            Text(text).font(fontz ?? Font.textbody).foregroundColor(Color.maintext)
            if imageIconRight != nil {
                Image(imageIconRight!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accentColor((color != nil ) ? color : Color.main)
                .frame(width:iconRightSize!)
                //.clipShape(Circle())
                .shadow(radius: iconRightSize!/2)
            }
        }
    }
}

struct IconText_Previews: PreviewProvider {
    static var previews: some View {
        IconText(imageIconLeft:"app_icon",imageIconRight:"app_icon",text:"test",iconLeftSize:20,iconRightSize:10)
    }
}
