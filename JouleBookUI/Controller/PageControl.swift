//
//  PageControl.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var numberOfPages: Int
    
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
        
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor.init(displayP3Red: 85.0/255.0, green: 84.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        control.pageIndicatorTintColor = UIColor.lightGray
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
         
        uiView.currentPage = currentPageIndex
    }
}
