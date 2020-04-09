//
//  AddJobForm.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
struct AddJobForm: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State  var jobObj : Job
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM-DD-YYYY"
        return formatter
    }()
    var body: some View {
        NavigationView {
            Form{
                Section{
                    HStack{
                        TextBody(text: "License Name")
                        Spacer()
                        TextField("Set License Name", text: $jobObj.name)
                            .font(.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: JobHomeLeftTopTabbar(), trailing: JobTopSaveTabbar())
        }.onAppear(perform: getDealDetail)
        .onDisappear {
            print("ContentView disappeared!")
        }
    }
    func getDealDetail(){
        
    }
}
struct JobTopSaveTabbar: View {
    //var providerProfileModel: ProviderProfileModel
    var body: some View {
        HStack{
            Button(action: {
                //debugPrint(self.providerProfileModel.skillsOne.count)
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
struct JobHomeLeftTopTabbar: View {
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
struct AddJobForm_Previews: PreviewProvider {
    static var previews: some View {
        AddJobForm(jobObj: Job(id: 1, name:"Test"))
    }
}*/
