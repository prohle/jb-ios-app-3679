//
//  Dimens.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/18/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

extension CGFloat {
    public static let stVpadding = CGFloat(10.00)
    public static let stHpadding = CGFloat(10.00)
    public static let btnHeight = CGFloat(36.00)
}
extension Int {
    public static let dealItemsLimit = 16
    public static let dealItemHeight = 228
    public static let cardItemsLimit = 16
    public static let cardItemHeight = 70
}
extension Double{
    func formatMoney() -> String {
        return NumberFormatter.currency.string(for: self) ?? "0.00"
    }
}
