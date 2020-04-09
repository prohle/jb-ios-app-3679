//
//  GetHired.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct GetHired: View {
    var body: some View {
        NavigationView {
            //ScrollView(showsIndicators: false) {
                VStack{
                    List(jobDatas){jobData in
                        ZStack {
                            ItemJobListRow(jobObject: jobData)
                            NavigationLink(destination: JobDetail(jobObject: jobData)) {
                                EmptyView()
                            }.buttonStyle(PlainButtonStyle())
                        }
                        /*NavigationLink(destination: JobDetail(jobObject: jobData)){
                            ItemJobListRow(jobObject: jobData)
                        }*/
                    }
                }.padding([.horizontal],CGFloat.stHpadding)
                .padding([.vertical],CGFloat.stVpadding)
           // }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}

struct GetHired_Previews: PreviewProvider {
    static var previews: some View {
        GetHired()
    }
}
