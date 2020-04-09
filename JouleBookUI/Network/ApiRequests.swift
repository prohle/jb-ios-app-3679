//
//  ApiRequests.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/29/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
/*
import Foundation
import Combine
import Squid

struct TokenRequestResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct LoginRequest: JsonRequest {
    typealias Result = TokenRequestResponse
    let username: String
    let password: String
    var method: HttpMethod {
        .post
    }
    var routes: HttpRoute {
        ["/v1.0/user/oauth/token?grant_type=password&username=ngocson031097@gmail.com&password=hTxmRcEkLljAxhWaT2nrv1DEsJ6YbeITOKZc6WrVDNJCNKRGVoccHohsnSlHBNsvPGkxY6UCo1JS47t3cZvfIJeXCteLmukWvd7cfDBd4anax%2FiT74enSangMHLQyCA2hLHa0ojusLLR%2BbW%2FyLejXW7fgQXVDeIQHpOaRLDnXgo%3D&client_id=client_id_id_client"]
    }
    var header: HttpHeader{
        [.contentType:"application/x-www-form-urlencoded"]
    }
    var body: HttpBody {
        HttpData.Json(["client_id": "client_id_id_client"])
        //HttpData.Json(["grant_type":"password","username": userName,"password":password,"client_id": "client_id_id_client"])
    }
}


struct TokenRequest: JsonRequest {

    typealias Result = TokenRequestResponse

    let refreshToken: String

    var method: HttpMethod {
        .post
    }

    var routes: HttpRoute {
        ["/v1.0/user/oauth/token"]
    }

    var body: HttpBody {
        HttpData.Json(["grant_type":"refresh_token","refresh_token": refreshToken,"client_id": "client_id_id_client"])
    }
}*/
