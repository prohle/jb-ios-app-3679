//
//  SignUp.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
//https://blog.supereasyapps.com/how-to-fix-iphone-and-ipad-app-codesign-crashes-using-an-apple-developer-profile/
import SwiftUI
struct SignUp: View {
    @ObservedObject private var userViewModel = UserViewModel(from: "signup")
    @EnvironmentObject var viewRouter: ViewRouter
    //@EnvironmentObject var settings: UserSettings
    var body: some View {
        VStack(alignment: .center,spacing:10){
            Text("New Account").font( .headline)
            VStack(alignment: .leading,spacing:3){
                TextField("Your email", text: $userViewModel.userName)
                    .font(.textbody)
                    .autocapitalization(.none)
                    .padding(2)
                HorizontalLine(color: .main)
                Text(userViewModel.usernameMessage).font(Font.textsmall).foregroundColor(.red)
            }
            VStack(alignment: .leading,spacing:3){
                SecureField("Your password", text: $userViewModel.password)
                    .font(.textbody)
                    .padding(2)
                HorizontalLine(color: .main)
            }
            Button(action: {
                self.viewRouter.currentPage = "phoneverification"
            }) {
                BasicButton(btnText:"Sign up",imageName: nil,isActive: userViewModel.isValid)
            }.disabled(!userViewModel.isValid).frame(height: CGFloat.btnHeight)
            Button(
                action: {
                    self.viewRouter.currentPage = "signin"
                }
                ){
                    Text("Already have account ?").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext) + Text(" Sign in").font(.textbody).foregroundColor(Color.textlink)
            }
            /*ZStack {
                BasicButton(btnText:"Sign up",imageName: nil,isActive: true)
                NavigationLink(destination: PhoneVerification(), isActive: $userViewModel.isValid) {EmptyView()}.buttonStyle(PlainButtonStyle())
            }
            
            ZStack {
                Text("Already have account ?").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext) + Text(" Sign in").font(.footnote).foregroundColor(Color.textlink)
                NavigationLink(destination: SignIn()) {EmptyView()}.buttonStyle(PlainButtonStyle())
            }*/
            Text("By click \"Sign up\", you agree to the Joulebook").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext) + Text(" Privacy Policy").font(.textsmall).foregroundColor(Color.subtext).underline(true,color: Color.subtext) + Text(" and ").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext) + Text("Terms of Service").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext).underline(true,color: Color.subtext)
            Spacer()
        }.padding([.horizontal],CGFloat.stHpadding)
        .padding([.vertical],CGFloat.stVpadding)
        /*Form {
            VStack(alignment: .center){
                Text("New Account").font( .headline)
                Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.red)) {
                    TextField("Your email", text: $userViewModel.userName)
                        .autocapitalization(.none)
                        .padding(2)
                    HorizontalLine(color: .main)
                }
                Section(footer: Text(userViewModel.passwordMessage).foregroundColor(.red)) {
                    
                    SecureField("Your password", text: $userViewModel.password)
                    .padding(2)
                    HorizontalLine(color: .main)
                }
                Section {
                        Button(action: {
                            
                            self.viewRouter.currentPage = "phoneverification"
                            
                        }) {
                            BasicButton(btnText:"Sign up",imageName: nil,isActive: true)
                            //Text("Sign up")
                        }
                        .disabled(!userViewModel.isValid)
                }
                Button(action: {self.viewRouter.currentPage = "signin"}) {
                    Text("Already have account ?").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext) + Text(" Sign in").font(.footnote).foregroundColor(Color.textlink)
                }
                /*
                HStack(alignment: .lastTextBaseline) {
                    Text("Already have account ?").font(.footnote).fontWeight(.regular)
                    NavigationLink(destination: SignIn()) {
                        Text("Sign in").font(.body).foregroundColor(Color.textlink)
                    }.frame(width:70,height:nil,alignment: .leading)
                    
                }.padding([.vertical],10)*/
                Text("By click \"Sign up\", you agree to the Joulebook").font(.footnote).fontWeight(.regular).foregroundColor(Color.subtext) + Text(" Privacy Policy").font(.footnote).foregroundColor(Color.subtext).underline(true,color: Color.subtext) + Text(" and ").font(.footnote).fontWeight(.regular).foregroundColor(Color.subtext) + Text("Terms of Service").font(.footnote).fontWeight(.regular).foregroundColor(Color.subtext).underline(true,color: Color.subtext)
            }.padding()
        }*/
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
struct WelcomeView: View {
    var body: some View {
        Text("Welcome! Great to have you on board!")
    }
}
