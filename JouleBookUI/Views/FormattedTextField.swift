//
//  FormattedTextField.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/15/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
/*
 
 về alert deal cho buyer mình sẽ làm kiểu như sau :
 1) Khi user search theo 1 keyworks -> sẽ gửi kèm theo location lên elasticsearch để search những keyworks trong phạm vi mình giới hạn phục vụ cho deal(500km), nếu trả về những keyworks mà có match score > 70% thì mình sẽ mặc định hiểu đó là keyworks đã lưu, mỗi keywork mình có 1 list userids đi kèm (giống lưu dưới redis) -> kiểm tra xem user_id của buyer đang search đã có trong list userids đó chưa -> nếu chưa thì thêm vào. Nếu ko search dc key match score > 70% thì coi như mình thêm mới key theo location, user_id.(key: 'abcd', userids: '1,2,3','location':'lat,lon').
 2) Tạo cronjob quét khoảng 15phút/lần(giãn cách gửi notify tránh người dùng khó chịu), search  keyworks cho  từng state , từ mỗi keyworks search deals đã tạo trong 15 phút trước cho state ứng với keywork đó, nếu có tìm cách nhóm dealids theo userid (user1 sẽ quan tâm đến deal1,deal2) -> gửi notify. State ở mỹ thường sẽ có những map bound chuẩn(đông tây nam bắc lat lon) nên tỷ lệ bỏ sót keyworks hay deals là rất nhỏ, có bao nhiêu states thì cronjob của mình sẽ phải loop bây nhiêu lần
 3) Việc gửi notify mình sẽ sử dung 1 backend api cho firebase riêng
 Việc thu thập những keywork khi buyer xem deal trên web và mobile(click vào deal detail) sau này mình cũng sẽ làm, độ ưu tiên của những keywork này xếp sau độ ưu tiên khi buyer trực tiếp search, mình cũng sẽ đặt giới hạn số lượng deals mỗi lần gửi notify theo độ ưu tiên cho mỗi keywork
 **/
import SwiftUI
public struct FormattedTextField<Formatter: TextFieldFormatter>: View {
    @State private var isEditing: Bool = false
    @State private var editingValue: String = ""
    let title: String
    let value: Binding<Formatter.Value>
    let formatter: Formatter
    
    public init(_ title: String,
                value: Binding<Formatter.Value>,
                formatter: Formatter) {
        self.title = title
        self.value = value
        self.formatter = formatter
    }
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
        }),onEditingChanged: { isEditing in
            self.isEditing = isEditing
            self.editingValue = self.formatter.editingString(for: self.value.wrappedValue)
            //UIApplication.shared.endEditing()
        })
        /*{
            UIApplication.shared.endEditing()
        }
        //.keyboardType(UIKeyboardType.decimalPad)*/
    }
}

public protocol TextFieldFormatter {
    associatedtype Value
    func displayString(for value: Value) -> String
    func editingString(for value: Value) -> String
    func value(from string: String) -> Value
}
struct CurrencyTextFieldFormatter: TextFieldFormatter {
    typealias Value = Double
    func displayString(for value: Double) -> String {
        //guard let value = value else { return "" }
        return NumberFormatter.currency.string(for: value) ?? ""
    }

    func editingString(for value: Double) -> String {
        //guard let value = value else { return "" }
        return NumberFormatter.currencyEditing.string(for: value) ?? ""
    }

    func value(from string: String) -> Double {
        let formatter = NumberFormatter.currencyEditing
        //let value = formatter.number(from: string)?.doubleValue
        guard let value = formatter.number(from: string)?.doubleValue else { return 0.00 }
        return value
        //let formattedString = value.map { formatter.string(for: $0) } as? String
        //return (formattedString.map { formatter.number(from: $0)?.doubleValue } as? Double)!
    }
}
struct DoubleTextFieldFormatter: TextFieldFormatter {
    typealias Value = Double
    func displayString(for value: Double) -> String {
        //guard let value = value else { return "0.00" }
        return NumberFormatter.numformat.string(for: value) ?? "0.00"
    }

    func editingString(for value: Double) -> String {
        //guard let value = value else { return "0.00" }
        return NumberFormatter.numformatEditing.string(for: value) ?? "0.00"
    }

    func value(from string: String) -> Double {
        let formatter = NumberFormatter.numformatEditing
        guard let value = formatter.number(from: string)?.doubleValue else { return 0.00 }
        return value
        //let formattedString = value.map { formatter.string(for: $0) } as? String
        //return formattedString.map { formatter.number(from: $0)?.doubleValue }!!
    }
}

struct IntTextFieldFormatter: TextFieldFormatter {
    typealias Value = Int
    func displayString(for value: Int) -> String {
        //guard let value = value else { return "0" }
        return NumberFormatter.numformat.string(for: value)!
    }

    func editingString(for value: Int) -> String {
        //guard let value = value else { return "0" }
        return NumberFormatter.numformatEditing.string(for: value)!
    }

    func value(from string: String) -> Int {
        let formatter = NumberFormatter.numformatEditing
        guard let value = formatter.number(from: string)?.intValue else { return 0 }
        return value
        //let value = formatter.number(from: string)?.intValue
        //let formattedString = value.map { formatter.string(for: $0) } as? String
        //return (formattedString.map { formatter.number(from: $0)?.intValue } as? Int)!
    }
}
extension NumberFormatter {
    static let numformat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    static let numformatEditing: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        formatter.minimumFractionDigits = NumberFormatter.numformat.minimumFractionDigits
        formatter.maximumFractionDigits = NumberFormatter.numformat.maximumFractionDigits
        return formatter
    }()
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
