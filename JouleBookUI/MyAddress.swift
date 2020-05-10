//
//  MyAddress.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
import Combine
struct AddressItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var addressObj: AddressObj
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack(spacing: 5){
                TextBold(text: addressObj.address_name)
                TextBody(text: (addressObj.is_default == true) ? "Default" : "",color: Color.main)
                Spacer()
                TextBody(text:"Edit",color: .textlink)
            }
            TextBody(text: addressObj.phone_number)
            TextBody(text: addressObj.address)
            TextBody(text: addressObj.address_line_2 ?? "")
        }
    }
}
struct SelectableAddressItemRow: View {
    var addressObj: AddressObj
    @Binding var selectedAddress: AddressObj
    @Binding var showSheet: Bool
    var body: some View {
        Button(action: {
            self.selectedAddress = self.addressObj
            //debugPrint("------Selected Address------",self.selectedAddress)
            self.showSheet = false
        }){
            VStack(alignment: .leading, spacing: 5){
                HStack(spacing: 5){
                    TextBold(text: addressObj.address_name)
                    TextBody(text: (addressObj.is_default == true) ? "Default" : "",color: Color.main)
                }
                TextBody(text: addressObj.phone_number)
                TextBody(text: addressObj.address)
                TextBody(text: addressObj.address_line_2 ?? "")
            }
        }
        
    }
}
struct MySelectableAddress: View {
    @ObservedObject var myAddressObserver = MyAddressObserver()
    @Binding var selectedAddress: AddressObj
    @State private var scrollViewContentOffset = CGFloat(0)
       @State private var page: Int = 1
    @Binding var showSheet: Bool
    var body: some View {
                GeometryReader { geometry in
                    TrackableScrollView(.vertical, contentOffset: self.$scrollViewContentOffset, itemHeight:Int.cardItemHeight, itemsLimit:Int.cardItemsLimit,itemPerRow:1, page: self.$myAddressObserver.page) {
                        VStack(alignment: .leading, spacing:5){
                            if(self.myAddressObserver.addressObjs.count > 0){
                                ForEach(self.myAddressObserver.addressObjs){addressObj in
                                    SelectableAddressItemRow(addressObj: addressObj, selectedAddress: self.$selectedAddress, showSheet: self.$showSheet)
                                    //.border((self.selectedAddress.id == self.addressObj.id) ?  Color.main : Color.border)
                                    HorizontalLine(color: (self.selectedAddress.id == addressObj.id) ?  Color.main : Color.border)
                                }
                            }
                        }.padding([.horizontal],CGFloat.stHpadding)
                        .padding(CGFloat.stVpadding)
                        .frame(width: geometry.size.width)
                    }
                }
    }
}
struct MyAddress: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var myAddressObserver = MyAddressObserver()
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var page: Int = 1
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                TrackableScrollView(.vertical, contentOffset: self.$scrollViewContentOffset, itemHeight:Int.cardItemHeight, itemsLimit:Int.cardItemsLimit,itemPerRow:1, page: self.$myAddressObserver.page) {
                    VStack{
                        HStack{Spacer()}
                        if(self.myAddressObserver.addressObjs.count > 0){
                            ForEach(self.myAddressObserver.addressObjs){addressObj in
                                AddressItemRow(addressObj: addressObj).environmentObject(self.viewRouter)
                                HorizontalLine(color: .border)
                            }
                        }
                        Spacer()
                        Button(action:{
                            self.viewRouter.currentPage = "createaddress"
                        }){
                            NormalButton(btnText: "Add new address",fontSize: .body, textColor: Color.maintext, borderColor: Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(0.00)).frame(width: geometry.size.width)
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
        /*NavigationView {
            //HStack(spacing: 1) {
                GeometryReader { geometry in
                    ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment: .leading, spacing:5){
                            if(self.myAddressObserver.addressObjs.count > 0){
                                ForEach(self.myAddressObserver.addressObjs){addressObj in
                                    AddressItemRow(addressObj: addressObj).environmentObject(self.viewRouter)
                                    HorizontalLine(color: .border)
                                }
                            }
                            Spacer()
                            Button(action:{
                                self.viewRouter.currentPage = "createaddress"
                            }){
                                NormalButton(btnText: "Add new address",fontSize: .body, textColor: Color.maintext, borderColor: Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(0.00)).frame(width: geometry.size.width)
                            }
                            
                        }.onAppear(perform: {self.myAddressObserver.getAddresss()}).padding([.horizontal],CGFloat.stHpadding)
                        .padding(CGFloat.stVpadding)
                        .frame(width: geometry.size.width)
                    }
                }
                //Spacer()
            //}
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
                
            
        }*/
    }
}
class MyAddressObserver : ObservableObject{
    let objectWillChange = PassthroughSubject<MyAddressObserver,Never>()
    var oldPage: Int = -1
    @Published var page: Int = -1{
        didSet {
            if self.page > self.oldPage {
                debugPrint("Page thay doi - /MyAddresss : ",self.page)
                self.getAddresss()
                objectWillChange.send(self)
            }
        }
    }
    @Published var addressObjs = [AddressObj](){
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    init() {
        //getAddresss()
    }
    func getAddresss(){
        APIClient.loadAddresss(size: 15, from: 0){result in
            switch result {
                case .success(let listAddress):
                    self.addressObjs = listAddress.data
                    debugPrint(self.addressObjs[0])
                case .failure(let error):
                    print(error)
            }
        }
        /*let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        let interceptor = RequestInterceptor(storage: keychain)
        let parameters:[String: String] = ["size": "15","from":"0"]
        let jsonDecoder = JSONDecoder()
        AF.request("https://api-gateway.joulebook.com/api-gateway/user/v1.0/users/address",
            method: .get,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            interceptor: interceptor
        )
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseDecodable (decoder: jsonDecoder){ (response: DataResponse<[AddressObj], AFError>) in
            //completion(response.result)
        }*/
        /*.responseDecodable(of: ArrayAddressObj.self){ response in
            debugPrint("Response: \(response)")
        }*/
        //.responseDecodable(completionHandler: <#T##(DataResponse<Decodable, AFError>) -> Void#>)
        /*.responseJSON{response in
            switch response.result{
            case .failure(let f):
                print(">> AAAERR: ",f)
               debugPrint(response)
            case .success(let s):
                let resObj = s as! NSDictionary
                let addressName = resObj.object(forKey: "address_name")!
                print(">> SUCCESSAAN: ",addressName)
            }
            //debugPrint(response)
        }*/
    }
}
struct MyAddress_Previews: PreviewProvider {
    static var previews: some View {
        MyAddress()
    }
}
