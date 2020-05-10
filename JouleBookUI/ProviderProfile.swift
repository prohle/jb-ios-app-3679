//
//  ProviderProfile.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
struct ProviderProfile: View {
    @ObservedObject var userObserved: UserProfileObserver = UserProfileObserver()
    //@State var userProfile:UserProfile = UserProfile()
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showCaptureImageView: ActiveSheet = .selectimg
    @State var showSheet: Bool = false
    @State var uiimages: [UIImage] = [UIImage]()
    var body: some View {
        NavigationView {
            Form{
                Section{
                    HStack{
                        Spacer()
                        ZStack(alignment: .bottomTrailing) {
                            if self.uiimages.count > 0 {
                                Image(uiImage: self.uiimages[0])
                                .resizable()
                                .frame(width: 120, height: 120)
                            }else{
                                Image("Artboard3")
                                .resizable()
                                .frame(width:120,height:120)
                            }
                            
                                /**/
                                //ImageUrl(imageUrl: dealDatas[0].getImgUrl())
                                Text("Edit")
                                    .padding(4)
                                    .frame(width:120)
                                    .font(Font.textbody)
                                    .background(Color.placeholder)
                                    .foregroundColor(Color.maintext)
                                    
                                    //.offset(x: -5, y: -5)
                            }.clipShape(Circle())
                            .onTapGesture {
                                self.showSheet.toggle()
                                self.showCaptureImageView = ActiveSheet.selectimg
                            }
                            Spacer()
                    }.padding([.vertical],CGFloat.stVpadding)
                    //.background(Color.mainback)
                    
                    HStack{
                        TextBody(text: "Background check status")
                        Spacer()
                        TextBody(text: "pending",align: .trailing, color: Color.main)
                    }.padding([.horizontal],CGFloat.stHpadding)
                    
                    //HorizontalLine(color: .border)
                    
                    HStack{
                        TextBody(text: "Website")
                        Spacer()
                        TextField("Peter", text:$userObserved.userProfile.website ?? "")
                            .font(.textbody)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                    }.padding([.horizontal],CGFloat.stHpadding)
                    //HorizontalLine(color: .border)
                    VStack(alignment: .leading){
                        TextBody(text: "About me")
                        TextField("For example: We are a privated-owned company with 1 employees. Our ", text:$userObserved.userProfile.about ?? "").font(.textbody).multilineTextAlignment(.trailing).autocapitalization(.none).padding([.vertical],2)
                    }.padding([.horizontal],CGFloat.stHpadding)
                    //HorizontalLine(color: .border)
                    HStack{
                        TextBody(text: "Offline Interview")
                        Spacer()
                        TextBody(text: ">",align: .trailing, color: Color.main)
                    }.padding(CGFloat.stHpadding)
                   
                    //HorizontalLine(color: .border)
                    
                    HStack{
                        TextBody(text: "Bank Account")
                        Spacer()
                        TextBody(text: ">",align: .trailing, color: Color.main)
                    }.padding(CGFloat.stHpadding)
                    //HorizontalLine(color: .border)
            }
            Section(header: TextBold(text: "Skills",color: Color.main)){
                ListSkills(editable: true).environmentObject(userObserved)
            }
            Section(header: TextBold(text: "Licenses",color: Color.main)){
                Licenses().environmentObject(userObserved)
            }
            Section(header: TextBold(text: "Vehicle",color: Color.main)){
                Vehicles().environmentObject(userObserved)
            }
            Section(header: TextBold(text: "Insurance",color: Color.main)){
                Insurances().environmentObject(userObserved)
            }
            }.sheet(isPresented: $showSheet) {
            if(self.showCaptureImageView == ActiveSheet.selectimg){
                CaptureImageView(isShown: self.$showSheet, uiimages: self.$uiimages, showCaptureImageView: self.$showCaptureImageView, maxImg: 1)
            }else if(self.showCaptureImageView == ActiveSheet.cutimg){
                CropImageForm(uiimage: self.$uiimages[0])
            }
        }.onTapGesture {
            self.endEditing()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: ProviderProfileHomeLeftTopTabbar(), trailing: ProviderProfileTopSaveTabbar(userProfile: self.$userObserved.userProfile))
        }
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
    
}
class UserProfileObserver : ObservableObject{
    let objectWillChange = ObservableObjectPublisher()
    @Published var userProfile = UserProfile(){
        didSet {
            debugPrint("UserProfile  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    @Published var skillsOne: Set<String> = Set<String>(){
        didSet {
            debugPrint("skillsOne  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    @Published var skillsTwo: Set<String> = Set<String>(){
        didSet {
            debugPrint("skillsTwo  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    @Published var skillsThree: Set<String> = Set<String>(){
        didSet {
            debugPrint("skillsThree  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    @Published var skillsFour: Set<String> = Set<String>(){
        didSet {
            debugPrint("skillsFour  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    @Published var licenseObjs:[ProviderLicense] = [ProviderLicense](){
        didSet {
            debugPrint("licenseObjs  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    @Published var vehicleObjs: [ProviderVehicle] = [ProviderVehicle](){
        didSet {
            debugPrint("vehicleObjs  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    @Published var insuranceObjs: [ProviderInsurance] =  [ProviderInsurance](){
        didSet {
            debugPrint("insuranceObjs  thay doi - /Providerprofile : ")
            objectWillChange.send()
        }
    }
    init(){
        self.getUserProfile()
        self.loadSkills()
        self.getLicenses()
        self.getVehicles()
        self.getInsurances()
    }
    func getInsurances(){
        APIClient.loadInsurances(size: 100, from: 0){ result in
            switch result {
                case .success(let listInsurances):
                    print("______________Insurances_______________")
                    print(listInsurances)
                    self.insuranceObjs = listInsurances.data
                case .failure(let error):
                    print(error)
            }
        }
    }
    func getVehicles(){
        APIClient.loadVehicles(size: 100, from: 0){ result in
            switch result {
                case .success(let listVehicles):
                    print("______________Vehicles_______________")
                    print(listVehicles)
                    self.vehicleObjs = listVehicles.data
                case .failure(let error):
                    print(error)
            }
        }
    }
    func loadSkills(){
        APIClient.loadSkills(size: 100, from: 0){ result in
            switch result {
                case .success(let listSkills):
                    print("______________Skills_______________")
                    print(listSkills)
                    let skillObjs: [ProviderSkills] = listSkills.data
                    if skillObjs.count > 0 {
                        for skillObj in skillObjs {
                            switch skillObj.proficiency_level {
                            case 2:
                                self.skillsTwo.insert(skillObj.skill_name)
                            case 3:
                                self.skillsThree.insert(skillObj.skill_name)
                            case 4:
                                self.skillsFour.insert(skillObj.skill_name)
                            default:
                                self.skillsOne.insert(skillObj.skill_name)
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    func getLicenses(){
        APIClient.loadLicenses(size: 100, from: 0){ result in
            switch result {
                case .success(let listLicenses):
                    print("______________Licenses_______________")
                    print(listLicenses)
                    self.licenseObjs = listLicenses.data
                case .failure(let error):
                    print(error)
            }
        }
    }
    func getUserProfile(){
        APIClient.getUserProfile(){ result in
            switch result {
                case .success(let userProfile):
                    print("______________UserProfile_______________")
                    self.userProfile = userProfile.data
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}
struct ProviderProfileTopSaveTabbar: View {
    @Binding var userProfile: UserProfile
    var body: some View {
        HStack{
            Button(action: {
                self.userProfile.submitMyProfileUpdate()
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
struct ProviderProfileHomeLeftTopTabbar: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack{
            Button(action: {
                self.viewRouter.currentPage = "myaccount"
            }) {
                Image("Artboard 3").resizable().imageScale(.large).frame(width:20,height:20).accentColor(Color.main)
            }
        }
    }
}
struct ProviderProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProviderProfile()
    }
}
