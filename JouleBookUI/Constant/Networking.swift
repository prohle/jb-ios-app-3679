//
//  Networking.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
struct K {
    struct ProductionServer {
        static let baseURL = "https://api-gateway.joulebook.com/api-gateway"
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
