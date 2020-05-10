//
//  BaseView.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/27/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
//https://medium.com/better-programming/combine-swiftui-with-alamofire-abb4cd4a0aca

struct BaseView : View {
    //@Binding var settings: UserSettings
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var locationUpdate: LocationUpdate
    func containedView()-> some View{
       switch viewRouter.currentPage {
            case "myaddress": return AnyView(MyAddress().environmentObject(viewRouter).transition(.scale))
            case "accountmenus": return AnyView(AccountMenus().environmentObject(viewRouter).transition(.scale))
            case "myaccount": return AnyView(MyAccount().environmentObject(viewRouter).transition(.scale))
            case "myprofile": return AnyView(MyProfile().environmentObject(viewRouter).transition(.scale))
            case "providerprofile": return AnyView(ProviderProfile().environmentObject(viewRouter).transition(.scale))
            case "deals": return AnyView(DealList().environmentObject(viewRouter).environmentObject(locationUpdate).transition(.scale))
            case "dealdetail": return AnyView(DealDetail().environmentObject(viewRouter).environmentObject(locationUpdate).transition(.scale))
            case "gethired": return AnyView(GetHired().environmentObject(viewRouter).transition(.scale))
            case "googlemap": return AnyView(MapView().environmentObject(viewRouter).environmentObject(locationUpdate).transition(.scale))
            case "hire": return AnyView(Hire().environmentObject(viewRouter).transition(.scale))
            case "summary": return AnyView(Summary().environmentObject(viewRouter).transition(.scale))
            case "schedule": return AnyView(Schedule().environmentObject(viewRouter).transition(.scale))
            //case "editlicenseform": return AnyView(AddLicenseForm(licenseObj: ProviderLicense()).environmentObject(viewRouter).transition(.scale))
            case "createdeal": return AnyView(AddDealForm().environmentObject(viewRouter).transition(.scale))
            case "instantcat": return AnyView(InstantCatView(chosedCandidates:[]).environmentObject(viewRouter).transition(.scale))
            case "candidatedetail": return AnyView(Candidatedetail().environmentObject(viewRouter).transition(.scale))
            case "createaddress": return AnyView(CreateNewAddress().environmentObject(viewRouter).environmentObject(locationUpdate).transition(.scale))
            case "instanthelp": return AnyView(InstantHelp().environmentObject(viewRouter).transition(.scale))
            case "chatui": return AnyView(ChatUI().environmentObject(viewRouter).transition(.scale))
            case "getdeal": return AnyView(GetDeal().environmentObject(viewRouter).transition(.scale))
            case "bankcards": return AnyView(BankAccountsCards().environmentObject(viewRouter).transition(.scale))
            case "createcard": return AnyView(CreateCreditCard().environmentObject(viewRouter).transition(.scale))
            case "createconnectaccount": return AnyView(CreateConnectAccount().environmentObject(viewRouter).transition(.scale))
            default: return AnyView(Home().environmentObject(viewRouter).transition(.scale))
        }
    }
    func notLoginedContainedView()-> some View{
        switch viewRouter.currentPage {
        case "welcome": return (viewRouter.onboardComplete == true) ? AnyView(SignIn().environmentObject(viewRouter).transition(.scale)) : AnyView(Welcome().environmentObject(viewRouter).transition(.scale))
            case "phoneverification": return AnyView(PhoneVerification().environmentObject(viewRouter).transition(.scale))
            case "signup": return AnyView(SignUp().environmentObject(viewRouter).transition(.scale))
            case "forgotpassword": return AnyView(ForgotPassword().environmentObject(viewRouter).transition(.scale))
            default: return AnyView(SignIn().environmentObject(viewRouter).transition(.scale))
        }
    }
    /*
     .environmentObject(locationUpdate)
     var latitude: String  { return("\(viewRouter.location?.latitude ?? 0)") }
    var longitude: String { return("\(viewRouter.location?.longitude ?? 0)") }
    var placemark: String { return("\(viewRouter.placemark?.description ?? "XXX")") }*/
    //var status: String    { return("\(viewRouter.status)") }
    var body: some View {
            VStack {
                /*
                VStack {
                    Text("Latitude: \(self.latitude)")
                    Text("Longitude: \(self.longitude)")
                    Text("Placemark: \(self.placemark)")
                    Text("Status: \(self.status)")
                }*/
                if(viewRouter.loggedIn == true){
                    containedView()
                    Spacer()
                    BottomMainMenus().environmentObject(viewRouter)
                }else{
                    notLoginedContainedView()
                }
        }
    }
}


#if DEBUG
struct BaseView_Previews : PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
#endif
