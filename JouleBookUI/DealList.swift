//
//  DealList.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
import KeychainAccess
import GoogleMaps
struct DealList: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var locationUpdate: LocationUpdate
    @ObservedObject var observed: DealsObserver = DealsObserver()
        //DealsObserver(lat: locationUpdate.location?.latitude , lon: locationUpdate.location?.longitude)
    //var latitude: Double  { return locationUpdate.location?.latitude ?? 0 }
    //var longitude: Double { return locationUpdate.location?.longitude ?? 0 }
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var page: Int = 1
    //var placemark: String { return("\(locationUpdate.placemark?.description ?? "XXX")") }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                TrackableScrollView(.vertical, contentOffset: self.$scrollViewContentOffset, itemHeight:Int.dealItemHeight, itemsLimit:Int.dealItemsLimit,itemPerRow:2, page: self.$observed.page) {
                    VStack{
                        HStack{Spacer()}
                        
                        GridCollection(self.observed.deals, columns: 2, vSpacing: 10, hSpacing: 10, vPadding: 0, hPadding: 10, geometry: geometry) {
                            ItemDealListRow(dealObject: $0).environmentObject(self.viewRouter)
                        }
                        Text("Content page: \(Int(self.observed.page))").font(.title)
                        
                        //Text("Content offset 2: \(Int(self.scrollViewContentOffset))").font(.title)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }.onAppear(perform: {
            debugPrint("Location -  /DealList ", self.locationUpdate.location?.latitude ?? 0)
            //self.observed.latitude = self.locationUpdate.location?.latitude ?? 0
            //self.observed.longitude = self.locationUpdate.location?.longitude ?? 0
            self.observed.page = 0
        })
        //.onAppear(perform: {self.observed.getDeals(latitude: self.latitude, longitude: self.longitude)})
    }
    
}
struct SearchQuery: Encodable {
    let size: Int
    let from: Int
    let cat: Int
    let q: String
    let northeast:Glocation
    let southwest:Glocation
    let latlng:Glocation
}
struct Glocation: Encodable{
    let lat: Double
    let lon: Double
}
class DealsObserver : ObservableObject{
    let objectWillChange = ObservableObjectPublisher()
   // @Published var latitude: Double = 0
    //@Published var longitude: Double = 0
    var oldPage: Int = -1
    @Published var page: Int = -1{
        didSet {
            if self.page > self.oldPage {
                debugPrint("Page thay doi - /DealList : ",self.page)
                self.getDeals()
                objectWillChange.send()
            }
        }
    }
    /*
    private var realPageChangedPublisher: AnyPublisher<Int, Never> {
        $page.debounce(for: 0.2, scheduler: RunLoop.main).removeDuplicates().map { input in
            debugPrint("Page thay doi - /DealList : ",self.page)
            self.getDeals()
            return input
        }
        .eraseToAnyPublisher()
    }*/
    /*private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
        
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return Navajo.strength(ofPassword: input)
        }
        .eraseToAnyPublisher()
    }*/
    /*
    lazy var status: AnyPublisher<String,Never> = {
        self.$latitude.combineLatest(self.$longitude.map({ longitude in
            return "\(self.)"
            //if self.page > self.oldPage {
                //debugPrint("Page thay doi - /DealList : ",self.page)
                
            //}
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher())*/
        /*self.getDeals()
        self.objectWillChange.send()**/
    //}
    @Published var deals = [Deal](){
        didSet {
            debugPrint("deals  thay doi - /DealList : ")
            objectWillChange.send()
        }
    }
    /*lazy var status: AnyPublisher<Void,Never> = {
        $latitude
            .combineLatest($longitude)
            .combineLatest($page)
            .map({ latitude, longitude, page in
                self.getDeals(latitude: latitude, longitude: longitude)
           })
           .receive(on: DispatchQueue.main)
           .eraseToAnyPublisher()
    }()*/
    //lat: Double?,lon: Double?
    init() {
        //self.latitude = lat
        //self.longitude = lon
        //getDeals()
        //(self.page-1)*Int.dealItemsLimit
        


         
    }
    //latitude: Double,longitude: Double
    func getDeals(){
        oldPage = page
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
       
            guard let crrLat = try? keychain.get("current_lat") else {
                return
            }
            guard let crrLon = try? keychain.get("current_lon") else {
                return
            }
            //let crrLat = try? keychain.get("current_lat") ?? ""
            //let crrLon = try? keychain.get("current_lon") ?? ""
            let northeast = AppUtils().locationWithBearing(bearing: 45,distanceMeters: 500000,origin: CLLocationCoordinate2D(latitude: (crrLat as NSString).doubleValue, longitude: (crrLon as NSString).doubleValue))
            let southwest = AppUtils().locationWithBearing(bearing: 225,distanceMeters: 500000,origin: CLLocationCoordinate2D(latitude: (crrLat as NSString).doubleValue, longitude: (crrLon as NSString).doubleValue))
            APIClient.loadDeals(size: Int.dealItemsLimit, from: ((self.page > 0) ? (self.page-1) : 0)*Int.dealItemsLimit, cat: -1, q: "", northeast: String(northeast.latitude)+","+String(northeast.longitude), southwest: String(southwest.latitude)+","+String(southwest.longitude), latlng: crrLat+","+crrLon){ result in
                switch result {
                    case .success(let listDeals):
                        print("______________Deals_______________")
                        print(listDeals.data)
                        self.deals = self.deals.merge(mergeWith: listDeals.data, uniquelyKeyedBy: \.id)
                        //self.deals = listDeals.data
                        //print(listDeals)
                    case .failure(let error):
                        print(error)
                }
                
            }
        
        /*if let listDeals = result {
            do{
                print("______________Deals_______________")
                print(listDeals)
                //let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:AnyObject]]
                //print("JSON IS ",json)
            }catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }*/
    }
}
/*
struct DealList_Previews: PreviewProvider {
    static var previews: some View {
        
        DealList(arrDeal:[Deal(id:1,name:"Test deal 1",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3),Deal(id:2,name:"Test deal 2",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3),Deal(id:3,name:"Test deal 3",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3)])
    }
}*/
