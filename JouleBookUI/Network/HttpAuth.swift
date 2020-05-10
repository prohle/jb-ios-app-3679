//
//  HttpAuth.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/29/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.

//

import Foundation
import Combine
import SwiftUI
struct ServerMessage:Decodable{
    let access_token,refresh_token: String
    
}
class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth,Never>()
    var authenticated = false {
        didSet{
            didChange.send(self)
        }
    }
    func checkDetails(username:String,password: String) {
        guard let url = URL(string: "https://api-gateway.joulebook.com/api-gateway/v1.0/user/oauth/token?grant_type=password&username=ngocson031097@gmail.com&password=hTxmRcEkLljAxhWaT2nrv1DEsJ6YbeITOKZc6WrVDNJCNKRGVoccHohsnSlHBNsvPGkxY6UCo1JS47t3cZvfIJeXCteLmukWvd7cfDBd4anax%2FiT74enSangMHLQyCA2hLHa0ojusLLR%2BbW%2FyLejXW7fgQXVDeIQHpOaRLDnXgo%3D&client_id=client_id_id_client")
        else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("client_id_id_client", forHTTPHeaderField: "client_id")
        request.setValue("client_secret_secret_client", forHTTPHeaderField: "client_secret")
        URLSession.shared.dataTask(with: request ){(data,response,error) in
            guard let data = data else{ return }
            let finalData = try! JSONDecoder().decode(ServerMessage.self, from: data)
            if finalData.access_token != "" {
                DispatchQueue.main.async {
                    self.authenticated = true
                }
            }
        }.resume()
    }
}
