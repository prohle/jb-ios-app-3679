//
//  ImageUrl.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/26/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import UIKit
import SwiftUI
import URLImage
struct ImageUrlSameHeight: View {
    var imageUrl: String!
    var width: CGFloat!
    var body: some View {
        //GeometryReader { geometry in
            //HStack{
                URLImage(URL(string: self.imageUrl)!,
                         placeholder: { _ in
                            Text("Loading...")
                        },
                         content:  {
                             $0.image
                                .resizable()
                                .scaledToFill()
                                 .aspectRatio(contentMode: .fit)
                                 .clipShape(RoundedRectangle(cornerRadius: 5))
                                .frame(width: self.width)
                         }
                )
            //}
        //}
    }
}
struct ImageUrl: View {
    var imageUrl: String!
    var width: CGFloat!
    var height: CGFloat!
    var body: some View {
        /*
         processors: [ Resize(size: CGSize(width: width!, height: height!), scale: UIScreen.main.scale) ],
         
         */
            URLImage(URL(string: imageUrl)!,
                     placeholder: { _ in
                        Text("Loading...")
                    },
                     content:  {
                         $0.image
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .clipShape(RoundedRectangle(cornerRadius: 5))
                            .frame(width: self.width, height: self.height)
                             //.clipped()
                     }
            )
    }
}
//.frame(width: width, height: height)
struct ImageUrl_Previews: PreviewProvider {
    static var previews: some View {
        ImageUrl(imageUrl: dealDatas[0].attach_1_url)
    }
}
