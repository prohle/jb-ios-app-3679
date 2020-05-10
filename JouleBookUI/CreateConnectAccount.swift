//
//  CreateConnectAccount.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 5/8/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct CreateConnectAccount: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var connectAccountObservable = ConnectAccountObservable()
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    VStack{
                        HStack{
                            IconText(imageIconLeft: nil,text: "Full Name", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextBody(text: "\(connectAccountObservable.first_name) \(connectAccountObservable.last_name)")
                        }
                        HStack{
                            IconText(imageIconLeft: nil,text: "Account Number", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("Account Number", text: $connectAccountObservable.account_number)
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: nil,text: "Bank Name", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("Bank Name", text: $connectAccountObservable.account_holder_name)
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: nil,text: "Routing Number", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("Routing Number", text: $connectAccountObservable.routing_number)
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: nil,text: "Account type", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            GroupRadioButton(radioBoxs: [RadioBox(id:1,text: "Checking"),RadioBox(id:2,text: "Saving"),], selectedVal: self.$connectAccountObservable.account_type)
                        }
                        BasicButton(btnText:"Save Bank Account",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody).onTapGesture {
                            self.connectAccountObservable.submitConnectAccount()
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: ConnectAccountTopSaveTabbar().environmentObject(self.connectAccountObservable))
        }
    }
}
struct ConnectAccountTopSaveTabbar: View {
    @EnvironmentObject var connectAccountObservable: ConnectAccountObservable
    var body: some View {
        HStack{
            Button(action: {
                self.connectAccountObservable.submitConnectAccount()
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
struct CreateConnectAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateConnectAccount()
    }
}
