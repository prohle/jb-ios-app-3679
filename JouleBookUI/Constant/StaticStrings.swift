//
//  StaticStrings.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/1/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import SwiftUI
extension String{
    public static let rsapublickey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFjOHrK7zBkY9biyIuKj+Ze3ljIXX2wnsuTPCsjQRlXLEGgLTGlqs+Bc+8FrkCmVMeSru0JPv0mXuhB19AdeXQO4jplPeo4hWQkiL/UjtUEbMNN4H/hgQH0yDzIFFPL0LvzqXDZLjq88KL/sfYVBtsXxNYP9naPLdzKCXX574s3QIDAQAB"
}
extension String {
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}
/*
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
extension View {
    func dismissKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}*/
