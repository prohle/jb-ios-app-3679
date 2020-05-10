//
//  CardObj.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 5/5/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
import Stripe
import KeychainAccess

struct CardSetupData: Decodable{
    var client_secret: String = ""
}
struct CardSetupsObj: Decodable{
    var data: CardSetupData
}
struct CardObj: Identifiable,Hashable, Codable{
    var id:Int = -1
    var brand:String = ""
    var created_timestamp:String = ""
    var is_default:Bool = false
    var is_deleted:Bool = false
    var last4:String = ""
    var last_update_timestamp:String = ""
}
struct ListCardObj: Decodable{
    var data: [CardObj]
}
struct CreateCardQuery: Encodable{
    var is_default:Bool = false
    var token_id:String = ""
}
class CardObservable: ObservableObject {
let objectWillChange = PassthroughSubject<CardObservable,Never>()
    @Published var is_default: Bool = false
    @Published var token_id: String = ""
    @Published var stripeID: String = ""{
        didSet {
            self.submitCard()
            objectWillChange.send(self)
        }
    }
    @Published var cardSetupsObj: CardSetupsObj = CardSetupsObj(data: CardSetupData()){
        didSet {
            objectWillChange.send(self)
        }
    }
    init() {
        submitCardSetups()
    }
    func submitCardSetups(){
        APIClient.cardSetups(){result in
            switch result {
                case .success(let cardSetupsObj):
                    debugPrint("______________CardSetupsObj_______________",cardSetupsObj)
                    self.cardSetupsObj = cardSetupsObj
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    func submitCard() {
        let createCardQuery = CreateCardQuery(is_default: self.is_default,token_id: self.stripeID)
        debugPrint("______________CardQuery_______________",createCardQuery)
        APIClient.postCard(createCardQuery: createCardQuery){result in
            switch result {
                case .success(let emptyWithIdData):
                    debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}
