//
//  DealObservable.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import Foundation
import Combine
import KeychainAccess
struct DayOfWeekTimeOption{
    var id: Int = 0
    var fromDate: Date
    var toDate: Date
    var startTimes: [Date]
    var dayOfWeeks: [String]
    func convertToDealTimes() -> [DealTime]{
        var dealTimes = [DealTime]()
        if startTimes.count > 0 && dayOfWeeks.count > 0 {
            let dayOfWeekStr = dayOfWeeks.joined(separator: ",")
            var index: Int = 0
            for startTime in startTimes {
                debugPrint("--STARTTIME--/Models/DealObservable",index," -> ", startTime.toUtcTimeStr())
                dealTimes.append(DealTime(day_of_week: dayOfWeekStr, deal_date: "", from_date: fromDate.toUTCDateStr(), index: index, is_repetitive: true, start_time: startTime.toUtcTimeStr(), to_date: toDate.toUTCDateStr()))
                index+=1
            }
        }
        return dealTimes
    }
}
struct SpecificTimeOption{
    var id: Int = 0
    var dealDate: RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*100),  mode: 0)
    var startTimes: [Date]
    func convertToDealTimes() -> [DealTime]{
        var dealTimes = [DealTime]()
        if startTimes.count > 0 {
            var index: Int = 0
            for startTime in startTimes {
                dealTimes.append(DealTime(day_of_week: "", deal_date: self.dealDate.selectedDate.toUTCDateStr(), from_date: "", index: index, is_repetitive: false, start_time: startTime.toUtcTimeStr(), to_date: ""))
                index+=1
            }
        }
        return dealTimes
    }
}
struct DealTime: Encodable {
    let day_of_week: String
    let deal_date: String
    var from_date: String
    let index: Int
    let is_repetitive: Bool
    let start_time: String
    var to_date: String
}
struct EmptyObjectWithId: Decodable{
    var id: Int
}
struct EmptyDataWithId: Decodable{
    var data: EmptyObjectWithId
}
struct EmptyDataNoId: Decodable{
    var data: EmptyObjectWithId?
}
struct StatusRespone: Decodable{
    var code: String
    var message: String
}
struct ErrorRespone: Decodable{
    var status: StatusRespone
    func generalResponseError()->StatusRespone {
        return self.status
    }
}
struct CreateDealQuery: Encodable {
    let name: String
    let description: String
    let sold_until: String
    let expire_time: String
    let non_refundable_deposit: Int
    let normal_price: Double
    let rate_basis: Int
    let seats_number: Int
    let tax_rate: Double
    let service_type: Int
    let start_time: String
    let category_id: Int
    let deal_price: Double
    let approx_duration: Double
    let execution_type: Int
    let zip_code: String
    let floor: String
    let is_address_customer_choice: Bool
    let is_address_provider_choice: Bool
    let is_address_remote: Bool
    let latitude: String
    let location_type: Int
    let longitude: String
    let building: String
    let state: String
    let unit: String
    let city: String
    let address: String
    let deal_times: [DealTime]
}
class DealObservable: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
        //PassthroughSubject<Void,Never>()
    
    @Published var address: String = ""
    @Published var address_type: Int = 0
    @Published var tax_rate: Double = 6.25 {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var selectedAddress: AddressObj = AddressObj(){
        willSet {
            objectWillChange.send()
        }
    }
    @Published var approx_duration: Double = 0.25{
        willSet {
            objectWillChange.send()
        }
    }
    @Published var building: String = ""
    @Published var category_id: Int = 0
    @Published var city: String = ""
    @Published var deal_price: Double = 433 {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var specificTimeOptions: [SpecificTimeOption] = [SpecificTimeOption](){
        willSet {
            objectWillChange.send()
        }
    }
    @Published var dayOfWeekTimeOptions: [DayOfWeekTimeOption] = [DayOfWeekTimeOption](){
        willSet {
            objectWillChange.send()
        }
    }
    @Published var location_type: Int = 0
    @Published var deal_times: [DealTime] = [DealTime]()
    @Published var description: String = "sd asd asdasdasd asd asd asd asd "{
        willSet {
            objectWillChange.send()
        }
    }
    @Published var date_type: Bool = true{
        willSet {
            objectWillChange.send()
        }
    }
    @Published var execution_type: Int = -1 /*1: repeative date, 0: specific date**/
    @Published var expire_time: String = ""
    @Published var floor: String = ""
    @Published var is_address_customer_choice: Bool = false{
        didSet {
            objectWillChange.send()
        }
    }
    @Published var is_address_provider_choice: Bool = false{
        didSet {
            objectWillChange.send()
        }
    }
    @Published var is_address_remote: Bool = false{
        didSet {
            objectWillChange.send()
        }
    }
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published var name: String = "Group deal repeative date per option from iphone"{
        didSet {
            objectWillChange.send()
        }
    }
    @Published var non_refundable_deposit: Int = 0
    @Published var normal_price: Double = 500 {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var rate_basis: Int = 0 /*1,name: "Flat rate per time option"),RateBasic(id: 2,name: "Flat rate per time slot"**/
    @Published var seats_number: Int = 1 {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var service_type: Int = 1{/*Mac dinh la 1 : group**/
        didSet {
            objectWillChange.send()
        }
    }
    @Published var sold_until: String = ""
    @Published var start_time: String = ""
    @Published var state: String = ""
    @Published var unit: String = ""
    @Published var zip_code: String = ""
    init() {}
    
    func getMaxIncome() -> String{
        var maxIncome: Double = 0
        self.timeOptionToDealTimes()
        let countSeat: Int = (self.service_type == 1) ? self.seats_number : 1
        let countTime: Int = (self.deal_times.count > 0) ? self.deal_times.count : 1
        maxIncome = (self.deal_price > 0) ? self.deal_price * Double(countSeat) * Double(countTime) : 0
        if(maxIncome > 0) {
            let incomeStr = (self.rate_basis == 1) ? "time option(s)" : "time slot(s)"
            let incomeStr2 = (self.rate_basis == 1) ? "option" : "slot"
            return ((countSeat > 1) ? "\(countTime) \(incomeStr) x \(countSeat) seat(s) x \(NumberFormatter.currency.string(for: self.deal_price) ?? "")/seat = \(maxIncome)" : "\(countTime) \(incomeStr) x \(self.deal_price)/\(incomeStr2) = \(NumberFormatter.currency.string(for: maxIncome) ?? "")")
        }
        return ""
    }
    func timeOptionToDealTimes(){
        if(self.date_type == true){
            self.execution_type = 1
            self.deal_times = [DealTime]()
            if(self.dayOfWeekTimeOptions.count > 0){
                for dayOfWeekTimeOption in self.dayOfWeekTimeOptions {
                    let dealTimeArr: [DealTime] = dayOfWeekTimeOption.convertToDealTimes()
                    self.deal_times.append(contentsOf: dealTimeArr)
                }
            }
        }else{
            self.execution_type = 0
            self.deal_times = [DealTime]()
            if(self.specificTimeOptions.count > 0){
                for specificTimeOption in self.specificTimeOptions {
                    let dealTimeArr: [DealTime] = specificTimeOption.convertToDealTimes()
                    self.deal_times.append(contentsOf: dealTimeArr)
                }
            }
        }
    }
    func submitDeal() {
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        self.timeOptionToDealTimes()
        if(self.selectedAddress.id == -1){
            let defaultDddress = try! keychain.getString("default_address") ?? ""
            if(defaultDddress != ""){
                if let jsonData = defaultDddress.data(using: .utf8){
                    let decoder = JSONDecoder()
                    do {
                        let addressObj = try decoder.decode(AddressObj.self, from: jsonData)
                        self.city = addressObj.city ?? ""
                        self.state = addressObj.state ?? ""
                        self.latitude = addressObj.latitude
                        self.longitude = addressObj.longitude
                        self.address = addressObj.address
                        self.zip_code = addressObj.zip_code ?? ""
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }else{
            self.city = self.selectedAddress.city ?? ""
            self.state = self.selectedAddress.state ?? ""
            self.latitude = self.selectedAddress.latitude
            self.longitude = self.selectedAddress.longitude
            self.address = self.selectedAddress.address
            self.zip_code = self.selectedAddress.zip_code ?? ""
        }
        
        let createDealQuery = CreateDealQuery(name: self.name, description: self.description, sold_until: self.expire_time, expire_time: self.expire_time, non_refundable_deposit: self.non_refundable_deposit, normal_price: self.normal_price, rate_basis: self.rate_basis, seats_number: self.seats_number, tax_rate: self.tax_rate , service_type: self.service_type, start_time: self.start_time, category_id: self.category_id, deal_price: self.deal_price, approx_duration: self.approx_duration, execution_type: self.execution_type, zip_code: self.zip_code, floor: self.floor,is_address_customer_choice: self.is_address_customer_choice,is_address_provider_choice: self.is_address_provider_choice,is_address_remote: self.is_address_remote, latitude: String(self.latitude), location_type: self.location_type, longitude: String(self.longitude), building: self.building, state: self.state, unit: self.unit, city: self.city, address: self.address, deal_times: self.deal_times)
        
        debugPrint("______________DealQuery_______________",createDealQuery)
        APIClient.createDeal(createDealQuery: createDealQuery){result in
            switch result {
                case .success(let emptyWithIdData):
                    debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
/*curl -XPUT 'localhost:9200/deals?pretty' -H 'Content-Type: application/json' -d'{
  "settings": {
    "index": {
      "number_of_shards": 3,
      "number_of_replicas": 2
    }
  },
  "mappings": {
    "_doc": {
          "properties": {
            "pin": {
              "properties": {
                "location": {
                  "type": "geo_point"
                }
              }
            }
          }
    }
  }
}'**/
