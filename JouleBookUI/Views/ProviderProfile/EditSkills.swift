//
//  EditSkills.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/10/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct ListSkills: View {
    //@Binding var providerProfileModel: ProviderProfileModel
    @EnvironmentObject var userObserved: UserProfileObserver
    var editable: Bool = false
    var body: some View {
        VStack{
             HStack{
                 TextBody(text: "0 - 1 year")
                 Spacer()
                TagList(allTags: self.$userObserved.skillsOne, selectedTags: Set<String>(), editable: self.editable, parentWidth: 250,placeHolder: "Insert your skill")
             }.padding([.top],CGFloat.stVpadding).padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "2 - 3 years")
                 Spacer()
                 TagList(allTags: self.$userObserved.skillsTwo, selectedTags: Set<String>(), editable: self.editable, parentWidth: 250,placeHolder: "Insert your skill")
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "4 - 5 years")
                 Spacer()
                 TagList(allTags: self.$userObserved.skillsThree, selectedTags: Set<String>(), editable: self.editable, parentWidth: 250,placeHolder: "Insert your skill")
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "5+ years")
                 Spacer()
                 TagList(allTags: self.$userObserved.skillsFour, selectedTags: Set<String>(), editable: self.editable, parentWidth: 250,placeHolder: "Insert your skill")
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
        }
    }
    
}
