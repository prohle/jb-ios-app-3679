//
//  EditSkills.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/10/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct ViewSkills: View {
    @Binding var skillsOne: Set<String>
    @Binding var skillsTwo: Set<String>
    @Binding var skillsThree: Set<String>
    @Binding var skillsFour: Set<String>
    var body: some View {
        VStack{
             TextBold(text: "Skill Requirements", color:.textlink, font: .subheadline)
             HStack{
                 TextBody(text: "0 - 1 year")
                 Spacer()
                 TagList(allTags: self.$skillsOne, selectedTags: Set<String>(), editable: false, parentWidth: 250,placeHolder: "")
             }.padding([.top],CGFloat.stVpadding).padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "2 - 3 years")
                 Spacer()
                 TagList(allTags: self.$skillsTwo, selectedTags: Set<String>(), editable: false, parentWidth: 250)
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "4 - 5 years")
                 Spacer()
                TagList(allTags: self.$skillsThree, selectedTags: Set<String>(), editable: false, parentWidth: 250)
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "5+ years")
                 Spacer()
                 TagList(allTags: self.$skillsFour, selectedTags: Set<String>(), editable: false, parentWidth: 250)
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
        }
    }
}
struct EditSkills: View {
    //@Binding var providerProfileModel: ProviderProfileModel
    @Binding var skillsOne: Set<String>
    @Binding var skillsTwo: Set<String>
    @Binding var skillsThree: Set<String>
    @Binding var skillsFour: Set<String>
    var body: some View {
        VStack{
            HStack{
              TextBold(text: "Skills",color: Color.main)
                 Spacer()
             }.padding(CGFloat.stVpadding).background(Color.mainback)
             
             HStack{
                 TextBody(text: "0 - 1 year")
                 Spacer()
                 //VStack(alignment: .trailing,spacing:3){
                TagList(allTags: self.$skillsOne, selectedTags: Set<String>(), editable: true, parentWidth: 250,placeHolder: "")
                     //Spacer()
                 //}
             }.padding([.top],CGFloat.stVpadding).padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "2 - 3 years")
                 Spacer()
                 //VStack(alignment: .trailing,spacing:3){
                     TagList(allTags: self.$skillsTwo, selectedTags: Set<String>(), editable: true, parentWidth: 250)
                     //Spacer()
                 //}
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "4 - 5 years")
                 Spacer()
                 //VStack(alignment: .trailing,spacing:3){
                     TagList(allTags: self.$skillsThree, selectedTags: Set<String>(), editable: true, parentWidth: 250)
                     //Spacer()
                 //}
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
             HStack{
                 TextBody(text: "5+ years")
                 Spacer()
                 //VStack(alignment: .trailing,spacing:3){
                     TagList(allTags: self.$skillsFour, selectedTags: Set<String>(), editable: true, parentWidth: 250)
                     //Spacer()
                 //}
             }.padding([.horizontal],CGFloat.stHpadding)
             HorizontalLine(color: .border)
        }
    }
}
/*
struct EditSkills_Previews: PreviewProvider {
    static var previews: some View {
        EditSkills()
    }
}*/
