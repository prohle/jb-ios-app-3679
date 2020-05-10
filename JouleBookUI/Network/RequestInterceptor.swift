//
//  RequestInterceptor.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/1/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import KeychainAccess
protocol AccessTokenStorage: class {
    typealias JWT = String
    var accessToken: JWT { get set }
    var refreshToken: JWT { get set }
}
struct TokenMessage:Decodable{
    var access_token: String?
    var refresh_token: String?
    var error: String?
    var error_description: String?
}
class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private let storage: Keychain
    //private var viewrouter: ViewRouter
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    private var isRefreshing = false
    private var cantRefresh = false
    init(storage: Keychain) {
        self.storage = storage
        //self.viewrouter = viewrouter
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        /*guard urlRequest.url?.absoluteString.hasPrefix("joulebook.com") == true else {
            /// If the request does require authentication, we can directly return it as unmodified.
            return completion(.success(urlRequest))
        }*/
        var urlRequest = urlRequest
        let token = (try? storage.getString("access_token")) ??  ""
        urlRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
        urlRequest.setValue("client_secret_secret_client", forHTTPHeaderField: "client_secret")
        urlRequest.setValue("client_id_id_client", forHTTPHeaderField: "client_id")
        /// Set the Authorization header value using the access token.
        urlRequest.setValue("Bearer "+token , forHTTPHeaderField: "Authorization")
        
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        debugPrint("Test resaaaa")
        
        /*guard let afError = error.asAFError else{
            self.isRefreshing = true
            return completion(.doNotRetryWithError(error))
        }*/
        let afError = error.asAFError
        
        //
        //, ((afError.underlyingError as? ServerRestApiError)?.code != "access_token_expire")
        //debugPrint(afError.underlyingError)
        if(afError?.underlyingError as? ServerRestApiError)?.code ?? "" != "access_token_expire" {
            self.isRefreshing = true
            return completion(.doNotRetryWithError(error))
        }
        //debugPrint((afError.underlyingError as! ServerRestApiError).code )
        /*debugPrint(request.response)
        //debugPrint(request.task?.response)*
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 400 && self.cantRefresh == false else {
            self.isRefreshing = true
            //stop and logout
            return completion(.doNotRetryWithError(error))
        }*/
        
        
        /*Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime.
         Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.*/
        refreshToken { [weak self] succeeded, accessToken, refreshToken in
           // guard let self = self else { return }
            guard let strongSelf = self else { return }
            if(succeeded == true){
                if let accessToken = accessToken {
                    do {
                        try strongSelf.storage.set(accessToken, key: "access_token")
                    }
                    catch let error {
                        print(error)
                    }
                }
                if let refreshToken = refreshToken {
                    do {
                        try strongSelf.storage.set(refreshToken, key: "refresh_token")
                    }
                    catch let error {
                        print(error)
                    }
                }
                completion(.retry)
            }else{
                //strongSelf.viewrouter.loggedIn = false
                //strongSelf.viewrouter.currentPage = "signin"
                do {
                    try strongSelf.storage.set("",key:"access_token")
                    try strongSelf.storage.set("",key:"refresh_token")
                } catch let error {
                    print("error: \(error)")
                }
                completion(.doNotRetryWithError(error))
            }
        }
    }
    private func refreshToken(completion: @escaping RefreshCompletion) {
        guard !self.isRefreshing else { return }
        let refreshtoken = (try? storage.getString("refresh_token")) ??  ""
        guard refreshtoken != "" else { return }
        APIClient.refreshToken(refreshToken: refreshtoken){result in
            switch result {
                case .success(let finalData):
                    print("________________REFRESHTOKEN_____________")
                    if finalData.access_token != nil && finalData.access_token != "" {
                        DispatchQueue.main.async {
                            completion(true, finalData.access_token, finalData.refresh_token)
                        }
                    }else {
                        completion(false, nil, nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                completion(false, nil, nil)
            }
        }
        /*
        let urlString = "https://api-gateway.joulebook.com/api-gateway/v1.0/user/oauth/token"
        let heads: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "client_id": "client_id_id_client",
            "client_secret": "client_secret_secret_client"
        ]
        let parameters: [String: String] = [
            "grant_type":"refresh_token",
            "refresh_token": try! self.storage.get("refresh_token")!,
            "client_id": "client_id_id_client"
        ]
        AF.request(urlString,
            method: .post,
            parameters: parameters,
            headers:heads
        ).responseJSON { [weak self] response in
            debugPrint("Test res")
            debugPrint(response)
            guard let strongSelf = self else { return }
            guard let data = response.data else{ return }
            let finalData = try! JSONDecoder().decode(TokenMessage.self, from: data)
            if  finalData.access_token != nil && finalData.access_token != "" {
                DispatchQueue.main.async {
                    completion(true, finalData.access_token, finalData.refresh_token)
                }
            } else {
                completion(false, nil, nil)
            }
            strongSelf.isRefreshing = false
        }*/
    }
}
