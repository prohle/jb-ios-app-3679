//
//  MainMenu.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import CoreLocation

struct MainMenu: View {
    var body: some View {
        VStack(alignment:.leading,spacing: 0){
            HStack{
                CircleImage(imageUrl: dealDatas[0].attachUrl1,size:36)
                VStack{
                    Text("Pham Van Mong").font(.subheadline).bold().foregroundColor(Color.maintext)
                IconText(imageIconLeft:"app_icon",imageIconRight:"app_icon",text:"test",iconLeftSize:20,iconRightSize:10)
                }
                Spacer()
                VStack(alignment: .trailing,spacing: 5){
                    Text("Token: 68").font(.footnote).foregroundColor(Color.maintext)
                    Text("Credit: $2.0").font(.footnote).foregroundColor(Color.maintext)
                }
            }.padding()
            HStack{
                NavigationLink(destination: SignUp()) {
                    IconText(imageIconLeft:"app_icon",text:"test",iconLeftSize:20)
                }
            }
            Spacer()
        }
        
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
