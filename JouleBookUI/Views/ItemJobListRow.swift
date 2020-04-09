//
//  ItemJobListRow.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/26/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct ItemJobListRow: View {
    var jobObject: Job
    var body: some View {
        HStack(alignment: .firstTextBaseline,spacing:10){
            ZStack(alignment: .topLeading){ ImageUrl(imageUrl:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",width: CGFloat((UIScreen.main.bounds.width * 30) / 120),height:CGFloat((UIScreen.main.bounds.width * 20) / 100))
                Text("Test")
            }.padding(.top,10)
                .padding(.horizontal,10)
            VStack(alignment: .leading,spacing:5){
                HStack{
                    Text(jobObject.name)
                    .bold()
                    .font(Font.textbody).foregroundColor(Color.maintext)
                    .lineLimit(2)
                    .foregroundColor(Color.maintext)
                    Spacer()
                    Text("Sponsored").font(.textsmall).foregroundColor(Color.subtext)
                }
                Text("Pham van Mong").font(.textsmall).foregroundColor(Color.subtext)
                RatingBar()
                HStack{
                    Text("$80").bold().font(.textsmall).foregroundColor(Color.main)
                IconText(imageIconLeft:"Artboard 20",imageIconRight:nil,text:"12.5 miles",iconLeftSize:10)
                    IconText(imageIconLeft:"Artboard 21",imageIconRight:nil,text:"150 views",iconLeftSize:10)
                }
            }.padding(5)
        }
    }
}

struct ItemJobListRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemJobListRow(jobObject: Job(id:1,name:"Test Job 1",imageName:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",coordinates: Coordinates(latitude:1234, longitude:1234), category:3))
    }
}
