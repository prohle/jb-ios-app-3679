//
//  AccountMenus.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/5/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct AccountMenus: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15  ){
                    HStack{
                        HStack{ ImageUrl(imageUrl:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",width: 36,height:36)
                            VStack(spacing:5){
                                TextObjectTitle(text: "Pham Van Mong")
                            IconText(imageIconLeft:"Artboard 110",imageIconRight:"app_icon",text:"Gold member",iconLeftSize:20,iconRightSize:10)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 15){
                            TextBody(text: "Token: 68")
                            TextBody(text: "Credit: $2.00")
                        }
                    }
                    Button(
                        action:{
                            self.viewRouter.currentPage = "deals"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 91",text:"Create Job/Deal",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "myaccount"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 92",text:"My Account",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "transactionhistory"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 94",text:"Transaction History",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "tokenmanage"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 95",text:"Token Manage",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "mydashboard"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 97",text:"My Dashboard",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "referals"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 90",text:"Referals",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "myrating"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 93",text:"My Rating",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "help"
                        },
                        label: {
                            IconText(imageIconLeft:"Artboard 96",text:"Help",iconLeftSize:24,spacing: 8,fontz: Font.textbody)
                        }
                    )
                }.padding(.horizontal,15)
            }
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}

struct AccountMenus_Previews: PreviewProvider {
    static var previews: some View {
        AccountMenus()
    }
}
