//
//  MyProfile.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/6/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct MyProfile: View {
    @ObservedObject var dobRKManager : RKManager = RKManager(calendar: Calendar.current, minimumDate: "01/01/1900".localDateStrToDate(), maximumDate: Date(),  mode: 0)
    @State var userProfile:UserProfile = UserProfile()
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
                    HStack{
                        TextBody(text: "DOB")
                        Spacer()
                        DateSelectorModal(monthIndex: 0).environmentObject(self.dobRKManager)
                    }
                }
                Group{
                    HStack{
                        TextBody(text: "First Name")
                        Spacer()
                        TextField("", text:$userProfile.first_name ?? "")
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        
                    }
                    HorizontalLine(color: .border)
                    HStack{
                        TextBody(text: "Midle Name")
                        Spacer()
                        TextField("", text:$userProfile.middle_name ?? "")
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                    }
                    HorizontalLine(color: .border)
                    HStack{
                        TextBody(text: "Last Name")
                        Spacer()
                        TextField("", text:$userProfile.last_name ?? "")
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        
                    }
                    HorizontalLine(color: .border)
                }
                Group{
                    HStack{
                        TextBody(text: "Email")
                        Spacer()
                        VStack{
                            TextField("", text:$userProfile.email ?? "")
                                .font(.textbody)
                                .disabled(true)
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
                            TextField("", text:$userProfile.mobile_number ?? "")
                                .font(.textbody)
                                .disabled(true)
                                .autocapitalization(.none)
                            .padding(2)
                            //Text(myProfileModel.mobileMessage).font(Font.textsmall).foregroundColor(.red)
                        }
                    }
                    Button(action: {
                        self.viewRouter.currentPage = "providerprofile"
                    },
                           label:{
                            BasicButton(btnText:"Become to Provider",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody)
                    })
                    
                }
            }.onAppear(perform: {
                self.getUserProfile()
            })
        }.padding([.horizontal],CGFloat.stHpadding)
        .padding([.vertical],CGFloat.stVpadding)
        .background(Color.mainback)
            }
            .onTapGesture {
                self.endEditing()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: MyProfileHomeLeftTopTabbar(), trailing: MyProfileTopSaveTabbar(userProfile: self.$userProfile).environmentObject(self.viewRouter)).environmentObject(self.dobRKManager)
        }
    }
    func getUserProfile(){
        APIClient.getUserProfile(){ result in
            switch result {
                case .success(let userProfile):
                    print("______________UserProfile_______________")
                    self.userProfile = userProfile.data
                    self.dobRKManager.selectedDate = self.userProfile.date_of_birth?.utcDateTimeStrToDate()
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
}
struct MyProfileTopSaveTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var userProfile:UserProfile
    @EnvironmentObject var dobRKManager : RKManager
    var body: some View {
        HStack{
            Button(action: {
                self.userProfile.date_of_birth = self.dobRKManager.selectedDate?.toUTCDateTimeStr() ?? Date().toUTCDateTimeStr()
                self.userProfile.submitMyProfileUpdate()
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
