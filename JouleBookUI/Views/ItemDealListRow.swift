//
//  ItemDealListRow.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/8/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import UIKit
import URLImage
struct ItemDealListRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var dealObject: Deal
    var body: some View {
        //NavigationView{
            //NavigationLink(destination: DealDetail(deal: dealObject)){
             VStack ( spacing:10){
                 /*Image("https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg")
                 .resizable()
                 .frame(width: (UIScreen.main.bounds.width * 240) / 480, height: (UIScreen.main.bounds.width * 150) / 480)
                 .aspectRatio(contentMode: .fill)*/
                 ImageUrl(imageUrl:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",width: CGFloat((UIScreen.main.bounds.width * 200) / 480),height:CGFloat((UIScreen.main.bounds.width * 160) / 480))
                 
                 VStack(alignment: .leading, spacing:5){
                     HStack{
                 IconText(imageIconLeft:"app_icon",imageIconRight:nil,text:"test",iconLeftSize:10)
                             Spacer()
                         Text("Sponsored").font(.textsmall).foregroundColor(Color.subtext)
                         }
                    TextObjectTitle(text: dealObject.name)
                         
                         HStack{
                             Text("$100").font(Font.textsmall).foregroundColor(Color.subtext)
                             .strikethrough()
                         Text("$80").bold().font(.textsmall).foregroundColor(Color.main)
                         }
                         Text("Pham van Mong").font(.textsmall).foregroundColor(Color.subtext)
                     HStack{
                         VStack{
                             RatingBar()
                             //IconText(imageIconLeft:"app_icon",imageIconRight:"app_icon",text:"test",iconLeftSize:20,iconRightSize:10,paddingH:5)
                         }
                         Spacer()
                        Button(action: {
                            self.viewRouter.objectId = self.dealObject.id
                            self.viewRouter.currentPage = "dealdetail"
                        }){
                            BasicButton(btnText:"Get Deal",imageName: nil,isActive: true,paddingH:CGFloat(1.00),paddingV:CGFloat(5.00),fontSize: Font.textsmall).frame(height:32)
                        }
                        
                     }
                         
                 }.padding(5)
                 
                 Spacer()
             }
             .background(Color.white)
             .border(Color.placeholder)
             .cornerRadius(0)
             .shadow(radius: 2)
            //}
        //}
        
    }
}
/*
#if DEBUG
struct ItemDealListRow_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ItemDealListRow(dealObject:Deal(id:1,name:"Test deal 1",attachUrl1: :"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",latitude:1234, longitude:1234,categoryId:3))
        }
        .previewLayout(.fixed(width: 240, height: 270))
    }
}
#endif*/
