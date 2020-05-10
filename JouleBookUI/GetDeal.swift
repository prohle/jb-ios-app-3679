//
//  GetDeal.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/29/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import KeychainAccess
struct GetDealAddress: View {
    var isCustomerChoice : Bool
    var isProviderChoice : Bool
    var isRemote : Bool
    @State var showSheet = false
    @Binding var selectedAddress: AddressObj
    var body: some View {
        VStack{
            HStack{
                IconText(imageIconLeft:"app_icon",imageIconRight:nil,text:"Service Address",iconLeftSize:20,iconRightSize:0)
                Spacer()
                if isCustomerChoice {
                    Button(action:{
                        self.showSheet.toggle()
                    }){
                        HStack{
                            TextBody(text:(self.selectedAddress.id > 0 ) ? self.selectedAddress.getFullAddress() : "Change", color: Color.textlink)
                            Image(systemName: "chevron.right").frame(width:20,height: 20)
                        }
                    }
                }else if isProviderChoice {
                    TextBody(text:(self.selectedAddress.id > 0 ) ? self.selectedAddress.getFullAddress() : "", color: Color.maintext)
                }
                if isRemote {
                    TextBody(text:"Remotely", color: Color.maintext)
                }
            }
            HorizontalLine(color: .border)
        }.sheet(isPresented: $showSheet) {
            MySelectableAddress(selectedAddress: self.$selectedAddress,showSheet: self.$showSheet)
        }
    }
}
struct ShotDealDetail: View {
    @Binding var dealObj: DealDetailObj
    @Binding var repeativeQuanty: Int
    var geometry: GeometryProxy
    var body: some View {
        
        HStack{
            ImageUrl(imageUrl:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",width: geometry.size.width/4,height:CGFloat(60))
            VStack(alignment: .leading){
                TextBold(text: self.dealObj.name,font: .texttitle)
                TextBody(text: "Posted By Peter B", color: .subtext)
            }.frame(width: geometry.size.width/2)
            Spacer()
            VStack(alignment: .trailing){
                Text(NumberFormatter.currency.string(for: dealObj.deal_price) ?? "" ).bold().font(.textsmall).foregroundColor(Color.main)
                Text(NumberFormatter.currency.string(for: dealObj.normal_price) ?? "" ).font(Font.textsmall).foregroundColor(Color.subtext)
                .strikethrough()
                Spacer()
                if dealObj.deal_times.count > 0 && dealObj.deal_times[0].is_repetitive == true && dealObj.seats_number ?? 0 > 1 {
                    QuantityBox(value: self.$repeativeQuanty)
                }
            }.frame(width: geometry.size.width/4)
        }
        
    }
    
}
struct TimeOptionGetDeal: View{
    @EnvironmentObject var rkManager: RKManager
    @Binding var selectedTimeSlots: [DealDetailTimeOption]
    @Binding var dealObj: DealDetailObj
    var body: some View {
        VStack(alignment:.leading){
            TextBody(text: "Time option")
            if self.dealObj.deal_times.count > 0 {
                if self.dealObj.execution_type == 1   {
                    RepeativeTimeOptionDetail(timeOptions: self.$dealObj.deal_times, selectedTimeSlots: self.$selectedTimeSlots)
                }else{
                    SpecificDateTimeOptionDetail( timeOptions: self.$dealObj.deal_times, selectedTimeSlots: self.$selectedTimeSlots).environmentObject(self.rkManager)
                }
            }
        }
    }
}
struct CardTotals: View{
    @EnvironmentObject var bookDealObservable: BookDealObservable
    @State var showSheet:Bool = false
    var body: some View {
        VStack(spacing: 15){
            HStack{
                IconText(imageIconLeft:"app_icon",imageIconRight:nil,text:"Select Card",iconLeftSize:20,iconRightSize:0)
                Spacer()
                Button(action:{
                    self.showSheet.toggle()
                }){
                    HStack{
                        TextBody(text: "\(self.bookDealObservable.selectedCard.brand)....\(self.bookDealObservable.selectedCard.last4)" )
                        Image(systemName: "chevron.right").frame(width:20,height: 20)
                    }
                }
            }
            HorizontalLine(color: .border)
            HStack{
                TextBody(text: "Amount")
                Spacer()
                TextBody(text: "\(NumberFormatter.currency.string(for: self.bookDealObservable.getAmount()) ?? "$0.00")")
            }
            HStack{
                TextBody(text: "Tax")
                Spacer()
                TextBody(text: "\(self.bookDealObservable.dealObj.tax_rate ?? 0)%")
            }
            HStack{
                TextBody(text: "Total")
                Spacer()
                TextBody(text: "\(NumberFormatter.currency.string(for: self.bookDealObservable.getTotal()) ?? "$0.00")")
            }
        }.sheet(isPresented: $showSheet) {
            CardsSelectAble(selectedCard: self.$bookDealObservable.selectedCard,showSheet: self.$showSheet)
        }
    }
}
struct SelectedTimeSlotsWithQut: Decodable{
    var timeoption: DealDetailTimeOption
    var qty: Int = 0
}
struct SpecificDateQuantity: View{
    @Binding var selectedTimeSlots: [SelectedTimeSlotsWithQut]
    var body: some View {
        ForEach(self.selectedTimeSlots, id: \.self.timeoption.id) { slot in
            QuantityBox(value: self.$selectedTimeSlots[0].qty)
            
        }
    }
}
struct GetDeal: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var bookDealObservable = BookDealObservable()
    
