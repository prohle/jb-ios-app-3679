//
//  ButtonWithIcon.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct NormalButton: View{
    var btnText: String?
    var fontSize:Font?
    var textColor:Color?
    var borderColor:Color?
    var paddingH:CGFloat?
    var paddingV:CGFloat?
    var radius:CGFloat?
    var iconLeft: String?
    var iconLeftSize:CGFloat?
    var background: Color?
    var body: some View {
        HStack {
            if iconLeft != nil {
                Image(iconLeft!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accentColor((textColor != nil ) ? textColor : Color.maintext)
                .frame(width: (iconLeftSize != nil ) ? iconLeftSize : CGFloat(10))
                .shadow(radius: (iconLeftSize != nil) ? iconLeftSize!/2 : CGFloat(5))
            }
            Text(self.btnText!).font(fontSize != nil ? fontSize! : .textbody)
        }.padding([.vertical],paddingV != nil ? paddingV! : CGFloat(2.0))
        .padding([.horizontal],paddingH != nil ? paddingH! : CGFloat(2.0))
        .foregroundColor(textColor != nil ? textColor :  .maintext)
        .cornerRadius((radius != nil ) ? radius! : 5 )
        .background((background != nil) ? background : Color.white)
        .border((self.borderColor != nil) ? self.borderColor! :  .border,width: 1)
        /*.overlay(
            RoundedRectangle(cornerRadius: (radius != nil) ? self.radius! : 5)
            .stroke((self.borderColor != nil) ? self.borderColor! :  .border, lineWidth: 1)
        )*/
    }
}
struct BasicButton: View{
    var btnText: String?
    var imageName: String!
    var iconWidth: CGFloat?
    var iconHeight: CGFloat?
    var radius:CGFloat?
    var colorLinear:LinearGradient?
    var isActive = false
    var textColor:Color?
    var paddingH:CGFloat?
    var paddingV:CGFloat?
    var fontSize:Font?
    var body: some View {
        
        HStack {
            if imageName != nil{
                Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width:iconWidth,height:iconHeight)
            }
            Text(getBtnText())
                .fontWeight(.bold)
                .font(fontSize != nil ? fontSize! : .textbody).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            
                //.font(.custom("nomal", size: 22))
        }
        .padding([.vertical],paddingV != nil ? paddingV! : CGFloat(2.0))
        .padding([.horizontal],paddingH != nil ? paddingH! : CGFloat(2.0))
        .foregroundColor(textColor != nil ? textColor :  Color.white)
        .background(isActive == false ? LinearGradient(gradient: Gradient(colors: [Color.placeholder,Color.placeholder]), startPoint: .top, endPoint: .bottom) : (colorLinear != nil ? colorLinear! : LinearGradient(gradient: Gradient(colors: [Color.main,Color.main]), startPoint: .top, endPoint: .bottom)))
        .cornerRadius(getRadius())
        
        //LinearGradient(gradient: Gradient(colors: [Color.main,Color.main]), startPoint: .top, endPoint: .bottom)
        // ?? default CGFloat(20.0)
        /*.overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.purple, lineWidth: 5)
        )*/
    }
    func getRadius()->CGFloat{
        return radius != nil ? radius! : CGFloat(5.0)
    }
    func getBtnText()->String{
        return btnText != nil ? btnText! : ""
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NormalButton(btnText: "+ Test",fontSize: .body, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00))
            //BasicButton(btnText:"Hello",imageName: nil,iconWidth:18, iconHeight:18,isActive: false,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .footnote)
        }
        .previewLayout(.fixed(width: 190, height: 45))
        
    }
}

