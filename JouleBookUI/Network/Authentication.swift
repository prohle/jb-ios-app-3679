//
//  Authentication.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/28/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
/*
import Foundation
import Combine
import Squid
import KeychainAccess

protocol KeychainService {
    func store<K>(_ value: K, for key: String) where K: Encodable
    func load<K>(_ type: K.Type, for key: String) -> K where K: Decodable
}
struct JBAuthApi {

    private let keychain: Keychain
    
    init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    var accessToken: String {
        get {
            do {
                try keychain.get("access_token")
            }
            catch let error {
                print(error)
            }
            return ""
        } set {
            do {
                try keychain.set(newValue, key: "access_token")
            }
            catch let error {
                print(error)
            }
        }
    }

    var refreshToken: String {
        get {
            do {
                try  keychain.get("refresh_token")
            }
            catch let error {
                print(error)
                
            }
            return ""
        } set {
            do {
                try keychain.set(newValue, key: "refresh_token")
            }
            catch let error {
                print(error)
            }
        }
    }
}

extension JBAuthApi: HttpService {
    var apiUrl: UrlConvertible {
        "api-gateway.joulebook.com/api-gateway"
    }
    var header: HttpHeader{
        ["client_id":"client_id_id_client","client_secret":"client_secret_secret_client"]
    }
}

struct JBProtectedApi {

    private let auth: JBAuthApi

    init(auth: JBAuthApi) {
        self.auth = auth
    }
}

extension JBProtectedApi: HttpService {
    var apiUrl: UrlConvertible {
        "api-gateway.joulebook.com/api-gateway"
    }
    var header: HttpHeader {
        ["Authorization": "Bearer \(auth.accessToken)","Content-Type":"application/json","client_id":"client_id_id_client","client_secret":"client_secret_secret_client"]
    }
}

class AuthorizationRetrier: Retrier {

    private var auth: JBAuthApi
    private var cancellable: Cancellable?

    init(auth: JBAuthApi) {
        self.auth = auth
    }

    func retry<R>(_ request: R, failingWith error: Squid.Error) -> Future<Bool, Never> where R: Request {
        return Future { promise in
            switch error {
            case .requestFailed(statusCode: 401, response: _):
                // Here, we want to request a new token.
                let request = TokenRequest(refreshToken: self.auth.refreshToken)

                // Note that we do not need any synchronization primitives here as this retrier is used by a *single request*
                self.cancellable = request.schedule(with: self.auth).sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        // We don't need to do anything
                        break
                    case .failure(_):
                        // The request failed, we don't need to retry the original request
                        promise(.success(false))
                    }
                }) { value in
                    self.auth.accessToken = value.accessToken
                    self.auth.refreshToken = value.refreshToken

                    // The request finished successfully, retry the original request
                    promise(.success(true))
                }
            default:
                // Some other error occurred, we do not want to retry the request
                promise(.success(false))
            }
        }
    }
}
extension JBProtectedApi {
    var retrierFactory: RetrierFactory {
        return AnyRetrierFactory {
            return AuthorizationRetrier(auth: self.auth)
        }
    }
}*/
