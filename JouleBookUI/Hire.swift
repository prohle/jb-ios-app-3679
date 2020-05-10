//
//  Hire.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct CandidatesView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var isInstant: Bool
    @Binding var candidateType: Int
    var candidateObjs: [Candidate] = [Candidate(id: 1,name: "Pham Van Mong",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$20 - $40", memberSince:Date(), responsiveless:"in hour", instantCats:[1,5]), Candidate(id: 2,name: "Pham Van Phong",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$30 - $50", memberSince:Date(), responsiveless:"in hour", instantCats:[2,4])]
    var body: some View {
        VStack{
            TextBold(text: String(self.candidateType))
            ForEach(candidateObjs){candidateObj in
                CandidateItemRow(candidateObj: candidateObj).environmentObject(self.viewRouter)
            }
        }
    }
}

struct Hire: View {
    @State var isInstant: Bool = true
    @State private var selectedView = 0
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading, spacing:15){
                    Group{
                        HStack(spacing:20){
                            FilterBnt(isActive: self.$isInstant,text: "Fast Instant")
                            FilterBnt(isActive: self.$isInstant,text: "All Candidates")
                            Spacer()
                            Button(action: {
                                
                            }){
                                IconText(imageIconLeft:"Artboard 33",text:"Filter",iconLeftSize:14)
                            }
                        }.padding([.vertical],5)
                        HStack{
                            Spacer()
                            CatViewItem(catObj: instantCats[0]).environmentObject(viewRouter)
                            
                            CatViewItem(catObj: instantCats[1]).environmentObject(viewRouter)
                            
                            CatViewItem(catObj: instantCats[2]).environmentObject(viewRouter)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            CatViewItem(catObj: instantCats[3]).environmentObject(viewRouter)
                            CatViewItem(catObj: instantCats[4]).environmentObject(viewRouter)
                            CatViewItem(catObj: instantCats[5]).environmentObject(viewRouter)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            CatViewItem(catObj: instantCats[6]).environmentObject(viewRouter)
                            CatViewItem(catObj: instantCats[7]).environmentObject(viewRouter)
                            CatViewItem(catObj: instantCats[8]).environmentObject(viewRouter)
                            Spacer()
                        }
                    }
                    Group{
                        HStack{
                            Spacer()
                            Button(action:{
                                self.selectedView = 0
                            }){
                                TabHeader(text: "Nearest", isActive: (self.selectedView == 0) ? true : false)
                            }
                            VeticleLine(color: .maintext, width: 2, height: 15)
                            
                            Button(action:{
                                self.selectedView = 1
                            }){
                                TabHeader(text: "Online",  isActive: (self.selectedView == 1) ? true : false)
                            }
                            VeticleLine(color: .maintext, width: 2, height: 15)
                            Button(action:{
                                self.selectedView = 2
                            }){
                                TabHeader(text: "Rating",  isActive: (self.selectedView == 2) ? true : false)
                            }
                            VeticleLine(color: .maintext, width: 2, height: 15)
                            Button(action:{
                                self.selectedView = 3
                            }){
                                TabHeader(text: "Project Complete",  isActive: (self.selectedView == 3) ? true : false)
                            }
                            Spacer()
                        }.frame(height: 20).padding(5).background(Color.white)
                        
                        CandidatesView(isInstant: self.$isInstant, candidateType: self.$selectedView).environmentObject(viewRouter)
                    }
                }.padding([.horizontal],CGFloat.stHpadding)
                .padding([.vertical],CGFloat.stVpadding)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}
struct TabHeader: View {
    var text: String = ""
    var isActive: Bool
    var body: some View {
        ZStack(alignment: .bottom){
            TextBold(text: self.text, color: (self.isActive == true) ? Color.main : Color.maintext).padding([.vertical],5)
            if(self.isActive == true){
                HorizontalLine(color: .main)
            }
        }.frame(width: self.getTabWidth())
    }
    func getTabWidth()->CGFloat{
        let tagWidths = self.text.widthOfString(usingFont: UIFont.preferredFont(forTextStyle: .subheadline))
        return tagWidths
    }
    
}
struct FilterBnt: View {
    @Binding var isActive: Bool
    var text: String
    var body: some View {
        Button(action: {
            self.isActive.toggle()
        }){
            NormalButton(btnText: self.text,fontSize: .textbody, textColor: (self.isActive == true) ? Color.textlink : Color.maintext, borderColor: (self.isActive == true) ? Color.textlink : Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(0.00), iconLeft: (self.isActive == true) ? "Artboard 69" : "")
        }
    }
}
struct CatViewItem: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var catObj: Category
    var body: some View {
        Button(action:{
            self.viewRouter.currentPage = "instantcat"
        }){
            VTextIcon(imageIconTop:catObj.icon,text:catObj.name, iconTopSize: 40, font: .textbody)
        }.padding(10).frame(width: CGFloat((UIScreen.main.bounds.width * 30) / 100)).background(Color.white).clipped()
        .shadow(color: Color.maintext, radius: 5, x: 0, y: 0)
        
    }
}
struct Hire_Previews: PreviewProvider {
    static var previews: some View {
        //CatViewItem(catObj: instantCats[0])
        Hire()
        //FilterBnt(isActive: true, text: "Test")
    }
}
