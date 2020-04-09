//
//  CandidateItemRow.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/20/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct InstantCandidateItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var candidateObj: Candidate
    @Binding var chosedCandidates: [SimpleCandidate]
    var body: some View {
        HStack(alignment: .firstTextBaseline,spacing:0){
            Button(action:{
                self.viewRouter.currentPage = "candidatedetail"
                self.viewRouter.objectId = self.candidateObj.id
            }){
                ZStack(alignment: .topLeading){ ImageUrlSameHeight(imageUrl:candidateObj.attachUrl1,width: CGFloat((UIScreen.main.bounds.width * 25) / 100))
                    Text("Test")
                }.padding(.top,5)
                .padding(.horizontal,5)
            }
            
            VStack(alignment: .leading,spacing:5){
                HStack(alignment:.top ,spacing: 5){
                    Button(action:{
                        self.viewRouter.currentPage = "candidatedetail"
                        self.viewRouter.objectId = self.candidateObj.id
                    }){
                        VStack(alignment:.leading,spacing: 3){
                            TextBold(text: candidateObj.name)
                            RatingBar()
                        }
                    }
                    Spacer()
                    Button(action:{
                        if(self.chosedCandidates.contains(SimpleCandidate(id: self.candidateObj.id,attachUrl1: self.candidateObj.attachUrl1)) == true){
                            self.chosedCandidates.remove(at: self.chosedCandidates.firstIndex(where: { $0.id == self.candidateObj.id})!)
                        }else{
                            self.chosedCandidates.append(SimpleCandidate(id: self.candidateObj.id,attachUrl1: self.candidateObj.attachUrl1))
                        }
                    }){
                        NormalButton(btnText: "OFFER INSTANTLY",fontSize: .textsmall, textColor: (chosedCandidates.contains(SimpleCandidate(id: self.candidateObj.id,attachUrl1: self.candidateObj.attachUrl1)) == true) ? Color.white : Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00), background: (chosedCandidates.contains(SimpleCandidate(id: self.candidateObj.id,attachUrl1: self.candidateObj.attachUrl1)) == true) ? Color.main : Color.white)
                    }
                }
                
                HStack{
                    Button(action:{
                        self.viewRouter.currentPage = "candidatedetail"
                        self.viewRouter.objectId = self.candidateObj.id
                    }){
                        VStack(alignment: .leading){
                            HStack{
                                IconText(imageIconLeft:"Artboard 66",text:"Jobs Complete: ",iconLeftSize:12,fontz: .textsmall)
                                TextBody(text:String(candidateObj.jobComplete),color:.main,font: .textsmall)
                            }
                            HStack{
                                IconText(imageIconLeft:"Artboard 22",text:"Member Since: ",iconLeftSize:12,fontz: .textsmall)
                                TextBody(text:self.getTextFromDate(date: candidateObj.memberSince, format: "MM, yyyy"),color:.main,font: .textsmall)
                            }
                        }
                        
                        Spacer()
                        VStack(alignment: .leading){
                            HStack{
                                IconText(imageIconLeft:"Artboard 67",text:"Current deals: ",iconLeftSize:12,fontz: .textsmall)
                                TextBody(text:String(candidateObj.currentDeals),color:.main,font: .textsmall)
                            }
                            HStack{
                                IconText(imageIconLeft:"Artboard 23",text:"Responsiveness: ",iconLeftSize:12,fontz: .textsmall)
                                TextBody(text: candidateObj.responsiveless,color:.main,font: .textsmall)
                            }
                            
                        }
                    }
                }
            }.padding(5)
        }
    }
}

struct CandidateItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var candidateObj: Candidate
    var body: some View {
        HStack(alignment: .top,spacing:0){
            Button(action:{
                self.viewRouter.currentPage = "candidatedetail"
                self.viewRouter.objectId = self.candidateObj.id
            }){
            /*ZStack(alignment: .topLeading){*/
            ImageUrlSameHeight(imageUrl:candidateObj.attachUrl1,width: CGFloat((UIScreen.main.bounds.width * 25) / 100))
                //Text("Test")
            //}.padding(.top,5)
            
            VStack(alignment: .leading,spacing:5){
                HStack(alignment:.top ,spacing: 5){
                    VStack(alignment:.leading,spacing: 3){
                        TextBold(text: candidateObj.name)
                        RatingBar()
                    }
                    Spacer()
                    NormalButton(btnText: "Contact",fontSize: .textbody, textColor: Color.main, borderColor: Color.main, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(3.00))
                }
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            IconText(imageIconLeft:"Artboard 66",text:"Jobs Complete: ",iconLeftSize:12,fontz: .textsmall)
                            TextBody(text:String(candidateObj.jobComplete),color:.main,font: .textsmall)
                        }
                        HStack{
                            IconText(imageIconLeft:"Artboard 22",text:"Member Since: ",iconLeftSize:12,fontz: .textsmall)
                            TextBody(text:self.getTextFromDate(date: candidateObj.memberSince, format: "MM, yyyy"),color:.main,font: .textsmall)
                        }
                    }
                    
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            IconText(imageIconLeft:"Artboard 67",text:"Current deals: ",iconLeftSize:12,fontz: .textsmall)
                            TextBody(text:String(candidateObj.currentDeals),color:.main,font: .textsmall)
                        }
                        HStack{
                            IconText(imageIconLeft:"Artboard 23",text:"Responsiveness: ",iconLeftSize:12,fontz: .textsmall)
                            TextBody(text: candidateObj.responsiveless,color:.main,font: .textsmall)
                        }
                        
                    }
                }
                HStack{
                    TextBody(text: "Top Skills: ")
                    TextBody(text: candidateObj.topSkills.joined(separator: ","))
                    Spacer()
                }
                HorizontalLine(color: .border)
                //TextBody(text: candidateObj.aboutUs)
                ReadMoreTexts(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit" ,fullText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur")
            }.padding(5)
            }
        }
    }
}

struct CandidateItemRow_Previews: PreviewProvider {
    static var previews: some View {
        CandidateItemRow(candidateObj: Candidate(id: 1,name: "Pham Van Mong",attachUrl1: "https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg", isInstant: true, rating: CGFloat(4.5), ratingNumber:20, moneyRate:"$20 - $40", memberSince:Date(), responsiveless:"in hour", instantCats:[1,5]))
    }
}
