//
//  AddressObj.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
extension Encodable {
    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}
struct ShortAddressObj:Codable{
    var address: String? = ""
    var building: String? = ""
    var city: String? = ""
    var floor: String? = ""
    var latitude: String? = ""
    var longitude: String? = ""
    var state: String? = ""
    var unit: String? = ""
    var zip_code: String? = ""
}
struct AddressObj: Identifiable,Hashable, Codable{
    var id:Int = -1
    var profile_id:Int = -1
    var address_name:String = ""
    var phone_number:String = ""
    var address:String = ""
    var address_line_2:String? = ""
    var city:String? = ""
    var state:String? = ""
    var zip_code:String? = ""
    //var building:String = ""
    //var floor:String = ""
    //var unit:String = ""
    //var suite_apt_number:String = ""
    var longitude:String = ""
    var latitude:String = ""
    var address_type:Int = 0
    var is_default:Bool = false
    var is_deleted:Bool = false
    var created_timestamp:String = ""
    var last_updated_timestamp:String = ""
    func getFullAddress() -> String {
        var fullAddress = [String]()
        if self.address != "" {
            return self.address
        }else{
            if self.address_name != "" {
                fullAddress.append(self.address_name)
            }
            if self.city != "" {
                fullAddress.append(self.city!)
            }
            if self.state != "" {
                fullAddress.append(self.state!)
            }
            if self.zip_code != "" {
                fullAddress.append(self.zip_code!)
            }
            return (fullAddress.count > 0) ? fullAddress.joined(separator: ", ") : ""
        }
    }
}
struct ListAddressObj: Decodable{
    var data: [AddressObj]
}
struct ShortCreateAddressQuery:Encodable{
    let address: String
    //let building: String
    let city: String
    let address_line_2: String?
    let latitude: String
    let longitude: String
    let state: String
    //let unit: String
    let zip_code: String
}
struct CreateAddressQuery: Encodable{
    let address: String
    let address_line_2: String?
    let address_name: String
    let address_type: Int
    //let building: String
    let city: String
    //let floor: String
    let latitude: String
    let longitude: String
    let phone_number: String
    let state: String
    //let suite_apt_number: String
    //let unit: String
    let zip_code: String
}
class AddressObservable: ObservableObject {
let objectWillChange = PassthroughSubject<AddressObservable,Never>()
    @Published var address: String = ""{
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var address_line_2: String? = ""
    @Published var address_name: String = ""
    @Published var address_type_1: Bool = false
    @Published var address_type_2: Bool = false
    @Published var address_type_3: Bool = false
    //@Published var building: String = ""
    @Published var city: String = ""
    //@Published var floor: String = ""
    @Published var latitude: Double =  0.00
    @Published var longitude: Double =  0.00
    @Published var phone_number: String = ""
    @Published var state: String = ""
    //@Published var suite_apt_number: String = ""
    //@Published var unit: String = ""
    @Published var zip_code: String = ""
    @Published var is_default: Bool = false
    func submitAddress() {
        var addressType = 1;
        if self.address_type_1 == true {
            addressType = 1
        }
        if self.address_type_2 == true {
            addressType = 2
        }
        if self.address_type_3 == true {
            addressType = 3
        }
        let createAddressQuery = CreateAddressQuery(address: self.address,address_line_2: self.address_line_2 ?? "", address_name: self.address_name, address_type: addressType, city: self.city,  latitude: String(self.latitude), longitude: String(self.longitude), phone_number: self.phone_number, state: self.state,  zip_code: self.zip_code)
        debugPrint("______________AddressQuery_______________",createAddressQuery)
        APIClient.createAddress(createAddressQuery: createAddressQuery){result in
            switch result {
                case .success(let emptyWithIdData):
                    debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}

