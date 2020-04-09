//
//  FormattedTextField.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/15/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

import SwiftUI

public struct FormattedTextField<Formatter: TextFieldFormatter>: View {
    public init(_ title: String,
                value: Binding<Formatter.Value>,
                formatter: Formatter) {
        self.title = title
        self.value = value
        self.formatter = formatter
    }

    let title: String
    let value: Binding<Formatter.Value>
    let formatter: Formatter

    public var body: some View {
        TextField(title, text: Binding(get: {
            if self.isEditing {
                return self.editingValue
            } else {
                return self.formatter.displayString(for: self.value.wrappedValue)
            }
        }, set: { string in
            self.editingValue = string
            self.value.wrappedValue = self.formatter.value(from: string)
        }), onEditingChanged: { isEditing in
            self.isEditing = isEditing
            self.editingValue = self.formatter.editingString(for: self.value.wrappedValue)
        })
    }

    @State private var isEditing: Bool = false
    @State private var editingValue: String = ""
}

public protocol TextFieldFormatter {
    associatedtype Value
    func displayString(for value: Value) -> String
    func editingString(for value: Value) -> String
    func value(from string: String) -> Value
}
struct CurrencyTextFieldFormatter: TextFieldFormatter {
    typealias Value = Decimal?

    func displayString(for value: Decimal?) -> String {
        guard let value = value else { return "" }
        return NumberFormatter.currency.string(for: value) ?? ""
    }

    func editingString(for value: Decimal?) -> String {
        guard let value = value else { return "" }
        return NumberFormatter.currencyEditing.string(for: value) ?? ""
    }

    func value(from string: String) -> Decimal? {
        let formatter = NumberFormatter.currencyEditing
        let value = formatter.number(from: string)?.decimalValue
        let formattedString = value.map { formatter.string(for: $0) } as? String
        return formattedString.map { formatter.number(from: $0)?.decimalValue } as? Decimal
    }
}

extension NumberFormatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    static let currencyEditing: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        formatter.minimumFractionDigits = NumberFormatter.currency.minimumFractionDigits
        formatter.maximumFractionDigits = NumberFormatter.currency.maximumFractionDigits
        return formatter
    }()
}
