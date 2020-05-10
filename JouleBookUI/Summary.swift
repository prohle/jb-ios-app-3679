//
//  Summary.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct SummaryItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var summaryObj: BookDeal
    var body: some View {
        HStack(alignment: .top,spacing:0){
            Button(action:{
            }){
                TextBody(text: "test")
            }.padding(5)
        }
    }
}
struct SummariesView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var summaryType: Int
    var summaryObjs: [BookDeal] = [BookDeal]()
    var body: some View {
        VStack{
            ForEach(summaryObjs){summaryObj in
                SummaryItemRow(summaryObj: summaryObj).environmentObject(self.viewRouter)
            }
        }
    }
}
struct Summary: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selectedView = 0
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            Button(action:{
                                self.selectedView = 0
                            }){
                                TabHeader(text: "In Process", isActive: (self.selectedView == 0) ? true : false)
                            }
                            VeticleLine(color: .maintext, width: 2, height: 15)
                            
                            Button(action:{
                                self.selectedView = 1
                            }){
                                TabHeader(text: "Pending Review",  isActive: (self.selectedView == 1) ? true : false)
                            }
                            VeticleLine(color: .maintext, width: 2, height: 15)
                            Button(action:{
                                self.selectedView = 2
                            }){
                                TabHeader(text: "Confirmed",  isActive: (self.selectedView == 2) ? true : false)
                            }
                            VeticleLine(color: .maintext, width: 2, height: 15)
                            Button(action:{
                                self.selectedView = 3
                            }){
                                TabHeader(text: "Complete",  isActive: (self.selectedView == 3) ? true : false)
                            }
                            Button(action:{
                                self.selectedView = 4
                            }){
                                TabHeader(text: "Closed",  isActive: (self.selectedView == 4) ? true : false)
                            }
                            Spacer()
                            
                        }.frame(height: 20).padding(5).background(Color.white)
                        Spacer()
                        SummariesView(summaryType: self.$selectedView).environmentObject(self.viewRouter)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary()
    }
}
