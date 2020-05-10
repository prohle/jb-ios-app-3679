//
//  BottomMainMenus.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct AddButtons : View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var presentForm: Bool
    var body: some View {
        HStack(spacing: 30){
            Spacer()
            Button(action: {
                self.viewRouter.currentPage = "createjob"
                self.presentForm = false
            }){
                VStack{
                    Image("MenuBottom22")
                        .accentColor(.main)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.border, lineWidth: 1)
                        )
                    TextBold(text: "Create Job")
                }
                
            }
            
            Button(action: {
                self.viewRouter.currentPage = "createdeal"
                self.presentForm = false
            }){
                VStack{
                    Image("MenuBottom12")
                        .accentColor(.main)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.border, lineWidth: 1)
                        )
                    TextBold(text: "Create Deal")
                }
            }
            Spacer()
        }
    }
}
struct BottomMainMenus: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var presentForm: Bool = false
    var body: some View {
        ZStack{
            if self.viewRouter.currentPage !=  "chatui"{
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            self.presentForm.toggle()
                            
                        }, label: {
                            Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 50, height: 43)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                        })
                        .background(Color.main)
                        .cornerRadius(25)
                        .padding()
                            .offset(y: -70)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                    }
                    BottomSheetView(
                        isOpen: self.$presentForm,
                        maxHeight: 250
                    ) {
                        AddButtons(presentForm: self.$presentForm).environmentObject(viewRouter)
                    }
                }
            }
            HStack(alignment:.center,spacing: 10){
                Spacer()
               
               Button(
                    action:{
                        self.viewRouter.currentPage = "deals"
                        //debugPrint(self.viewRouter.currentPage)
                    },
                    label: {
                        VTextIcon(imageIconTop:(self.viewRouter.currentPage == "deals") ? "MenuBottom12" :  "MenuBottom1",text:"Deals",iconTopSize:44)
                    }
                )
               Button(
                    action:{
                        self.viewRouter.currentPage = "gethired"
                        //debugPrint(self.viewRouter.currentPage)
                    },
                    label: {
                        VTextIcon(imageIconTop:(self.viewRouter.currentPage == "gethired") ? "MenuBottom22" :  "MenuBottom2",text:"Get Hired",iconTopSize:44)
                    }
                )
                Button(
                    action:{
                        self.viewRouter.currentPage = "hire"
                    },
                    label: {
                        VTextIcon(imageIconTop:(self.viewRouter.currentPage == "hire") ? "MenuBottom32" :  "MenuBottom3",text:"Hire",iconTopSize:44)
                    }
                )
                Button(
                    action:{
                        self.viewRouter.currentPage = "summary"
                    },
                    label: {
                        VTextIcon(imageIconTop:(self.viewRouter.currentPage == "summary") ? "MenuBottomMenuBottom42" :  "MenuBottom4",text:"Summary",iconTopSize:44)
                    }
                )
                Button(
                    action:{
                        self.viewRouter.currentPage = "schedule"
                    },
                    label: {
                        VTextIcon(imageIconTop:(self.viewRouter.currentPage == "schedule") ? "MenuBottom52" :  "MenuBottom5",text:"Schedule",iconTopSize:44)
                    }
                )
               
                Spacer()
            }.padding([.bottom],10).padding([.top],10).frame(height:65).background(Color.white)
        }.frame(height: 80)
        /*TabView(selection: $selectedView) {
            
            NavigationView {
                DealList(arrDeal:[Deal(id:1,name:"Test deal 1",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3),Deal(id:2,name:"Test deal 2",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3),Deal(id:3,name:"Test deal 3",imageName:"",coordinates: Coordinates(latitude:1234, longitude:1234),category:3)])
                    .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar()
                )
            }
            .tabItem {
                Image.init("Artboard 10", tintColor: .clear)
                Text("Deals")
            }.tag(0)
            
            NavigationView {
                GetHired().navigationBarItems(trailing:
                    MainTopTabbar()
                )
            }
            .tabItem {
                Image.init("Artboard 10", tintColor: .clear)
                Text("Get Hired")
            }.tag(1)
            NavigationView {
                Hire().navigationBarItems(trailing:
                    MainTopTabbar()
                )
            }
            .tabItem {
                Image.init("Artboard 10", tintColor: .clear)
                Text("Hire")
            }.tag(2)
            NavigationView {
                Summary().navigationBarItems(trailing:
                    MainTopTabbar()
                )
            }
            .tabItem {
                Image.init("Artboard 10", tintColor: .clear)
                Text("Summary")
            }.tag(3)
            NavigationView {
                Schedule().navigationBarItems(trailing:
                    MainTopTabbar()
                )
            }
            .tabItem {
                Image.init("Artboard 10", tintColor: .clear)
                Text("Schedule")
            }.tag(3)
        }
        .accentColor(Color.main)*/
    }
}
extension Image {
    init(_ named: String, tintColor: UIColor) {
        let uiImage = UIImage(named: named) ?? UIImage()
        let tintedImage = uiImage.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        self = Image(uiImage: tintedImage)
    }
}
//Artboard 10
struct BottomMainMenus_Previews: PreviewProvider {
    static var previews: some View {
        BottomMainMenus()
    }
}
