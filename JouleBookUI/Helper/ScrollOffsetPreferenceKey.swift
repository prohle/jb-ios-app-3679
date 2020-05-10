//
//  ScrollOffsetPreferenceKey.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/30/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = [CGFloat]
    
    static var defaultValue: [CGFloat] = [0]
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