    //@EnvironmentObject var dealDetailObservable: DealDetailObservable
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack{
                    ScrollView([.vertical],showsIndicators: false) {
                        VStack{
                            HStack{Spacer()}
                            GetDealAddress(isCustomerChoice: self.bookDealObservable.dealObj.is_address_customer_choice ?? false, isProviderChoice: self.bookDealObservable.dealObj.is_address_provider_choice ?? false, isRemote: self.bookDealObservable.dealObj.is_address_remote ?? false, selectedAddress: self.$bookDealObservable.selectedAddress).frame(width: geometry.size.width - 2*CGFloat.stHpadding)
                            ShotDealDetail(dealObj: self.$viewRouter.dealObj, repeativeQuanty: self.$bookDealObservable.repeativeQuanty, geometry: geometry).frame(width: geometry.size.width - 2*CGFloat.stHpadding)
                            TimeOptionGetDeal(selectedTimeSlots: self.$bookDealObservable.selectedTimeSlots,dealObj: self.$viewRouter.dealObj).environmentObject(self.bookDealObservable.rkManager).frame(width: geometry.size.width - 2*CGFloat.stHpadding)
                            CardTotals().environmentObject(self.bookDealObservable)
                            
                        }.frame(width: geometry.size.width - 2*CGFloat.stHpadding)
                    }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: GetDealLeftTopTabbar(), trailing: GetDealTopShareTabbar())
        }.onAppear(perform: {
            self.bookDealObservable.dealObj = self.viewRouter.dealObj
            self.bookDealObservable.selectedAddress = AddressObj(profile_id: self.viewRouter.dealObj.user_id, address: self.viewRouter.dealObj.address ?? "",city: self.viewRouter.dealObj.city, state:self.viewRouter.dealObj.state, zip_code:self.viewRouter.dealObj.zip_code, longitude:self.viewRouter.dealObj.longitude ?? "0.00", latitude:self.viewRouter.dealObj.latitude ?? "0.00")
        })
    }
}
struct GetDealTopShareTabbar: View {
    @EnvironmentObject var dealObservable: DealObservable
    var body: some View {
        HStack{
            Button(action: {
                //self.dealObservable.submitDeal()
            }) {
                Image( "Artboard 8")
                    .resizable()
                    .imageScale(.small)
                    .frame(width:20,height:20)
                    .accentColor(Color.main)
            }
        }
    }
}
struct GetDealLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "dealdetail"
            }) {
                Image("Artboard 3").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
