//
//  MyAccount.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/6/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct MyAccount: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15  ){
                    HStack{
                        Spacer()
                    }
                    Button(
                        action:{
                            self.viewRouter.currentPage = "myprofile"
                        },
                        label: {
                            TextBody(text: "My Profile")
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "providerprofile"
                        },
                        label: {
                            TextBody(text: "Provider Profile")
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "myaddress"
                        },
                        label: {
                            TextBody(text: "My Address")
                        }
                    )
                    Button(
                        action:{
                            self.viewRouter.currentPage = "bankcards"
                        },
                        label: {
                            TextBody(text: "Bank Account/ Cards")
                        }
                    )
                }.padding([.horizontal],CGFloat.stHpadding)
                .padding([.vertical],CGFloat.stVpadding)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
            }
    }
}

struct MyAccount_Previews: PreviewProvider {
    static var previews: some View {
        MyAccount()
    }
}
