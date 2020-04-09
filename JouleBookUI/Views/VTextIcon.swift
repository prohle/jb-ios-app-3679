//
//  VTextIcon.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/27/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct VTextIcon: View {
    //@State private var isActive = false
    var imageIconTop:String?
    var text:String!
    var iconTopSize:CGFloat?
    var color: Color?
    var isFullSize: Bool?
    var font: Font?
    //var imageIconTopActived:String?
    var body: some View {
                    VStack(alignment: .center,spacing: 2){
                        if(isFullSize == true){
                            Image(imageIconTop!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            //.clipShape(Rectangle())
                            .accentColor((color != nil ) ? color : Color.main)
                        }else{
                            Image(imageIconTop!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:iconTopSize!)
                            //.clipShape(Rectangle())
                            .accentColor((color != nil ) ? color : Color.main)
                        }
                        Text(text).font((font != nil) ? font : .textbody).lineLimit(1).foregroundColor(Color.maintext)
                    }
    }
}

struct VTextIcon_Previews: PreviewProvider {
    static var previews: some View {
        VTextIcon(imageIconTop:"app_icon",text:"test",iconTopSize:20, isFullSize: true)
    }
}
