//
//  BookDeal.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/29/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine

struct BookDeal: Identifiable,Hashable, Codable {
    var id: Int =  -1
    var address: String
    var address_type: Int =  0
    var billing_id: Int =  0
    var building: String
    var buyer_id: Int =  0
    var buyer_schedule_id: Int =  0
    var city: String
    var created_timestamp: String
    var day_of_week: String
    var deal_date: String
    var deal_id: String
    var deal_location_type: String
    var deal_slot_id: String
    var execution_type: String
    var floor: String
    var from_date: String
    var is_deleted: String
    var last_updated_timestamp: String
    var latitude: String
    var longitude: String
    var provider_id: Int =  0
    var provider_scheduler_id: Int =  0
    var quantity: Int =  0
    var service_type: Int =  0
    var start_time: String
    var state: String
    var status: Int =  0
    var to_date: String
    var unit: String
    var zip_code: String
}
struct BookDealData: Decodable {
    let data: BookDeal
}

struct BookDealQuery: Encodable {
    let address: String
    let address_type: Int
   // let building: String
    let buyer_id: Int
    let city: String
    let deal_location_type: Int
    let deal_slot_id: Int
    //let floor: String
    let latitude: String
    let longitude: String
    let quantity: Int
    let state: String
    //let unit: String
    let zip_code: String
}
class BookDealObservable: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    @Published var  rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*30), mode: 0){
        didSet {
            objectWillChange.send()
        }
    }
    @Published var selectedCard: CardObj = CardObj()
    @Published var selectedTimeSlots: [DealDetailTimeOption] = [DealDetailTimeOption](){
        didSet {
            objectWillChange.send()
        }
    }
    @Published var selectedAddress: AddressObj = AddressObj(){
        willSet {
            objectWillChange.send()
        }
    }
    //@Published var selectedDateTimes: [Date] = [Date]()
    //@Published var selectedTimeOptionIndex = -1
    @Published var repeativeQuanty = 0
    @Published var dealObj: DealDetailObj = DealDetailObj()
    func getAmount() -> Double{
        return Double(dealObj.deal_price ?? 0) * Double(selectedTimeSlots.count)
    }
    func getTotal() -> Double{
        return self.getAmount() + self.getAmount() * Double(dealObj.tax_rate ?? 0)
    }
    
    func bookDeal(){
        /*var qty: Int = 1
        if dealObj.execution_type == 1 {
            qty = self.repeativeQuanty
        }else {
            qty =
        }*/
        let bookDealQuery = BookDealQuery(address: self.selectedAddress.address,address_type: self.selectedAddress.address_type, buyer_id: dealObj.user_id, city: self.selectedAddress.city ?? "", deal_location_type: self.selectedAddress.address_type,deal_slot_id: self.selectedTimeSlots[0].id ?? 0, latitude: self.selectedAddress.latitude, longitude: self.selectedAddress.longitude,quantity: 1,state: self.selectedAddress.state ?? "" ,zip_code: self.selectedAddress.zip_code ?? "")
        
        debugPrint("______________BookDealQuery_______________",bookDealQuery)
        
        APIClient.bookDeal(id: self.dealObj.id, bookDealQuery: bookDealQuery){result in
            switch result {
                case .success(let emptyWithIdData):
                    debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    func mulBookDeal(){
        var mulBookDealQuery = [BookDealQuery]()
        if self.selectedTimeSlots.count > 0 {
            for slot in self.selectedTimeSlots {
                let bookDealQuery = BookDealQuery(address: self.selectedAddress.address,address_type: self.selectedAddress.address_type, buyer_id: dealObj.user_id, city: self.selectedAddress.city ?? "", deal_location_type: self.selectedAddress.address_type,deal_slot_id: slot.id ?? 0, latitude: self.selectedAddress.latitude, longitude: self.selectedAddress.longitude,quantity: 1,state: self.selectedAddress.state ?? "" ,zip_code: self.selectedAddress.zip_code ?? "")
                mulBookDealQuery.append(bookDealQuery)
            }
        }
        debugPrint("______________BookDealQuery_______________",mulBookDealQuery)
        if mulBookDealQuery.count > 0 {
            APIClient.multiBookDeal(id: self.dealObj.id, multiBookDealQuery: mulBookDealQuery){result in
                switch result {
                    case .success(let emptyWithIdData):
                        debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                    case .failure(let error):
                        print(error)
                }
                
            }
        }
        
    }
}
