//
//  Deal.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

//
//  Deal.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import UIKit
import SwiftUI
import CoreLocation
import Combine
import URLImage
//import ImageStore Hashable, Identifiable
let instantCats = [Category(id: 1,name: "Babysit",icon: "Artboard 48"),Category(id: 2,name: "Companionship",icon: "Artboard 49"),Category(id: 3,name: "Tutor",icon: "Artboard 41"),Category(id: 4,name: "General office work",icon: "Artboard 51"),Category(id: 5,name: "House cleaning",icon: "Artboard 43"),Category(id: 6,name: "Delivery driver",icon: "Artboard 44"),Category(id: 7,name: "General labor",icon: "Artboard 45"),Category(id: 8,name: "Massage",icon: "Artboard 55"),Category(id: 9,name: "Handyman",icon: "Artboard 56")]
struct Category: Identifiable,Hashable, Codable{
    var id: Int = -1
    var name: String = ""
    var icon: String = ""
}
/*
 
 */
struct ListDeal: Decodable {
    let data: [Deal]
}
struct DealDetailTimeOption: Identifiable,Hashable,Codable{
    var created_timestamp: String? =  ""
    var day_of_week: String? =  ""
    var deal_date: String? =  ""
    var deal_id: Int? = -1
    var execution_type: Int? = 0
    var from_date: String? =  ""
    var id: Int? = -1
    var index: Int? = -1
    var is_deleted: Bool = false
    var is_repetitive: Bool? = false
    var last_updated_timestamp: String? =  ""
    var quantity: Int? = 0
    var schedule_id: Int? = 0
    var service_type: Int? = 0
    var start_time: String? =  ""
    var to_date: String? =  ""
    var use_count: Int? = -1
    func getSelectedDate() -> Date?{
        var result: Date?
        if self.execution_type == 0 && !(self.deal_date?.isEmpty ?? false){
            result = self.deal_date?.utcDateStrToDate()
        }
        return result
    }
}
struct DealDetailObj: Identifiable,Hashable, Codable {
    var id: Int =  -1
    var category_id: Int? =  -1
    var service_type: Int = -1
    var user_id: Int =  -1
    var company_id: Int? = -1
    var name: String =  ""
    var description: String =  ""
    var start_time: String? =  ""
    var expire_time: String? =  ""
    var normal_price: Double? =  0
    var deal_price: Double? =  0
    var deal_times: [DealDetailTimeOption] = [DealDetailTimeOption]()
    var rate_basis: Int? =  0
    var approx_duration: Double? = 0.25
    var seats_number: Int? =  0
    var address_type: Int? =  0
    var address: String? =  ""
    var city: String? =  ""
    var state: String? =  ""
    var zip_code: String? =  ""
    var building: String? =  ""
    var floor: String? =  ""
    var unit: String? =  ""
    var longitude: String? =  ""
    var latitude: String? =  ""
    var location: String? =  ""
    var non_refundable_deposit: Int =  0
    var attach_1_id: Int? =  -1
    var attach_1_url: String? =  ""
    var attach_1_status: Int? =  -1
    var attach_2_id: Int? =  -1
    var attach_2_url: String? =  ""
    var attach_2_status: Int? =  -1
    var attach_3_id: Int? =  -1
    var attach_3_url: String? =  ""
    var attach_3_status: Int? =  -1
    var attach_4_id: Int? =  -1
    var attach_4_url: String? =  ""
    var attach_4_status: Int? =  -1
    var attach_5_id: Int? =  -1
    var attach_5_url: String? =  ""
    var attach_5_status: Int? =  -1
    var view_count: Int? =  0
    var use_count_limit: Int? =  0
    var use_count: Int? =  0
    var status: Int? =  0
    var tax_rate: Double? = 0
    var is_deleted: Bool? =  false
    var created_timestamp: String? =  ""
    var last_updated_timestamp: String? =  ""
    var sold_until: String? =  ""
    var is_address_customer_choice: Bool? =  false
    var is_address_provider_choice: Bool? =  false
    var is_address_remote: Bool? =  false
    var execution_type: Int? =  0
    var active_cancel_reason: String? =  ""
}
struct DealDetailData: Decodable {
    let data: DealDetailObj
}
struct Deal: Identifiable,Hashable, Codable {
    var id: Int =  -1
    var category_id: Int =  -1
    var service_type: Int = -1
    var user_id: Int =  -1
    var company_id: Int? = -1
    var name: String =  ""
    var description: String =  ""
    var start_time: Int =  -1
    var expire_time: Int =  -1
    var normal_price: Double =  0
    var deal_price: Double =  0
    var rate_basis: Int? =  0
    var approx_duration: Double? = 0.25
    var seats_number: Int? =  0
    var address_type: Int? =  0
    var address: String? =  ""
    var city: String? =  ""
    var state: String? =  ""
    var zip_code: String? =  ""
    var building: String? =  ""
    var floor: String? =  ""
    var unit: String? =  ""
    var longitude: String =  ""
    var latitude: String =  ""
    var location: String =  ""
    var non_refundable_deposit: Int =  0
    var attach_1_id: Int? =  -1
    var attach_1_url: String? =  ""
    var attach_1_status: Int? =  -1
    var attach_2_id: Int? =  -1
    var attach_2_url: String? =  ""
    var attach_2_status: Int? =  -1
    var attach_3_id: Int? =  -1
    var attach_3_url: String? =  ""
    var attach_3_status: Int? =  -1
    var attach_4_id: Int? =  -1
    var attach_4_url: String? =  ""
    var attach_4_status: Int? =  -1
    var attach_5_id: Int? =  -1
    var attach_5_url: String? =  ""
    var attach_5_status: Int? =  -1
    var view_count: Int? =  0
    var use_count_limit: Int? =  0
    var use_count: Int? =  0
    var status: Int? =  0
    var is_deleted: Bool =  false
    var created_timestamp: Int =  0
    var last_updated_timestamp: Int =  0
    var sold_until: Int? =  0
    var is_address_customer_choice: Bool? =  false
    var is_address_provider_choice: Bool? =  false
    var is_address_remote: Bool? =  false
    var execution_type: Int =  0
    var active_cancel_reason: String? =  ""
    var _new_score: Double =  0
    var distance: Double =  0
}
class DealDetailObservable: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    @Published var  rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*30), mode: 0){
        didSet {
            objectWillChange.send()
        }
    }
    @Published var dealObj: DealDetailObj = DealDetailObj(){
        didSet {
            objectWillChange.send()
        }
    }
     @Published var selectedDateTimes: [Date] = [Date](){
         didSet {
             objectWillChange.send()
         }
     }
    @Published var repeativeSelectedIndex: Int = -1{
        didSet {
            objectWillChange.send()
        }
    }
    @Published var selectedTimeSlots: [DealDetailTimeOption] = [DealDetailTimeOption]()
    init() {}
    func getAssetsSlider() -> [UIViewController]{
        var subViews = [UIViewController]()
        if !(dealObj.attach_1_url ?? "").isEmpty {
            let subview1 = UIHostingController(rootView: ImageUrl(imageUrl: "\(String.s3asseturl)\(dealObj.attach_1_url ?? "")",width: 1000, height: 1000))
            subViews.append(subview1)
        }
        if !(dealObj.attach_2_url ?? "").isEmpty {
            let subview2 = UIHostingController(rootView: ImageUrl(imageUrl: "\(String.s3asseturl)\(dealObj.attach_2_url ?? "")",width: 1000, height: 1000))
            subViews.append(subview2)
        }
        if !(dealObj.attach_3_url ?? "").isEmpty {
            let subview3 = UIHostingController(rootView: ImageUrl(imageUrl: "\(String.s3asseturl)\(dealObj.attach_3_url ?? "")",width: 1000, height: 1000))
            subViews.append(subview3)
        }
        if !(dealObj.attach_4_url ?? "").isEmpty {
            let subview4 = UIHostingController(rootView: ImageUrl(imageUrl: "\(String.s3asseturl)\(dealObj.attach_4_url ?? "")",width: 1000, height: 1000))
            subViews.append(subview4)
        }
        if !(dealObj.attach_5_url ?? "").isEmpty {
            let subview5 = UIHostingController(rootView: ImageUrl(imageUrl: "\(String.s3asseturl)\(dealObj.attach_5_url ?? "")",width: 1000, height: 1000))
            subViews.append(subview5)
        }
        let subview6 = UIHostingController(rootView: ImageUrl(imageUrl: "https://i1-thethao.vnecdn.net/2020/04/27/top-1587942450-7572-1587942576.jpg?w=300&h=180&q=100&dpr=1&fit=crop&s=NDsswPSp3O5rr5indiU0Hw",width: 1000, height: 1000))
        subViews.append(subview6)
        let subview7 = UIHostingController(rootView: ImageUrl(imageUrl: "https://i1-vnexpress.vnecdn.net/2020/04/26/nhagangammetro-9-1587904378.jpg?w=680&h=408&q=100&dpr=1&fit=crop&s=6W58Dzc_Bcnj6VsTR4-qsw",width: 1000, height: 1000))
        subViews.append(subview7)
        return subViews
    }
    func loadDealDetail(dealId: Int){
        APIClient.getDealDetail(id: dealId){ result in
            switch result {
                case .success(let dealObj):
                    print("______________DealDetail______________")
                    print(dealObj.data)
                    self.dealObj = dealObj.data
                    if self.dealObj.execution_type == 2 {
                        self.updateStates()
                    }
                    //print(listDeals)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    func updateStates(){
        if self.getSelectedDates().count > 0 {
            self.rkManager = RKManager(calendar: Calendar.current, minimumDate: (self.getSelectedDates().count > 0) ? self.getSelectedDates()[0] : Date(), maximumDate: Date().addingTimeInterval(60*60*24*30),  selectedDates: self.getSelectedDates(),mode: 0)
            //self.rkManager.minimumDate = self.getSelectedDates()[0]
            //self.rkManager.selectedDates = self.getSelectedDates()
        }
    }
    func getSelectedDates() -> [Date]{
        var results = [Date]()
        if(self.dealObj.deal_times.count > 0){
            for timeoption in self.dealObj.deal_times {
                results.append(timeoption.getSelectedDate() ?? Date())
            }
            results.sort()
            //self.selectedDate = results[0]
            //self.monthIndex = self.selectedDate.getMonth()
        }
        return results
    }
}
/*
struct Deal: Identifiable,Hashable, Codable{
    
    var id:Int = -1
    var address: String = ""
    var addressType: Int = 0
    var approxDuration: Int = 0
    var attachUrl1: String = ""
    var attachUrl2: String = ""
    var attachUrl3: String = ""
    var attachUrl4: String = ""
    var attachUrl5: String = ""
    var building: String = ""
    var categoryId: Int = -1
    var createdTimestamp:String=""
    var dealPrice: Double = 0
    var txtDescription: String = ""
    var expireTime: String = ""
    var floor: String = ""
    var isDeleted: Bool = false
    var lastUpdatedTimestamp: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var name: String=""
    var nonRefundableDeposit: Int = 0
    var normalPrice: Double = 0
    var rateBasis: Int = 0
    var seatsNumber: Int = 0
    var serviceType: Int = 0
    var startTime: String = ""
    var state: String = ""
    var status: Int = 0
    var unit: String = ""
    var useCount: Int = 0
    var useCountLimit: Int = 0
    var userId: Int = -1
    var viewCount: Int = 0
    var zipCode: String = ""
}*/


/*
extension Deal {
    var image: Image {
        ImageStore.shared.image(name:imageName)
    }
}*/

