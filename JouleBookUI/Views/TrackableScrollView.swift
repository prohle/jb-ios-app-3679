//
//  TrackableScrollView.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/30/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct TrackableScrollView<Content>: View where Content: View {
    let axes: Axis.Set
    let showIndicators: Bool
    @Binding var contentOffset: CGFloat
    var itemHeight: Int = 0
    var itemsLimit: Int = 0
    var itemPerRow: Int = 0
    @Binding var page: Int
    let content: Content
    
    init(_ axes: Axis.Set = .vertical, showIndicators: Bool = true, contentOffset: Binding<CGFloat>, itemHeight: Int, itemsLimit: Int,itemPerRow: Int,page:Binding<Int>, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showIndicators = showIndicators
        self._contentOffset = contentOffset
        self.content = content()
        self.itemHeight = itemHeight
        self.itemsLimit = itemsLimit
        self._page = page
        self.itemPerRow = itemPerRow
    }
    
    var body: some View {
        GeometryReader { outsideProxy in
            ScrollView(self.axes, showsIndicators: self.showIndicators) {
                ZStack(alignment: self.axes == .vertical ? .top : .leading) {
                    GeometryReader { insideProxy in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
                    }
                    VStack {
                        self.content
                    }
                }
            }.onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.contentOffset = value[0]
                let maxRows = CGFloat(self.itemsLimit/self.itemPerRow).rounded()
                let scrolledRows = (self.contentOffset/CGFloat(self.itemHeight)).rounded()
                self.page = Int(CGFloat(scrolledRows/maxRows).rounded())+1
                //if scrolledRows >= maxRows {
                    //self.page+=1
                //}
                //debugPrint("Count page from /TrackableScrollView: ",(self.contentOffset/CGFloat(self.itemHeight)).rounded()," Page ",self.page )
            }
        }
    }
    
    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        if axes == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
        }
    }
}
