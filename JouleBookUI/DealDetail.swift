//
//  DealDetail.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/8/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import CoreLocation
import Combine
struct DealDetail: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var dealDetailObservable = DealDetailObservable()
    @State var presentForm: Bool = false
    @State var inputOffset: CGFloat = 0
    @State var keyboardAnimationDuration: TimeInterval = 0
    @State var typingMessage: String = ""
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack{
                    HStack{Spacer()}
                    ScrollView([.vertical],showsIndicators: false) {
                        VStack(spacing: 10){
                            AssetSlider(subViews: self.dealDetailObservable.getAssetsSlider(),geometry: geometry)
                            TitleBlock(dealObj: self.$dealDetailObservable.dealObj,geometry: geometry)
                            Informations(geometry: geometry, dealObj: self.$dealDetailObservable.dealObj, selectedTimeSlots: self.$dealDetailObservable.selectedTimeSlots).environmentObject(self.dealDetailObservable.rkManager)
                            
                            TextBold(text: "Q & A", color: .main).padding()
                            CommentUI(presentForm: self.$presentForm, typingMessage: self.$typingMessage).padding()
                            //TextBody(text: "Test: \(self.dealDetailObservable.selectedDateTimes.count)")
                        }.padding(CGFloat.stHpadding).frame(width: geometry.size.width - 2*CGFloat.stHpadding)
                    }
                    //.frame(width: geometry.size.width - 2*CGFloat.stHpadding)
                    if self.presentForm == true {
                        Spacer()
                        // TextField are aligned with the Send Button in the same line so we put them in HStack
                        HStack {
                            // this textField generates the value for the composedMessage @State var
                            TextField("Message...", text: self.$typingMessage).frame(minHeight: CGFloat(30)).onTapGesture {
                                print("Typing")
                            }
                            // the button triggers the sendMessage() function written in the end of current View
                            Button(action: {}) {
                                BasicButton(btnText:"Send",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody)
                            }.frame(height:32)
                            Spacer()
                        }.frame(width: geometry.size.width - 2*CGFloat.stHpadding)
                            .padding([.bottom], self.inputOffset)
                            .animation(.easeOut(duration: self.keyboardAnimationDuration))
                        .onReceive(
                          NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                            .receive(on: RunLoop.main),
                          perform: self.updateKeyboardHeight
                        )
                    }
                }.padding([.horizontal],CGFloat.stHpadding)
            }.onTapGesture {
                self.endEditing()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: DealDetailLeftTopTabbar(), trailing: DealDetailTopShareTabbar())
        }.onAppear(perform: {self.dealDetailObservable.loadDealDetail(dealId: self.viewRouter.objectId)})
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
    private func updateKeyboardHeight(_ notification: Notification) {
      guard let info = notification.userInfo else { return }
      // Get the duration of the keyboard animation
      keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25

      guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
      // If the top of the frame is at the bottom of the screen, set the height to 0.
      if keyboardFrame.origin.y == UIScreen.main.bounds.height {
        inputOffset = 0
      } else {
        // IMPORTANT: This height will _include_ the SafeAreaInset height.
        inputOffset = keyboardFrame.height
      }
    }
}
struct DealDetailTopShareTabbar: View {
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
struct DealDetailLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "deals"
            }) {
                Image("Artboard 3").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
/*
#if DEBUG
struct DealDetail_Previews: PreviewProvider {
    static var previews: some View {
        DealDetail(deal: dealDatas[0])
    }
}
#endif*/
