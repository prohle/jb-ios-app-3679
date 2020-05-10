//
//  InstantHelp.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct InstantHelp: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var ready: Bool = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing:20){
                        HStack{
                            Spacer()
                            Image("app_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .accentColor(Color.main)
                            .frame(width:48)
                            Spacer()
                        }
                        HStack(spacing: 0) {
                            Spacer()
                            Text("ARE YOU ").bold().font(Font.textbody).foregroundColor(Color.maintext)
                            Text("AVAILEABLE ").bold().font(Font.textbody).foregroundColor(Color.main)
                            Text("FOR ").bold().font(Font.textbody).foregroundColor(Color.maintext)
                            Text("INSTANT HELP ").bold().font(Font.textbody).foregroundColor(Color.main)
                            Text("TODAY?").bold().font(Font.textbody).foregroundColor(Color.maintext)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            RadioButton(text: "Yes, Im ready", isOn: self.$ready)
                            Spacer()
                            RadioButton(text: "Not now", isOn: self.$ready)
                            Spacer()
                        }
                        GridCollection(instantCats, columns: 3, vSpacing: 10, hSpacing: 10, vPadding: 0, hPadding: 0,geometry: geometry) {
                            //CatViewItem(catObj: $0).environmentObject(self.viewRouter)
                            InstantCatViewItem(catObj: $0).environmentObject(self.viewRouter)
                        }
                        //
                    }.padding()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
        }
    }
    
}

struct InstantHelp_Previews: PreviewProvider {
    static var previews: some View {
        InstantHelp()
    }
}
