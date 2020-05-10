//
//  InstantCatView.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/21/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct InstantCatView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var chosedCandidates: [SimpleCandidate]
    var candidateObjs: [Candidate] = [Candidate(id: 1,name: "Pham Van Mong",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$20 - $40", memberSince:Date(), responsiveless:"in hour", instantCats:[1,5], jobComplete: 8,currentDeals: 8,topSkills: ["Android","IOS"], aboutUs:"Lorem ipsum dolor"), Candidate(id: 2,name: "Pham Van Phong",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$30 - $50", memberSince:Date(), responsiveless:"in hour", instantCats:[2,4], jobComplete: 8,currentDeals: 8,topSkills: ["Android","IOS"], aboutUs:"Lorem ipsum dolor "), Candidate(id: 3,name: "Pham Van Phong 1",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$30 - $50", memberSince:Date(), responsiveless:"in hour", instantCats:[2,4], jobComplete: 8,currentDeals: 8,topSkills: ["Android","IOS"], aboutUs:"Lorem ipsum dolor"), Candidate(id: 4,name: "Pham Van Phong 2",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$30 - $50", memberSince:Date(), responsiveless:"in hour", instantCats:[2,4], jobComplete: 8,currentDeals: 8,topSkills: ["Android","IOS"], aboutUs:"Lorem ipsum dolor "), Candidate(id: 5,name: "Pham Van Phong 3",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$30 - $50", memberSince:Date(), responsiveless:"in hour", instantCats:[2,4], jobComplete: 8,currentDeals: 8,topSkills: ["Android","IOS"], aboutUs:"Lorem ipsum dolor sit amet")]
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 15  ){
                        if self.chosedCandidates.count > 0 {
                            HStack(alignment: .top){
                                TextBody(text: "You are offering job to: ")
                                GridCollection(self.chosedCandidates, columns: 3, vSpacing: 5, hSpacing: 5, vPadding: 0, hPadding: 0, geometry: geometry) {
                                    ImageUrlSameHeight(imageUrl:$0.attachUrl1,width: 50)
                                }
                                Spacer()
                                Button(action:{
                                    
                                }){
                                    NormalButton(btnText: "SEND OFFER",fontSize: .textsmall, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00))
                                }
                            }
                        }
                        ForEach(self.candidateObjs){candidateObj in
                            InstantCandidateItemRow(candidateObj: candidateObj, chosedCandidates: self.$chosedCandidates).environmentObject(self.viewRouter)
                        }
                    }.padding([.horizontal],CGFloat.stHpadding)
                    .padding([.vertical],CGFloat.stVpadding)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: InstantCatHomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}
struct InstantCatHomeLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "hire"
            }) {
                Image("Artboard 3").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
struct InstantCatView_Previews: PreviewProvider {
    static var previews: some View {
        InstantCatView(chosedCandidates: [])
    }
}
