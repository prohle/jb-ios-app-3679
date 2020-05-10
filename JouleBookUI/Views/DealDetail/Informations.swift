//
//  Informations.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/25/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct Informations: View {
    var geometry: GeometryProxy
    @Binding var dealObj: DealDetailObj
    @EnvironmentObject var rkManager: RKManager
    @Binding var selectedTimeSlots: [DealDetailTimeOption]
    var body: some View {
        VStack(alignment:.leading,spacing:0){
            //Group{
                HStack{
                    TextBold(text: "Information Detail", color: Color.main, font: Font.texttitle)
                    Spacer()
                }.padding(CGFloat.stHpadding).background(Color.white).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
                HStack{
                    TextBody(text: "Service Provider").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 2,alignment: .topLeading)
                    HStack{
                        TextBody(text: "Peter", color: Color.textlink)
                        RatingBar()
                        Spacer()
                    }.frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 3,alignment: .topLeading)
                }.padding(CGFloat.stHpadding).background(Color.placeholder).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
                HStack{
                    TextBody(text: "Categories").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 2,alignment: .topLeading)
                    TextBody(text: "Cat 1, Cat 2")
                        .frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 3,alignment: .topLeading)
                }.padding(CGFloat.stHpadding).background(Color.white).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
               // HorizontalLine(color: .border).frame(width: self.geometry.size.width - 2*CGFloat.stHpadding)
                HStack{
                    TextBody(text: "Location").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 2,alignment: .topLeading)
                    VStack{
                        if self.dealObj.is_address_customer_choice == true{
                            TextBody(text:"Your Choice")
                        }
                        if self.dealObj.is_address_provider_choice == true{
                            TextBody(text:"\(self.dealObj.address ?? ""), \(self.dealObj.city ?? ""), \(self.dealObj.state ?? ""), \(self.dealObj.zip_code ?? "")")
                        }
                        if self.dealObj.is_address_remote == true{
                            TextBody(text:"Remote")
                        }
                    }.frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 3,alignment: .topLeading)
                        
                }.padding(CGFloat.stHpadding).background(Color.placeholder).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
                HStack{
                    TextBody(text: "Deal rate basic").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 2,alignment: .topLeading)
                    TextBody(text: (self.dealObj.execution_type == 1) ? "Flat rate per time option" : "Flat rate per time slot").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 3,alignment: .topLeading)
                }.padding(CGFloat.stHpadding).background(Color.white).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
                //HorizontalLine(color: .border).frame(width: self.geometry.size.width - 2*CGFloat.stHpadding)
            //}.frame(width: self.geometry.size.width - 2*CGFloat.stHpadding)
            //Group{
                HStack{
                    TextBody(text: "Service session duration").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 2,alignment: .topLeading)
                    TextBody(text: "\(String(describing:  self.dealObj.approx_duration)) hour(s)").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 3,alignment: .topLeading)
                }.padding(CGFloat.stHpadding).background(Color.placeholder).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
                if self.dealObj.deal_times.count > 0 {
                    VStack(alignment:.leading){
                        TextBody(text: "Time option")
                            if self.dealObj.execution_type == 1   {
                                RepeativeTimeOptionDetail(timeOptions: self.$dealObj.deal_times, selectedTimeSlots: self.$selectedTimeSlots)
                            }else{
                                SpecificDateTimeOptionDetail( timeOptions: self.$dealObj.deal_times, selectedTimeSlots: self.$selectedTimeSlots).environmentObject(self.rkManager)
                            }
                    }.padding(CGFloat.stHpadding).background(Color.white).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
                }
                //HorizontalLine(color: .border).frame(width: self.geometry.size.width - 2*CGFloat.stHpadding)
                if self.dealObj.execution_type == 1 && self.dealObj.deal_times.count > 0 {
                    HStack{
                        TextBody(text: "Deal Effective").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 2,alignment: .topLeading)
                        TextBody(text: "\(self.dealObj.deal_times[0].from_date?.utcDateStrToDate().toLocalDateStr() ?? "") - \(self.dealObj.deal_times[0].to_date?.utcDateStrToDate().toLocalDateStr()  ?? "")").frame(width: ((self.geometry.size.width - CGFloat.stHpadding*4)/5) * 3,alignment: .topLeading)
                        Spacer()
                    }.padding(CGFloat.stHpadding).background(Color.placeholder).frame(width: self.geometry.size.width - 4*CGFloat.stHpadding)
                }
            //}.frame(width: self.geometry.size.width - 2*CGFloat.stHpadding)
        }.frame(width: self.geometry.size.width - 2*CGFloat.stHpadding)
    }
}
/*
struct Informations_Previews: PreviewProvider {
    static var previews: some View {
        Informations()
    }
}*/
