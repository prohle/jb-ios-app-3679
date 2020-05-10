//
//  TitleBlock.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/25/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import KeychainAccess
struct TitleBlock: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var dealObj: DealDetailObj
    var geometry: GeometryProxy
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            IconText(imageIconLeft:"Artboard 16",imageIconRight:nil,text:"save 35%",iconLeftSize:20,iconRightSize:10)
            TextBold(text: self.dealObj.name, font: Font.texttitle)
            HStack(spacing: 30){
                ZStack(alignment:.center){
                    TextBody(text: self.dealObj.normal_price?.formatMoney() ?? "0.00")
                    HorizontalLineShape().fill(Color.border).frame(width:40,height:1)
                }
                TextBody(text: self.dealObj.deal_price?.formatMoney() ?? "0.00",color: Color.main)
                Spacer()
            }
            TextBody(text: "Huong L", color: Color.subtext)
            IconText(imageIconLeft:"Artboard 21",imageIconRight:nil,text:"150 views | \(self.dealObj.use_count ?? 0) bought",iconLeftSize:18,iconRightSize:10)
            ZStack(alignment:.topLeading){
                HorizontalLineShape().fill(Color.border).frame(width: geometry.size.width - 2*CGFloat.stHpadding,height:15).cornerRadius(10)
                HorizontalLineShape().fill(Color.main).frame(width: 100,height:15).cornerRadius(10)
            }
            Button(action: {
                /*let keychain = Keychain(service: "ISOWEB.JouleBookUI")
                do {
                    let jsonData = try! JSONEncoder().encode(self.dealObj)
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    print("JSON String : " + jsonString!)
                    try keychain.set(jsonString ?? "", key: "deal_detail_obj")
                }catch let error {
                    print(error)
                }*/
                self.viewRouter.currentPage = "getdeal"
                self.viewRouter.dealObj = self.dealObj
            }){
                BasicButton(btnText:"Get Deal",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody).frame(height: 32)
            }
        }.frame(width:self.geometry.size.width - 2*CGFloat.stHpadding)
        
    }
}
