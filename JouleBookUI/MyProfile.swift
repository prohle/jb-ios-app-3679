//
//  MyProfile.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/6/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct MyProfile: View {
    
    @ObservedObject private var myProfileModel = MyProfileModel()
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView {
        ScrollView(showsIndicators: false) {
        VStack(alignment:.leading, spacing:7){
            HStack{
                Spacer()
            }
            ScrollView(showsIndicators: true) {
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
                        TextBody(text: "First Name")
                        Spacer()
                        TextField("Peter", text:$myProfileModel.firstName)
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        
                    }
                    HorizontalLine(color: .border)
                    HStack{
                        TextBody(text: "Midle Name")
                        Spacer()
                        TextField("Carter", text:$myProfileModel.midleName)
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                    }
                    HorizontalLine(color: .border)
                    HStack{
                        TextBody(text: "Last Name")
                        Spacer()
                        TextField("Mong", text:$myProfileModel.lastName)
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        
                    }
                    HorizontalLine(color: .border)
                    HStack{
                        TextBody(text: "Email")
                        Spacer()
                        VStack{
                            TextField("Email", text:$myProfileModel.emailAdr)
                                .font(.textbody)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                                .padding(2)
                            //Text(myProfileModel.emailMessage).font(Font.textsmall).foregroundColor(.red)
                        }
                    }
                    HorizontalLine(color: .border)
                    HStack{
                        TextBody(text: "Mobile Number")
                        Spacer()
                        VStack{
                            TextField("Mobile Number", text:$myProfileModel.mobileNum)
                                .font(.textbody)
                                .multilineTextAlignment(.trailing)
                                .autocapitalization(.none)
                            .padding(2)
                            //Text(myProfileModel.mobileMessage).font(Font.textsmall).foregroundColor(.red)
                        }
                    }
                }
                Group{
                    Button(action: {
                        self.viewRouter.currentPage = "providerprofile"
                    },
                           label:{
                            BasicButton(btnText:"Become to Provider",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody)
                    })
                    
                }
            }
        }.padding([.horizontal],CGFloat.stHpadding)
        .padding([.vertical],CGFloat.stVpadding)
        .background(Color.mainback)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: MyProfileHomeLeftTopTabbar(), trailing: MyProfileTopSaveTabbar())
        }
    }
}
struct MyProfileTopSaveTabbar: View {
    var body: some View {
        HStack{
            Button(action: {
                print("Edit button pressed...")
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
struct MyProfileHomeLeftTopTabbar: View {
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
struct MyProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyProfile()
    }
}
