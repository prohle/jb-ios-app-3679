//
//  BaseView.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/27/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI


struct BaseView : View {
    //@Binding var settings: UserSettings
    @EnvironmentObject var viewRouter: ViewRouter
    func containedView()-> some View{
       switch viewRouter.currentPage {
            case "accountmenus": return AnyView(AccountMenus().environmentObject(viewRouter).transition(.scale))
            case "myaccount": return AnyView(MyAccount().environmentObject(viewRouter).transition(.scale))
            case "myprofile": return AnyView(MyProfile().environmentObject(viewRouter).transition(.scale))
            case "providerprofile": return AnyView(ProviderProfile().environmentObject(viewRouter).transition(.scale))
            case "deals": return AnyView(DealList(arrDeal: []).environmentObject(viewRouter).transition(.scale))
            case "gethired": return AnyView(GetHired().environmentObject(viewRouter).transition(.scale))
            case "hire": return AnyView(Hire().environmentObject(viewRouter).transition(.scale))
            case "summary": return AnyView(Summary().environmentObject(viewRouter).transition(.scale))
            case "schedule": return AnyView(Schedule().environmentObject(viewRouter).transition(.scale))
            case "editlicenseform": return AnyView(AddLicenseForm(licenseObj: ProviderLicense()).environmentObject(viewRouter).transition(.scale))
            case "createdeal": return AnyView(AddDealForm(dealObj: Deal(), catid: 0).environmentObject(viewRouter).transition(.scale))
            case "instantcat": return AnyView(InstantCatView(chosedCandidates:[]).environmentObject(viewRouter).transition(.scale))
            case "candidatedetail": return AnyView(Candidatedetail().environmentObject(viewRouter).transition(.scale))
            //case "home": return AnyView(Home().environmentObject(viewRouter).transition(.scale))
            default: return AnyView(Home().environmentObject(viewRouter).transition(.scale))
        }
    }
    func notLoginedContainedView()-> some View{
        switch viewRouter.currentPage {
        case "welcome": return (viewRouter.onboardComplete == true) ? AnyView(SignIn().environmentObject(viewRouter).transition(.scale)) : AnyView(Welcome().environmentObject(viewRouter).transition(.scale))
            case "phoneverification": return AnyView(PhoneVerification().environmentObject(viewRouter).transition(.scale))
            case "signup": return AnyView(SignUp().environmentObject(viewRouter).transition(.scale))
            default: return AnyView(SignIn().environmentObject(viewRouter).transition(.scale))
        }
    }
    var body: some View {
            VStack {
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
