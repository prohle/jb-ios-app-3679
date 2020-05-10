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
import KeychainAccess
import SwiftyRSA
//import Squid
struct SignIn: View {
    //@EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject private var userViewModel = UserViewModel()
    //@State var msgAlert:String = "Mong"
    //@EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var viewrouter: ViewRouter
    
    var body: some View {
        VStack(alignment: .center,spacing:10){
            Text("Sign in").font( .headline)
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
                    self.Login()
                },
                label:{
                    BasicButton(btnText:"Sign in",imageName: nil,isActive: true)
                }
            ).frame(height: 35)
            //.disabled(!userViewModel.isValid)
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
    func Login(){
        //let api = HttpAuth()
        //api.checkDetails(username: "asdasd", password: "sdasd")
        /*let api = MyApi()
        let request = TodoRequest(id: 1)
        let response = request.schedule(with: api)
        // The following request will be scheduled to `https://jsonplaceholder.typicode.com/todos/1`
        
        let c = response.sink(receiveCompletion: { completion in
            print(completion)
            switch completion {
                case .failure(let error):
                    print("Request failed due to: \(error)")
                case .finished:
                    print("Request finished.")
            }
        }) { todo in
            //self.msgAlert = todo.title
           print("Received toto: \(todo)")
        }*/
        
        let publicKey = try! PublicKey(pemEncoded: String.rsapublickey)
        
        let clear = try! ClearMessage(string: self.userViewModel.password, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)

        let data = encrypted.data
        //debugPrint(data.base64EncodedString())
        let heads: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "client_id": "client_id_id_client",
            "client_secret": "client_secret_secret_client"
        ]
        let parameters: [String: String] = [
            "grant_type":"password",
            "username": self.userViewModel.userName,
            "password":data.base64EncodedString(),
            "client_id": "client_id_id_client"
        ]
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        AF.request("https://api-gateway.joulebook.com/api-gateway/v1.0/user/oauth/token",
            method: .post,
            parameters: parameters,
            headers:heads
            ).responseJSON{response in
                //guard response.result.mapError(<#T##transform: (AFError) -> Error##(AFError) -> Error#>)
               //debugPrint(response)
                guard let data = response.data else{ return }
                let finalData = try! JSONDecoder().decode(TokenMessage.self, from: data)
                if finalData.access_token != nil && finalData.access_token != "" {
                    DispatchQueue.main.async {
                        //self.userViewModel.accessToken = finalData.access_token
                        //self.userViewModel.refreshToken = finalData.refresh_token
                        self.viewrouter.loggedIn = true
                        self.viewrouter.currentPage = "home"
                        do {
                            try keychain.set(finalData.access_token!, key: "access_token")
                            try keychain.set(finalData.refresh_token!, key: "refresh_token")
                        }
                        catch let error {
                            print(error)
                        }
                        //self.authenticated = true
                    }
                }
            }
            /*let keychain = Keychain(service: "ISOWEB.JouleBookUI")
            //var keychain: KeychainService =
            //keychain.store("", for: "access_token")
            //keychain.store("", for: "refresh_token")
            var auth = JBAuthApi(keychain: keychain)
            var cancellable: Cancellable?
            let request = LoginRequest(username: "ngocson031097@gmail.com",password:"hTxmRcEkLljAxhWaT2nrv1DEsJ6YbeITOKZc6WrVDNJCNKRGVoccHohsnSlHBNsvPGkxY6UCo1JS47t3cZvfIJeXCteLmukWvd7cfDBd4anax%2FiT74enSangMHLQyCA2hLHa0ojusLLR%2BbW%2FyLejXW7fgQXVDeIQHpOaRLDnXgo%3D")
                
                cancellable = request.schedule(with: auth).sink(receiveCompletion: { completion in
                
                    switch completion {
                case .failure(let error):
                    print("Request failed due to: \(error)")
                case .finished:
                    print("Request finished.")
                }
            }) { value in
                print("Received tokens: \(value)")
                //auth.accessToken = value.accessToken
                //auth.refreshToken = value.refreshToken
                //print("accessToken: "+value.accessToken)
                // The request finished successfully, retry the original request
                //promise(.success(true))
            }*/
       
    }
}
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
