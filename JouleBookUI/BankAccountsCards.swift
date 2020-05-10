//
//  BankAccountsCards.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 5/5/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
struct CardItemRow: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var cardObj: CardObj
    var body: some View {
        HStack(spacing: 15){
            ImageUrl(imageUrl:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",width: 36,height:36)
            TextBold(text: cardObj.brand,font: Font.texttitle)
            TextBody(text: (cardObj.is_default == true) ? "Default" : "", color: Color.main)
            Spacer()
            TextBody(text: cardObj.last4)
        }
    }
}
struct CardsSelectAble: View{
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var page: Int = 1
    @ObservedObject var cardsObserver: CardsObserver = CardsObserver()
    @Binding var selectedCard: CardObj
    @Binding var showSheet: Bool
    var body: some View {
        GeometryReader { geometry in
            TrackableScrollView(.vertical, contentOffset: self.$scrollViewContentOffset, itemHeight:Int.cardItemHeight, itemsLimit:Int.cardItemsLimit,itemPerRow:1, page: self.$cardsObserver.page) {
                VStack(alignment: .leading, spacing:5){
                    if(self.cardsObserver.cardObjs.count > 0){
                        ForEach(self.cardsObserver.cardObjs){cardObj in
                            Button(action: {
                                self.selectedCard = cardObj
                                self.showSheet = false
                            }){
                                CardItemRow(cardObj: cardObj)
                            }
                            HorizontalLine(color: (self.selectedCard.id == cardObj.id) ?  Color.main : Color.border)
                        }
                    }
                }.padding([.horizontal],CGFloat.stHpadding)
                .padding(CGFloat.stVpadding)
                .frame(width: geometry.size.width)
            }
        }
    }
}
struct BankAccountsCards: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var page: Int = 1
    @ObservedObject var cardsObserver: CardsObserver = CardsObserver()
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                TrackableScrollView(.vertical, contentOffset: self.$scrollViewContentOffset, itemHeight:Int.cardItemHeight, itemsLimit:Int.cardItemsLimit,itemPerRow:1, page: self.$cardsObserver.page) {
                    VStack(spacing: 20){
                        VStack{
                            TextBold(text: "Credit Card")
                            if(self.cardsObserver.cardObjs.count > 0){
                                ForEach(self.cardsObserver.cardObjs){cardObj in
                                    CardItemRow(cardObj: cardObj).environmentObject(self.viewRouter)
                                    HorizontalLine(color: .border)
                                }
                            }
                            Button(action:{
                                self.viewRouter.currentPage = "createcard"
                            }){
                                NormalButton(btnText: "Add New Credit Card",fontSize: .body, textColor: Color.maintext, borderColor: Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(0.00)).frame(width: geometry.size.width)
                            }
                        }
                        VStack{
                            TextBold(text: "Bank Account")
                            Button(action:{
                                self.viewRouter.currentPage = "createconnectaccount"
                            }){
                                NormalButton(btnText: "Add New Bank Account",fontSize: .body, textColor: Color.maintext, borderColor: Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(0.00)).frame(width: geometry.size.width)
                            }
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}

class CardsObserver : ObservableObject{
     let objectWillChange = ObservableObjectPublisher()
     var oldPage: Int = -1
     @Published var page: Int = -1{
         didSet {
             if self.page > self.oldPage {
                 debugPrint("Page thay doi - /BankAccountsCards : ",self.page)
                 self.getCards()
                 objectWillChange.send()
             }
         }
     }
    @Published var cardObjs = [CardObj](){
        didSet {
            debugPrint("deals  thay doi - /BankAccountsCards : ")
            objectWillChange.send()
        }
    }
    
    func getCards(){
     oldPage = page
     APIClient.getCards(size: Int.dealItemsLimit, from: ((self.page > 0) ? (self.page-1) : 0)*Int.dealItemsLimit){ result in
             switch result {
                 case .success(let listCards):
                     print("______________Deals_______________")
                     print(listCards.data)
                     self.cardObjs = self.cardObjs.merge(mergeWith: listCards.data, uniquelyKeyedBy: \.id)
                 case .failure(let error):
                     print(error)
             }
         }
    }
}
struct BankAccountsCards_Previews: PreviewProvider {
    static var previews: some View {
        BankAccountsCards()
    }
}
