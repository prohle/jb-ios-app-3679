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
            ScrollView(showsIndicators: false) {
                VStack{
                    Text("Hi" )
                    Button(action:{
                        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
                        
                        do {
                            try keychain.set("", key: "access_token")
                            try keychain.set("", key: "refresh_token")
                        }
                        catch let error {
                            print(error)
                        }
                        self.viewRouter.loggedIn = false
                        self.viewRouter.currentPage = "signin"
                    }){
                        Text("Test token")
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}
/*
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}*/
