//
//  UserView.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import Combine
import Navajo_Swift
struct UserTokens: Codable{
    var access_token: String?
    var refresh_token: String?
}

struct ProviderSkills: Identifiable,Hashable, Codable {
    var id: Int = -1
    var skillName: String = ""
    var profileId: Int = 0
    var proficiencyLevel: Int = 0
    var description: String = ""
    var createdTimestamp: String = ""
    var isDeleted: Bool = false
    var lastUpdatedTimestamp: String = ""
}
struct ProviderVehicle: Identifiable,Hashable, Codable {
    var id: Int = -1
    var carMake: String = ""
    var color: String = ""
    var createdTimestamp: String = ""
    var isDeleted: Bool = false
    var lastUpdatedTimestamp: String = ""
    var model: String = ""
    var plateNumber: String = ""
    var profileId: Int = 0
}
struct ProviderLicense: Identifiable,Hashable, Codable {
    var id: Int = -1
    var state: String = ""
    var licenseNumber: String = ""
    var licenseName: String = ""
    var expirationDate: String = ""
    var description: String = ""
    var createdTimestamp: String = ""
    var isDeleted: Bool = false
    var lastUpdatedTimestamp: String = ""
    var profileId: Int = 0
    var attach1Url: String = ""
    var attach1Id: Int = 0
    var attach2Url: String = ""
    var attach2Id: Int = 0
}
struct ProviderInsurance: Identifiable,Hashable, Codable {
    var id: Int = -1
    var policyNumber: String = ""
    var expirationDate: String = ""
    var coverageFor: String = ""
    var createdTimestamp: String = ""
    var isDeleted: Bool = false
    var lastUpdatedTimestamp: String = ""
    var profileId: Int = 0
}
class ProviderLicenseObservable: ObservableObject {
    let objectWillChange = PassthroughSubject<ProviderLicenseObservable,Never>()
    @Published var id: Int = 0{
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var state: String = "State 1"{
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var licenseNumber: String = ""{
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var licenseName: String = ""{
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var expirationDate: String = ""{
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var description: String = ""{
        didSet {
            objectWillChange.send(self)
        }
    }
}
class ProviderProfileModel: ObservableObject {
    @Published var websiteAdr = ""
    @Published var aboutMe = ""
    let objectWillChange = PassthroughSubject<ProviderProfileModel,Never>()
    @Published var skillsOne: Set<String> = Set<String>(){
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var skillsTwo: Set<String> = Set<String>(){
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var skillsThree: Set<String> = Set<String>(){
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var skillsFour: Set<String> = Set<String>(){
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var licenseObjs: [ProviderLicense] = [ProviderLicense(id: 1,state: "ste", licenseNumber: "12345", licenseName: "Test", expirationDate: "2020-04-20 00:00:00", description: "")
        ]{
        didSet {
            objectWillChange.send(self)
        }
    }
    init() {
        
    }
}
class MyProfileModel: ObservableObject {
    @Published var firstName = ""
    @Published var midleName = ""
    @Published var lastName = ""
    @Published var emailAdr = ""
    @Published var mobileNum = ""
    @Published var emailMessage = ""
    @Published var mobileMessage = ""
    private var cancellableSet: Set<AnyCancellable> = []
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $emailAdr
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
        }
        .eraseToAnyPublisher()
    }
    private var isMobileValidPublisher: AnyPublisher<Bool, Never> {
        $mobileNum
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
        }
        .eraseToAnyPublisher()
    }
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        
        Publishers.CombineLatest(isEmailValidPublisher, isMobileValidPublisher)
            .map { emailIsValid, mobileIsValid in
                return emailIsValid && mobileIsValid
        }
        .eraseToAnyPublisher()
    }
    init() {
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Email must correct in format"
        }
        .assign(to: \.emailMessage, on: self)
        .store(in: &cancellableSet)
        
        isMobileValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Mobile number must correct in format"
        }
        .assign(to: \.mobileMessage, on: self)
        .store(in: &cancellableSet)
    }
}
class UserViewModel: ObservableObject {
    // Input
    @Published var userName = ""
    @Published var password = ""
    @Published var accessToken = ""
    @Published var refreshToken = ""
    @Published var onboardComplete : Bool = false
    
    // Output
    @Published var isValid = false
    @Published var usernameMessage = ""
    @Published var passwordMessage = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $userName
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
        }
        .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password == ""
        }
        .eraseToAnyPublisher()
    }
    
    /*private var arePasswordEqualPublisher: AnyPublisher<Bool, Never> {
        
        Publishers.CombineLatest($password, $confirmPassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { password, confirmpassword in
                return password == confirmpassword
        }
        .eraseToAnyPublisher()
    }*/
    
    private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
        
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return Navajo.strength(ofPassword: input)
        }
        .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
        
        passwordStrengthPublisher
            .map { strenght in
                
                switch strenght {
                case .reasonable, .strong, .veryStrong:
                    return true
                default:
                    return false
                }
        }
        .eraseToAnyPublisher()
    }
    
    enum PasswordCheck {
        
        case valid
        case empty
        case noMatch
        case notStrongEnough
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        //arePasswordEqualPublisher,
        //passwordsAreEqual,
        Publishers.CombineLatest(isPasswordEmptyPublisher,  isPasswordStrongEnoughPublisher)
            .map { passwordIsEmpty,  passwordIsStrongEnough in
                
                if passwordIsEmpty {
                    return .empty
                }  else if !passwordIsStrongEnough {
                    return .notStrongEnough
                } else {
                    return .valid
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
            .map { userNameIsValid, passwordIsValid in
                return userNameIsValid && (passwordIsValid == .valid)
        }
        .eraseToAnyPublisher()
    }
    
    init() {
        
        isUsernameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "User name must at least have 3 characters"
        }
        .assign(to: \.usernameMessage, on: self)
        .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                
                switch passwordCheck {
                case .empty:
                    return "Password must not be empty"
                case .noMatch:
                    return "Passwords don't match"
                case .notStrongEnough:
                    return "Password not strong enough"
                default:
                    return ""
                }
        }
        .assign(to: \.passwordMessage, on: self)
        .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
}
