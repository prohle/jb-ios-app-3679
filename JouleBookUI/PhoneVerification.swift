//
//  PhoneVerification.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/21/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct PhoneVerification: View {
    @ObservedObject private var userViewModel = UserViewModel()
    @State var presentAlert = false
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        Form {
            VStack(spacing:0){
                Text("Phone Verification").font( .headline).padding([.bottom],20)
                HStack{
                    Spacer()
                    Text("Sign Up").font(.footnote).foregroundColor(Color.maintext)
                    Spacer()
                Text("Authenticate").font(.footnote).foregroundColor(Color.maintext)
                    Spacer()
                    Text("Complete").font(.footnote).foregroundColor(Color.placeholder)
                    Spacer()
                }
                HStack{
                    Spacer()
                    Text("").frame(width: 10, height: 10)
                        .background(Color.main)
                        .cornerRadius(5)
                    Spacer().frame(width:95, height:3).background(Color.main)
                    Text("").frame(width: 10, height: 10)
                        .background(Color.main)
                        .cornerRadius(5)
                    Spacer().frame(width:95, height:3).background(Color.placeholder)
                    Text("").frame(width: 10, height: 10)
                    .background(Color.placeholder)
                    .cornerRadius(5)
                    Spacer()
                }.padding([.vertical],10)
                Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.red)) {
                    ZStack(alignment: .init(horizontal: .trailing, vertical: .top)){
                        TextField("Phone number", text: $userViewModel.userName)
                            .autocapitalization(.none)
                            .padding(2)
                        SmallTextLink(text:"Send SMS")
                    }
                    HorizontalLine(color: .main)
                }
                
                Section(footer: Text(userViewModel.passwordMessage).foregroundColor(.red)) {
                    
                    SecureField("Password", text: $userViewModel.password)
                    .padding(2)
                    HorizontalLine(color: .main)
                    //SecureField("Confirm Password", text: $userViewModel.confirmPassword)
                }
                
                Section {
                
                    //HStack(alignment: .center) {
                        Button(action: {
                            self.viewRouter.currentPage = "deals"
                        }) {
                            BasicButton(btnText:"Complete",imageName: nil,isActive: false)
                            //Text("Sign up")
                        }
                        .disabled(!userViewModel.isValid)
                    //}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Didnt received the code?").font(.footnote).fontWeight(.regular).foregroundColor(Color.subtext)
                    Button(action: {
                        self.Print("OK")
                        //self.signIn()
                    }) {
                        SmallTextLink(text:" Resend code")
                    }
                    
                    Spacer()
                }.padding([.vertical],10)
                Spacer()
            }.padding([.vertical],20)/*VStack**/
        }
    }
    
}

struct PhoneVerification_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerification()
    }
}
