//
//  TopTabbar.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/25/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct HomeLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "home"
            }) {
                Image("Artboard 10").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
struct MainTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
                HStack{
                    Button(action: {
                        print("Edit button pressed...")
                    }) {
                        Image( "Artboard 4")
                            .resizable()
                            .imageScale(.small)
                            .frame(width:20,height:20)
                            .accentColor(Color.main)
                    }
                    Button(action: {
                        print("Edit button pressed...")
                    }) {
                        Image("Artboard 5")
                           .resizable() .imageScale(.small).frame(width:20,height:20).accentColor(Color.main)
                    }
                    Button(action: {
                        self.viewRouter.currentPage = "accountmenus"
                        //print("Edit button pressed...")
                    }) {
                        Image( "Artboard 6").resizable().imageScale(.small).frame(width:20,height:20).accentColor(Color.main)
                    }
                    Button(action: {
                        print("Edit button pressed...")
                    }) {
                        Image("Artboard 7").resizable().imageScale(.small)
                            .frame(width:20,height:20)
                            .accentColor(Color.main)
                    }
                }
    }
}

struct TopTabbar_Previews: PreviewProvider {
    static var previews: some View {
        MainTopTabbar()
    }
}
