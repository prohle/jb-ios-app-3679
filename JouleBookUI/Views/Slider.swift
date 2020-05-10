//
//  Slider.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/25/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct AssetSlider: View {
    @EnvironmentObject var viewrouter: ViewRouter
    var subViews: [UIViewController]
    @State var currentPageIndex = 0
    var geometry: GeometryProxy
    var body: some View {
        VStack(spacing: 0) {
            PageViewController(currentPageIndex: $currentPageIndex,viewControllers: subViews).frame(width:self.geometry.size.width - 2*CGFloat.stHpadding,height: self.geometry.size.height*2/5)
            HStack {
                Spacer()
                PageControl(numberOfPages: subViews.count, currentPageIndex: $currentPageIndex)
                Spacer()
            }.padding(10).frame(width:self.geometry.size.width - 2*CGFloat.stHpadding)
        }
    }
}
/*
struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        Slider()
    }
}*/
