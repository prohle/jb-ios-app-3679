//
//  TopReport.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct TopReport: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20){
                HStack(spacing: 15){
                    Image( systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accentColor(Color.main)
                    .frame(width:16)
                    .shadow(radius: 8)
                    TextBold(text: Date().toLocalDateStr())
                    Image( systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accentColor(Color.main)
                    .frame(width:16)
                    .shadow(radius: 8)
                }
                HStack{
                    VStack{
                        HStack{
                            VStack{
                                TextBold(text: "Jobs Scheduled")
                                TextBold(text: "05", color: Color.main,font: Font.bighomereport)
                            }.frame(width: geometry.size.width/3)
                            VerticalLine(color: Color.border)
                            VStack{
                                TextBold(text: "Waiting Offers")
                                TextBold(text: "02", color: Color.main,font: Font.bighomereport)
                            }.frame(width: geometry.size.width/3)
                        }.frame(height:80)
                        HStack{
                            VStack{
                                TextBold(text: "Jobs Listing")
                                TextBold(text: "01", color: Color.main,font: Font.bighomereport)
                            }.frame(width: geometry.size.width/3)
                            VerticalLine(color: Color.border)
                            VStack{
                                TextBold(text: "Deals Selling")
                                TextBold(text: "02", color: Color.main,font: Font.bighomereport)
                            }.frame(width: geometry.size.width/3)
                        }.frame(height:80)
                    }.frame(width: (geometry.size.width/3)*2)
                    VerticalLine(color: Color.border)
                    VStack{
                        TextBold(text: "Potential Income")
                        
                        TextBold(text: "50", color: Color.main,font: Font.bighomereport)
                    }.frame(width: (geometry.size.width/3))
                }
            }
        }
    }
}

struct TopReport_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TopReport()
        }
    }
}
