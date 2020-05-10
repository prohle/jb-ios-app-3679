//
//  ForgotPassword.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 5/8/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct ForgotPassword: View {
    @ObservedObject private var userViewModel = UserViewModel(from: "forgotpass")
    @State var presentAlert = false
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        Form {
            VStack(spacing:0){
                Text("Forgot Password").font( .headline).padding([.bottom],20)
                Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.main)) {
                    TextField("Your Email", text: $userViewModel.userName)
                    .autocapitalization(.none)
                    .padding(2)
                    HorizontalLine(color: .main)
                }
                /*Section(footer: Text(userViewModel.phoneMessage).foregroundColor(.main)) {
                    ZStack(alignment: .init(horizontal: .trailing, vertical: .top)){
                        TextField("Phone number", text: $userViewModel.mobile_number)
                            .autocapitalization(.none)
                            .padding(2)
                        TextBody(text:"Send SMS",color: (self.userViewModel.isPhoneValid == true) ? Color.textlink : Color.placeholder, font: Font.textsmall).onTapGesture {
                            self.userViewModel.sendOtpRequest()
                        }
                    }
                    HorizontalLine(color: .main)
                }*/
                Section(footer: Text(userViewModel.otpMessage).foregroundColor(.red)) {
                    SecureField("Verification code", text: $userViewModel.otp_code)
                        .disabled(!(self.userViewModel.isPhoneValid && self.userViewModel.isValid))
                    .padding(2)
                    HorizontalLine(color: .main)
                }
                Section(footer: Text(userViewModel.passwordMessage).foregroundColor(.red)) {
                    SecureField("New password", text: $userViewModel.password)
                    .font(.textbody)
                    .disabled(userViewModel.otp_code.isEmpty)
                    .padding(2)
                    HorizontalLine(color: .main)
                }
                
                Section {
                    BasicButton(btnText:"Complete",imageName: nil,isActive: (self.userViewModel.isPhoneValid && !userViewModel.otp_code.isEmpty)).frame(height: CGFloat.btnHeight).onTapGesture {
                        if self.userViewModel.isPhoneValid && !self.userViewModel.otp_code.isEmpty {
                            self.userViewModel.forgotPassword(viewRouter: self.viewRouter)
                        }
                    }
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Didnt received the code?").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext)
                    TextBody(text:"Resend code",color: (self.userViewModel.isPhoneValid == true) ? Color.textlink : Color.placeholder, font: Font.textsmall).onTapGesture {
                        self.userViewModel.reSendOtpRequest()
                    }
                    TextBody(text:"Back To Sign In",color: Color.textlink , font: Font.textbody).onTapGesture {
                        self.viewRouter.currentPage = "signin"
                    }
                    Spacer()
                }.padding([.vertical],10)
                Spacer()
            }
        }
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
