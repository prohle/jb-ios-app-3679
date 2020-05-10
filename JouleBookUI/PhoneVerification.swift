//
//  PhoneVerification.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/21/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct PhoneVerification: View {
    @ObservedObject private var userViewModel = UserViewModel(from: "phoneverify")
    @State var presentAlert = false
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        Form {
            VStack(spacing:0){
                Text("Phone Verification").font( .headline).padding([.bottom],20)
                HStack{
                    Spacer()
                    Text("Sign Up").font(.textsmall).foregroundColor(Color.maintext)
                    Spacer()
                Text("Authenticate").font(.textsmall).foregroundColor(Color.maintext)
                    Spacer()
                    Text("Complete").font(.textsmall).foregroundColor(Color.placeholder)
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
                Section(footer: Text(userViewModel.phoneMessage).foregroundColor(.main)) {
                    ZStack(alignment: .init(horizontal: .trailing, vertical: .top)){
                        TextField("Phone number", text: $userViewModel.mobile_number)
                            .autocapitalization(.none)
                            .padding(2)
                        TextBody(text:"Send SMS",color: (self.userViewModel.isPhoneValid == true) ? Color.textlink : Color.placeholder, font: Font.textsmall).onTapGesture {
                            self.userViewModel.sendOtpRequest()
                        }
                    }
                    HorizontalLine(color: .main)
                }
                
                Section(footer: Text(userViewModel.otpMessage).foregroundColor(.red)) {
                    SecureField("Verification code", text: $userViewModel.otp_code)
                    .padding(2)
                    HorizontalLine(color: .main)
                }
                
                Section {
                    BasicButton(btnText:"Complete",imageName: nil,isActive: (self.userViewModel.isPhoneValid && !userViewModel.otp_code.isEmpty)).onTapGesture {
                        if self.userViewModel.isPhoneValid && !self.userViewModel.otp_code.isEmpty {
                            self.userViewModel.otpVerificationRequest(viewRouter: self.viewRouter)
                            //self.viewRouter.currentPage = "deals"
                        }
                    }
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Didnt received the code?").font(.textsmall).fontWeight(.regular).foregroundColor(Color.subtext)
                    TextBody(text:"Resend code",color: (self.userViewModel.isPhoneValid == true) ? Color.textlink : Color.placeholder, font: Font.textsmall).onTapGesture {
                        self.userViewModel.reSendOtpRequest()
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
