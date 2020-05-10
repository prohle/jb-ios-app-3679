//
//  SignIn.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/18/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import SwiftUI
import Foundation
import Combine
import Alamofire

//import Squid
struct SignIn: View {
    @ObservedObject private var userViewModel = UserViewModel(from: "signin")
    @EnvironmentObject var viewrouter: ViewRouter
    //@EnvironmentObject var locationUpdate: LocationUpdate
    //var latitude: String  { return("\(locationUpdate.location?.latitude ?? 0)") }
    //var longitude: String { return("\(locationUpdate.location?.longitude ?? 0)") }
    //var placemark: String { return("\(locationUpdate.placemark?.description ?? "XXX")") }
    var body: some View {
        VStack(alignment: .center,spacing:10){
            Text("Sign in").font( .headline)
            /*VStack {
                Text("Latitude: \(self.latitude)")
                Text("Longitude: \(self.longitude)")
                Text("Placemark: \(self.placemark)")
            }*/
            VStack(alignment: .leading,spacing:3){
                
                TextField("Email or Phone number", text:$userViewModel.userName)
                    .autocapitalization(.none)
                    .font(.textbody)
                .padding(2)
                HorizontalLine(color: .main)
                Text(userViewModel.usernameMessage)
                    .font(Font.textsmall)
                    .foregroundColor(.red)
            }
            VStack(alignment: .leading,spacing:3){
                SecureField("Password", text: $userViewModel.password)
                    .padding(2)
                    .font(.textbody)
                HorizontalLine(color: .main)
                Text(userViewModel.passwordMessage)
                    .font(Font.textsmall)
                    .foregroundColor(.red)
            }
            Button(
                action: {
                    //UserDefaults.standard.set(true, forKey: "Loggedin")
                    //UserDefaults.standard.synchronize()
                    //self.settings.loggedIn = true
                    self.userViewModel.login(viewRouter: self.viewrouter)
                },
                label:{
                    BasicButton(btnText:"Sign in",imageName: nil,isActive: self.userViewModel.isValid)
                }
            ).frame(height: CGFloat.btnHeight).disabled(!userViewModel.isValid)
            Button(
                action: {
                    self.viewrouter.currentPage = "forgotpassword"
                }
                ){
                    HStack{
                        Spacer()
                        SmallTextLink(text:"Forgot password")
                    }
            }
            Button(
                action: {
                    self.viewrouter.currentPage = "signup"
                }
                ){
                    Text("Dont have an account?").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext) + Text(" Become a member").font(.textsmall).foregroundColor(Color.textlink) + Text(" now ").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext)
            }
            /*Group{
                ZStack {
                    HStack{
                        Spacer()
                        SmallTextLink(text:"Forgot password")
                    }
                    NavigationLink(destination: SignIn()) {EmptyView()}.buttonStyle(PlainButtonStyle())
                }
                //ZStack(alignment: .center) {
                    
                    NavigationLink(destination: SignUp()) {
                        Text("Dont have an account?").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext) + Text(" Become a member").font(.textsmall).foregroundColor(Color.textlink) + Text(" now ").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext)
                    }.buttonStyle(PlainButtonStyle())
                //}
            }*/
            Spacer()
        }.padding([.horizontal],CGFloat.stHpadding)
        .padding([.vertical],CGFloat.stVpadding)
        
    }
    
}
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
