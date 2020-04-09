//
//  ViewRouter.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/27/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {

    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    var objectId: Int = -1{
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
    var isActived : Bool = true{
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    var loggedIn : Bool = false{
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    var onboardComplete : Bool = false{
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    var currentPage: String = "signin" {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
    /*@Published var login: Bool = false
    var loggedIn: Bool {
        didSet {
            objectWillChange.send(self)
            self.login = self.loggedIn
        }
    }*/
}
