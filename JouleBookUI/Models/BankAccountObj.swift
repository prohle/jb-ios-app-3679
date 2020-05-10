//
//  BankAccountObj.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 5/5/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
import KeychainAccess
struct BankAccountObj: Identifiable,Hashable, Codable{
    var id:Int = -1
    var account_holder_name:String = ""
    var account_number:String = ""
    var country:String = ""
    var currency:String = ""
    var routing_number:String = ""
    var is_default:Bool = false
    var is_deleted:Bool = false
    var last_update_timestamp:String = ""
}
struct ListBankAccountObj: Decodable{
    var data: [BankAccountObj]
}
struct BankAccountQuery:Encodable{
    var account_holder_name:String = ""
    var account_number:String = ""
    var country:String = ""
    var currency:String = ""
    var routing_number:String = ""
}
struct CreateConnectAccountQuery: Encodable{
    var bank_account: BankAccountQuery = BankAccountQuery()
    var dob:String = ""
    var email:String = ""
    var first_name:String = ""
    var ip_address:String = ""
    var last_name:String = ""
    var product_description:String = ""
    var ssn_last4:String = ""
}
class ConnectAccountObservable: ObservableObject {
let objectWillChange = PassthroughSubject<ConnectAccountObservable,Never>()
    @Published var account_holder_name: String = ""
    @Published var account_number: String = ""
    @Published var country: String = ""
    @Published var currency: String = ""
    @Published var routing_number: String = ""
    
    @Published var dob:String = ""
    @Published var email:String = ""
    @Published var first_name:String = ""
    @Published var ip_address:String = ""
    @Published var last_name:String = ""
    @Published var product_description:String = ""
    @Published var ssn_last4:String = ""
    @Published var account_type:Int = 0
    init() {
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        self.email = (try? keychain.getString("user_email")) ??  ""
        self.last_name = (try? keychain.getString("last_name")) ??  ""
        self.dob = (try? keychain.getString("dob")) ??  ""
        self.first_name = (try? keychain.getString("first_name")) ??  ""
    }
    func submitConnectAccount() {
        
        let createConnectAccountQuery = CreateConnectAccountQuery(bank_account: BankAccountQuery(account_holder_name: self.account_holder_name,account_number: self.account_number,country:"USA",currency:"",routing_number: self.routing_number),dob: self.dob,email: self.email,first_name: self.first_name,ip_address:"",last_name: self.last_name,product_description:"",ssn_last4:"")
        debugPrint("----------------_Bank account request /BankAccountObj---------------------",createConnectAccountQuery)
        APIClient.postConnectAccount(createConnectAccountQuery: createConnectAccountQuery){result in
            switch result {
                case .success(let emptyWithIdData):
                    debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}

