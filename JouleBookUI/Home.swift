//
//  Home.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import KeychainAccess
struct Home: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(alignment:.leading,spacing: 15){
                        VStack(alignment:.center){
                            HStack(spacing: 15){
                                Spacer()
                                Image( systemName: "arrowtriangle.left.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .accentColor(Color.main)
                                .frame(width:16)
                                .shadow(radius: 8)
                                TextBold(text: Date().toLocalDateStr())
                                Image( systemName: "arrowtriangle.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .accentColor(Color.main)
                                .frame(width:16)
                                .shadow(radius: 8)
                                Spacer()
                            }
                        }
                        HStack(alignment: .top){
                            VStack{
                                HStack{
                                    VStack{
                                        TextBold(text: "Jobs Scheduled")
                                        TextBold(text: "05", color: Color.main,font: Font.bighomereport)
                                    }.frame(width: (geometry.size.width - 20)/3)
                                    VerticalLine(color: Color.border)
                                    VStack{
                                        TextBold(text: "Waiting Offers")
                                        TextBold(text: "02", color: Color.main,font: Font.bighomereport)
                                    }.frame(width: (geometry.size.width - 20)/3)
                                }.frame(height:80)
                                HStack{
                                    VStack{
                                        TextBold(text: "Jobs Listing")
                                        TextBold(text: "01", color: Color.main,font: Font.bighomereport)
                                    }.frame(width: (geometry.size.width - 20)/3)
                                    VerticalLine(color: Color.border)
                                    VStack{
                                        TextBold(text: "Deals Selling")
                                        TextBold(text: "02", color: Color.main,font: Font.bighomereport)
                                    }.frame(width: (geometry.size.width - 20)/3)
                                }.frame(height:80)
                            }.frame(width: ((geometry.size.width - 20)/3)*2)
                            VerticalLine(color: Color.border)
                            VStack(spacing: 45){
                                TextBold(text: "Potential Income")
                                TextBold(text: "50", color: Color.main,font: Font.bighomereport)
                            }.frame(width: ((geometry.size.width - 20)/3)).padding([.top])
                        }
                        HStack(spacing:0){
                            VTextIcon(imageIconTop:"Artboard 11",text:"Categories",iconTopSize:48, isFullSize: false, font: Font.textbody).frame(width: (geometry.size.width - 20)/5)
                            VTextIcon(imageIconTop:"Artboard 12",text:"Instant",iconTopSize:48, isFullSize: false, font: Font.textbody).frame(width: (geometry.size.width - 20)/5)
                            VTextIcon(imageIconTop:"Artboard 13",text:"Tokens",iconTopSize:48, isFullSize: false, font: Font.textbody).frame(width: (geometry.size.width - 20)/5)
                            VTextIcon(imageIconTop:"Artboard 14",text:"Membership",iconTopSize:48, isFullSize: false, font: Font.textbody).frame(width: (geometry.size.width - 20)/5)
                            VTextIcon(imageIconTop:"Artboard 15",text:"Referrals",iconTopSize:48, isFullSize: false, font: Font.textbody).frame(width: (geometry.size.width - 20)/5)
                        }.background(Color.white).padding([.horizontal],CGFloat.stHpadding)
                       
                        TextBold(text: "Top Deals", color: Color.main, font: Font.textheader)
                                .padding([.horizontal],CGFloat.stHpadding)
                                .padding([.vertical],5)
                        
                        TextBold(text: "Top Jobs", color: Color.main, font: Font.textheader)
                        .padding([.horizontal],CGFloat.stHpadding)
                        .padding([.vertical],5)
                        
                        TextBold(text: "Top Helpers", color: Color.main, font: Font.textheader)
                        .padding([.horizontal],CGFloat.stHpadding)
                        .padding([.vertical],5)
                        
                    }.padding([.horizontal],CGFloat.stHpadding)
                    .padding(CGFloat.stVpadding)
                }.frame(width: geometry.size.width,height:geometry.size.height)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
