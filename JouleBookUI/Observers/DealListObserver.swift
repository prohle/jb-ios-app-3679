//
//  DealListObserver.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/11/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import Foundation
import SwiftUI
import Combine
//import Alamofire
class DealListObserver : ObservableObject{
    @Published var deals = [Deal]()

    init() {
        getDeals()
    }
    
    func getDeals()
    {
       /* Alamofire.request("https://bookeeng.xyz/api/deal_list/ios.php",
                   method:.get
        ).responseJSON{response in
            debugPrint(response)
        }
        Alamofire.request("https://bookeeng.xyz/api/deal_list/ios.php")
            .responseJSON{
                response in
                if let json = response.result.data {
                    if  (json as? [String : AnyObject]) != nil{
                        if let dictionaryArray = json as? Dictionary<String, AnyObject?> {
                            let jsonArray = dictionaryArray["data"]
                            if let jsonArray = jsonArray as? Array<Dictionary<String, AnyObject?>>{
                                for i in 0..<jsonArray.count{
                                    let json = jsonArray[i]
                                    print(json)
                                    if let id = json["id"] as? Int,
                                    let nameString = json["name"] as? String,
                                    let categoryString = json["category"] as? String,
                                        let cityString = json["city"] as? String,
                                        let stateString = json["state"] as? String,
                                        let parkString = json["park"] as? String,
                                    {
                                        self.deals.append(Deal(id: id, name: nameString, category:new Category(categoryString)))
                                    }
                                }
                            }
                        }
                    }
                }
        }*/
    }
}
