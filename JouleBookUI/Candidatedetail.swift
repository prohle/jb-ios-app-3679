//
//  Candidatedetail.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct Candidatedetail: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var singleIsPresented = true
    @State var monthIndex: Int = 0
    @State var candidateObj: Candidate
    @ObservedObject var rkManager: RKManager = RKManager(calendar: Calendar.current, minimumDate: Date().addingTimeInterval(-60*60*24*365), maximumDate: Date().addingTimeInterval(60*60*24*365),  mode: 0, isCancleable: false)
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 30){
                        VStack(alignment: .center,spacing: 15){
                            ImageUrlSameHeight(imageUrl:self.candidateObj.attachUrl1,width: CGFloat((UIScreen.main.bounds.width * 70) / 100))
                            HStack(alignment: .center,spacing: 15){
                                Spacer()
                                VStack{
                                    TextBold(text: self.candidateObj.name)
                                    RatingBar()
                                    TextBody(text: self.candidateObj.location, color: Color.subtext)
                                }
                                HStack{
                                     TextBody(text: "JOBS\nCOMPLETE", color: Color.textlink,font: .textsmall)
                                     TextBold(text: "83", color: Color.textlink,font: .subheadline)
                                    }.padding(10).border(Color.textlink, width: 2)
                            }
                            HStack{
                                HStack{
                                    IconText(imageIconLeft:"Artboard 22",text:"Member Since: ",iconLeftSize:12,fontz: .textsmall)
                                    TextBody(text:self.getTextFromDate(date: self.candidateObj.memberSince, format: "MM, yyyy"),color:.main,font: .textsmall)
                                }
                                HStack{
                                    IconText(imageIconLeft:"Artboard 23",text:"Responsiveness: ",iconLeftSize:12,fontz: .textsmall)
                                    TextBody(text: self.candidateObj.responsiveless,color:.main,font: .textsmall)
                                }
                            }
                            HStack{
                                
                                Button(action: {
                                    
                                }){
                                    TextBody(text: "INVITE TO BID", color: Color.textlink)
                                }.padding(10).frame(width:CGFloat((UIScreen.main.bounds.width * 45) / 100)).border(Color.textlink, width: 1)
                                Button(action: {
                                    
                                }){
                                    TextBody(text: "CONTACT", color: Color.textlink)
                                }.padding(10).frame(width:CGFloat((UIScreen.main.bounds.width * 45) / 100)).border(Color.textlink, width: 1).cornerRadius(5, antialiased: true)
                            }
                            }.padding([.horizontal],CGFloat.stHpadding)
                            .padding([.vertical],CGFloat.stVpadding)
                            .background(Color.white)
                        
                        VStack(alignment: .leading,spacing: 15){
                            TextBody(text: "Schedule", color: .textlink, font: Font.headline)
                            RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager,monthIndex: self.$monthIndex)
                            HStack{Spacer()}
                            
                        }.padding([.horizontal],CGFloat.stHpadding)
                        .padding([.vertical],CGFloat.stVpadding).background(Color.white)
                    
                        VStack(alignment: .leading,spacing: 15){
                            HStack(spacing: 15){
                                VTextIcon(imageIconTop:"Artboard 111",text:"Gold Member",iconTopSize:36, isFullSize: false)
                                
                                VStack{
                                    TextBold(text: "Member since",font: .subheadline)
                                    Spacer()
                                    TextBold(text: self.getTextFromDate(date: self.candidateObj.memberSince, format: "MM, yyyy"), color: .textlink, font: .subheadline)
                                }
                                VeticleLine(color: .border, width: 1)
                                VStack{
                                    TextBold(text: "Rating",font: .subheadline)
                                    Spacer()
                                    TextBold(text: "4.9", color: .textlink, font: .subheadline)
                                }
                                VeticleLine(color: .border, width: 1)
                                VStack{
                                    TextBold(text: "Viewed",font: .subheadline)
                                    Spacer()
                                    TextBold(text: "60", color: .textlink, font: .subheadline)
                                }
                            }.frame(height: 60)
                            HorizontalLine(color: .border, height: 1)
                            ReadMoreTexts(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit" ,fullText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur")
                        }.padding([.horizontal],CGFloat.stHpadding)
                        .padding([.vertical],CGFloat.stVpadding).background(Color.white)
     
                    VStack(alignment: .leading, spacing: 15){
                        TextBody(text: "Information Detail", color:.textlink, font: .headline)
                        HorizontalLine(color: .border, height: 1)
                        ViewSkills(skillsOne: self.$candidateObj.skillsOne, skillsTwo: self.$candidateObj.skillsTwo, skillsThree: self.$candidateObj.skillsThree, skillsFour: self.$candidateObj.skillsFour )
                        
                        LicensesViewOnly(licenseObjs: self.$candidateObj.licenseObjs)
                        
                    }.padding([.horizontal],CGFloat.stHpadding)
                    .padding([.vertical],CGFloat.stVpadding).background(Color.white)
                }.offset(y: -500).background(Color.mainback)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: DetailCandidateHomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
        
    }
    /*
    func CadidateDetailView()-> some View{
        let candidateObj: Candidate = Candidate(id: 1,name: "Pham Van Mong",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$20 - $40", memberSince:Date(), responsiveless:"in hour", instantCats:[1,5], jobComplete: 8,currentDeals: 8,topSkills: ["Android","IOS"], aboutUs:"Lorem ipsum dolor", location: "Los Angeles, CA")
         return AnyView(
            
            
        )
    }*/
}
struct DetailCandidateHomeLeftTopTabbar: View {
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
struct Candidatedetail_Previews: PreviewProvider {
    static var previews: some View {
        Candidatedetail(candidateObj: Candidate(id: 1,name: "Pham Van Mong",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$20 - $40", memberSince:Date(), responsiveless:"in hour", instantCats:[1,5], jobComplete: 8,currentDeals: 8,topSkills: ["Android","IOS"], aboutUs:"Lorem ipsum dolor", location: "Los Angeles, CA"))
    }
}
