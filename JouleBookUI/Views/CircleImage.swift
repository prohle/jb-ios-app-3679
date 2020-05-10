//
//  CircleImage.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import UIKit
import SwiftUI
import URLImage
struct CircleImage: View {
    var imageUrl: String!
    var size: Int!
    var body: some View {
            URLImage(URL(string: imageUrl)!,
                     processors: [ Resize(size: CGSize(width: size!, height: size!), scale: UIScreen.main.scale) ],
                     placeholder: { _ in
                        Text("Loading...")
                    }
            )
        /*image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray,lineWidth: 6))
            .shadow(radius: 10)*/
        
    }
}

#if DEBUG
struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(imageUrl: dealDatas[0].attach_1_url)
    }
}
#endif
