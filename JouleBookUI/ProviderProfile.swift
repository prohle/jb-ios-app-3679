//
//  ProviderProfile.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct ProviderProfile: View {
    @ObservedObject private var providerProfileModel = ProviderProfileModel()
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView {
        ScrollView(showsIndicators: false) {
        /*VStack(alignment:.leading, spacing:7){
            ScrollView(showsIndicators: false) {*/
                VStack(alignment:.center){
                    HStack{
                        Spacer()
                        ZStack(alignment: .bottomTrailing) {
                            Image("Artboard3")
                                .resizable()
                                .frame(width:120,height:120)
                            //ImageUrl(imageUrl: dealDatas[0].getImgUrl())
                            Text("Edit")
                                .padding(4)
                                .frame(width:120)
                                .font(Font.textbody)
                                .background(Color.placeholder)
                                .foregroundColor(Color.maintext)
                                
                                //.offset(x: -5, y: -5)
                        }.clipShape(Circle())
                        Spacer()
                    }.padding([.vertical],CGFloat.stVpadding)
                    .background(Color.mainback)
                }
                Group{
                    HStack{
                        TextBody(text: "Background check status")
                        Spacer()
                        TextBody(text: "pending",align: .trailing, color: Color.main)
                    }.padding([.horizontal],CGFloat.stHpadding)
                    
                    HorizontalLine(color: .border)
                    
                    HStack{
                        TextBody(text: "Website")
                        Spacer()
                        TextField("Peter", text:$providerProfileModel.websiteAdr)
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                    }.padding([.horizontal],CGFloat.stHpadding)
                    
                    HorizontalLine(color: .border)
                    
                    VStack(alignment: .leading){
                        TextBody(text: "About me")
                        TextField("For example: We are a privated-owned company with 1 employees. Our ", text:$providerProfileModel.websiteAdr).font(.textbody).multilineTextAlignment(.trailing).autocapitalization(.none).padding([.vertical],2)
                    }.padding([.horizontal],CGFloat.stHpadding)
                    
                    HorizontalLine(color: .border)
                    
                    HStack{
                        TextBody(text: "Offline Interview")
                        Spacer()
                        TextBody(text: ">",align: .trailing, color: Color.main)
                    }.padding(CGFloat.stHpadding)
                   
                    HorizontalLine(color: .border)
                    
                    HStack{
                        TextBody(text: "Bank Account")
                        Spacer()
                        TextBody(text: ">",align: .trailing, color: Color.main)
                    }.padding(CGFloat.stHpadding)
                    
                    HorizontalLine(color: .border)
                }
                
                EditSkills(skillsOne: self.$providerProfileModel.skillsOne, skillsTwo: self.$providerProfileModel.skillsTwo, skillsThree: self.$providerProfileModel.skillsThree, skillsFour: self.$providerProfileModel.skillsFour )
                Group{
                    Licenses(licenseObjs: self.$providerProfileModel.licenseObjs).environmentObject(viewRouter)
                }
                    
            }.padding([.bottom],15)
        //}
           // }//.offset(x: 0, y: -80)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: ProviderProfileHomeLeftTopTabbar(), trailing: ProviderProfileTopSaveTabbar(providerProfileModel: self.providerProfileModel))
        }
    }
}
struct ProviderProfileTopSaveTabbar: View {
    var providerProfileModel: ProviderProfileModel
    var body: some View {
        HStack{
            Button(action: {
                debugPrint(self.providerProfileModel.skillsOne.count)
            }) {
                Image( "Artboard 8")
                    .resizable()
                    .imageScale(.small)
                    .frame(width:20,height:20)
                    .accentColor(Color.main)
            }
        }
    }
}
struct ProviderProfileHomeLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "myaccount"
            }) {
                Image("Artboard 3").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
struct ProviderProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProviderProfile()
    }
}
