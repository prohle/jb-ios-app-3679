//
//  DealList.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
struct DealList: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var arrDeal: [Deal]?
    var body: some View {
        NavigationView {
            VStack{
                GridCollection(arrDeal!, columns: 2, vSpacing: 10, hSpacing: 10, vPadding: 0, hPadding: 0) {
                    ItemDealListRow(dealObject: $0)
                }
                Spacer()
                Button(
                    action: {
                        self.loadDeals()
                    },
                    label: {
                        Text("Test").font(.footnote).fontWeight(.regular).foregroundColor(Color.subtext)
                    }
                ).frame(height: 50)
            }.padding([.horizontal],CGFloat.stHpadding)
            .padding([.vertical],CGFloat.stVpadding)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
        /*VStack{
            List(dealDatas){dealData in
                NavigationLink(destination: DealDetail(deal: dealData)){
                    ItemDealListRow(dealObject: dealData)
                }
            }
        }*/
        
    }
    func loadDeals(){
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        let interceptor = RequestInterceptor(storage: keychain, viewrouter: viewRouter)
        let glocation: Glocation = Glocation(lat: 20.66, lon: 12.75)
        let geoDistance: GeoDistance = GeoDistance(distance: "12000km", location: glocation)
        let updatedTimeStamp: UpdatedTimeStamp = UpdatedTimeStamp(gt: "20200120T000000.111Z", lt: "20210120T000000.111Z")
        let range: RangeParam = RangeParam(last_updated_timestamp: updatedTimeStamp)
        let filterParam: FilterParam = FilterParam(range: range)
        let boolParam: BoolParam = BoolParam(filter: [filterParam])
        let queryParam: QueryParam = QueryParam(bool: boolParam)
        let parameters: SearchQuery = SearchQuery(size: 10,from: 0,query: queryParam)
        AF.request("https://api-gateway.joulebook.com/api-gateway/deals/_search",
        method: .post,
        parameters: parameters,
        encoder: JSONParameterEncoder.default,
        //headers: heads,
        interceptor: interceptor
        
        ).validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON{response in
            switch response.result{
            case .failure(let f):
               debugPrint(response)
            case .success(let s):
                print(">> SUCCESS: ",s)
            }
            //debugPrint(response)
        }
    }
}
struct SearchQuery: Encodable {
    let size: Int
    let from: Int
    let query: QueryParam
}
struct QueryParam: Encodable{
    let bool: BoolParam
}
struct BoolParam: Encodable{
    let filter : [FilterParam]
}
struct FilterParam: Encodable{
    let range: RangeParam
}
struct RangeParam: Encodable{
    let last_updated_timestamp:UpdatedTimeStamp
}
struct UpdatedTimeStamp: Encodable{
    let gt: String
    let lt: String
}
struct GeoDistance:Encodable{
    let distance: String
    let location: Glocation
}
struct Glocation: Encodable{
    let lat: Double
    let lon: Double
}
/*
struct DealList_Previews: PreviewProvider {
    static var previews: some View {
        
        DealList(arrDeal:[Deal(id:1,name:"Test deal 1",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3),Deal(id:2,name:"Test deal 2",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3),Deal(id:3,name:"Test deal 3",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3)])
    }
}*/
