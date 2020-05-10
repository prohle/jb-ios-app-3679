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
import KeychainAccess
import SwiftyRSA
struct UserTokens: Codable{
    var access_token: String?
    var refresh_token: String?
}

struct ProviderSkills: Identifiable,Hashable, Codable {
    var id: Int = -1
    var skill_name: String = ""
    var profile_id: Int = 0
    var proficiency_level: Int = 0
    var description: String = ""
    var created_timestamp: String = ""
    var is_deleted: Bool = false
    var last_updated_timestamp: String = ""
    func saveSkill(){
        let skillRequest = SkillRequest(skill_name: self.skill_name, description: self.description, proficiency_level: self.proficiency_level)
        APIClient.postSkill(skillRequest: skillRequest){result in
            switch result {
                case .success(let emptyWithIdData):
                    debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
struct ListSkillsObj: Decodable{
    var data: [ProviderSkills]
}
struct SkillRequest: Codable {
    var skill_name: String = ""
    var description: String = ""
    var proficiency_level: Int = 0
}
struct ProviderVehicle: Identifiable,Hashable, Codable {
    var id: Int = -1
    var car_make: String = ""
    var color: String = ""
    var created_timestamp: String = ""
    var is_deleted: Bool = false
    var last_updated_timestamp: String = ""
    var model: String = ""
    var plate_number: String = ""
    var profile_id: Int = 0
    func saveVehicle() -> Bool{
        var saved: Bool = false
        let vehicleRequest = VehicleRequest(car_make: self.car_make, color: self.color, model: self.model, plate_number: self.plate_number)
        debugPrint("______________VehicleRequest /ProviderVehicle_______________",vehicleRequest)
        if self.id > 0 {
            APIClient.putVehicle(id: self.id, vehicleRequest: vehicleRequest){result in
                switch result {
                    case .success(let emptyWithIdData):
                        debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                        saved = true
                    case .failure(let error):
                        print(error)
                }
            }
        }else{
            APIClient.postVehicle(vehicleRequest: vehicleRequest){result in
                switch result {
                    case .success(let emptyWithIdData):
                        debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                    case .failure(let error):
                        print(error)
                }
            }
        }
        return saved
    }
    
}
struct ListVehiclesObj: Decodable{
    var data: [ProviderVehicle]
}
struct VehicleRequest: Codable{
    var car_make: String
    var color: String
    var model: String
    var plate_number: String
}
struct ProviderLicense: Identifiable,Hashable, Codable {
    var id: Int = -1
    var state: String? = ""
    var license_number: String? = ""
    var license_name: String? = ""
    var expiration_date: String? = ""
    var description: String? = ""
    var created_timestamp: String? = ""
    var is_deleted: Bool = false
    var last_updated_timestamp: String? = ""
    var profile_id: Int = 0
    var attach_1_url: String? = ""
    var attach_1_id: Int? = 0
    var attach_2_url: String? = ""
    var attach_2_id: Int? = 0
    func saveLicense(expirationDate : RKManager) -> Bool{
        var saved = false
        let licenseRequest = LicenseRequest(description: self.description ?? "", expiration_date: expirationDate.selectedDate.toUTCDateTimeStr(), license_name: self.license_name ?? "",license_number: self.license_number ?? "", state: self.state ?? "")
        debugPrint("______________LicenseRequest /ProviderLicense_______________",licenseRequest)
        if self.id > 0 {
            APIClient.putLicense(id: self.id, licenseRequest: licenseRequest){result in
                switch result {
                    case .success(let emptyWithIdData):
                        debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                        saved = true
                    case .failure(let error):
                        print(error)
                }
            }
        }else {
            APIClient.postLicense(licenseRequest: licenseRequest){result in
                switch result {
                    case .success(let emptyWithIdData):
                        debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                        saved = true
                    case .failure(let error):
                        print(error)
                }
            }
        }
        return saved
    }
}
struct ListLicensesObj: Decodable{
    var data: [ProviderLicense]
}
struct LicenseRequest: Codable{
    var description: String
    var expiration_date: String
    var license_name: String
    var license_number: String
    var state: String
}
struct ProviderInsurance: Identifiable,Hashable, Codable {
    var id: Int = -1
    var policy_number: String = ""
    var expiration_date: String = ""
    var coverage_for: String = ""
    var created_timestamp: String = ""
    var is_deleted: Bool = false
    var last_updated_timestamp: String = ""
    var profile_id: Int = 0
    func saveInsurance(expirationDate: RKManager) -> Bool{
        var saved: Bool = false
        let insuranceRequest = InsuranceRequest(coverage_for: self.coverage_for, expiration_date: expirationDate.selectedDate.toUTCDateTimeStr(), policy_number: self.policy_number)
        debugPrint("______________InsuranceRequest /ProviderInsurance_______________",insuranceRequest)
        if self.id > 0 {
            APIClient.putInsurance(id: self.id, insuranceRequest: insuranceRequest){result in
                switch result {
                    case .success(let emptyWithIdData):
                        debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                        saved = true
                    case .failure(let error):
                        print(error)
                }
            }
        }else {
            APIClient.postInsurance(insuranceRequest: insuranceRequest){result in
                switch result {
                    case .success(let emptyWithIdData):
                        debugPrint("______________EmptyWithIdData_______________",emptyWithIdData)
                    case .failure(let error):
                        print(error)
                }
            }
        }
        return saved
    }
}
struct ListInsurancesObj: Decodable{
    var data: [ProviderInsurance]
}
struct InsuranceRequest: Codable{
    var coverage_for: String
    var expiration_date: String
    var policy_number: String
}
struct UserProfileData: Codable{
   var data:UserProfile
    
}
struct SimpleProfile: Codable{
    var id: Int = -1
    var mobile_number: String = ""
    var email: String = ""
}
struct SimpleProfileData: Codable{
    var data:[SimpleProfile]
}
struct UserProfile: Codable{
    var id: Int = -1
    var about: String? = ""
    var account_number_list: String? = ""
    var address: ShortAddressObj? = ShortAddressObj()
    var background_check_status: Int? = 0
    var business_name: String? = ""
    var buyer_status: Int? = 0
    var date_of_birth: String? = ""
    var email: String? = ""
    var exempt_fatca_code: String? = ""
    var exempt_payee_code: String? = ""
    var first_name: String? = ""
    var last_name: String? = ""
    var middle_name: String? = ""
    var mobile_number: String? = ""
    var payment_address: ShortAddressObj? = ShortAddressObj()
    var profile_photo_status: Int? = 0
    var profile_photo_url: String? = ""
    var provider_status: Int? = 0
    var tax_classification_extra: String? = ""
    var tax_classification_type: Int? = 0
    var website: String? = ""
    init(){
        
    }
    func submitMyProfileUpdate(){
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        do {
            try keychain.set(self.date_of_birth ?? "", key: "dob")
            try keychain.set(self.first_name ?? "", key: "first_name")
            try keychain.set(self.last_name ?? "", key: "last_name")
        }
        catch let error {
            print(error)
        }
        let updateProfileQuery = UpdateProfileQuery(about: self.about ?? "", address: self.address ?? ShortAddressObj(), date_of_birth: self.date_of_birth ?? "", email: self.email ?? "", first_name: self.first_name ?? "", last_name: self.last_name ?? "", middle_name: self.middle_name ?? "", mobile_number: self.mobile_number ?? "", website: self.website ?? "")
        debugPrint("______________UpdateProfileQuery_______________",updateProfileQuery)
        APIClient.putMyprofile(updateProfileQuery: updateProfileQuery){result in
            switch result {
                case .success(let emptyNoIdData):
                    debugPrint("______________EmptyNoIdData_______________",emptyNoIdData)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}

struct UpdateProfileQuery: Encodable {
    let about: String
    let address: ShortAddressObj
    let date_of_birth: String
    let email: String
    let first_name: String
    let last_name: String
    let middle_name: String
    let mobile_number: String
    let website: String
}
struct OtpRes: Codable{
    var created_timestamp: String? = ""
    var expired_timestamp: String? = ""
    var otp_reference_id: String? = ""
    var regeneration_remaining: String? = ""
    var user_reference_code: String? = ""
}
struct OtpResData: Codable{
    var data: OtpRes
}
struct OtpRequest: Encodable{
    let delivery_channel: String
    let email: String
    let is_generate_ref_code: Bool
    let mobile_number: String
    let user_id: Int
}
struct ResendOtpRequest: Encodable{
    let otp_reference_id: String
}
struct OtpVerificationRequest: Encodable{
    let otp_code: String
    let otp_reference_id: String
    let user_reference_code: String
}
struct UpdatePasswordRequest: Encodable{
    let new_password: String
    let otp_reference_id: String
    let username: String
}
class UserViewModel: ObservableObject {
    // Input
    @Published var userName = ""
    @Published var password = ""
    @Published var mobile_number = ""
    @Published var accessToken = ""
    @Published var refreshToken = ""
    @Published var onboardComplete : Bool = false
    
    // Output
    @Published var isValid = false
    @Published var isPhoneValid = false
    @Published var usernameMessage = ""
    @Published var passwordMessage = ""
    @Published var otpMessage = ""
    @Published var phoneMessage = ""
    @Published var otp_code = ""
    @Published var otp_reference_id = ""
    @Published var user_reference_code = ""
    @Published var otpVerificationStatus: Bool = false
    @Published var from = ""
    @Published var user_id = 0
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isOtpValidPublisher: AnyPublisher<Bool, Never> {
        $otp_code
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { code in
                return code.count > 1
        }.eraseToAnyPublisher()
    }
    private var isPhoneNumberValidPublisher: AnyPublisher<Bool, Never> {
        $mobile_number
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { mobile in
                return mobile.isValidPhone()
        }.eraseToAnyPublisher()
    }
    func login(viewRouter: ViewRouter){
        let publicKey = try! PublicKey(pemEncoded: String.rsapublickey)
        let clear = try! ClearMessage(string: self.password, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        let data = encrypted.data
        APIClient.login(username: self.userName, password: data.base64EncodedString()){result in
            switch result {
            case .success(let finalData):
                print("________________SIGNIN_____________")
                if finalData.access_token != nil && finalData.access_token != "" {
                    DispatchQueue.main.async {
                        viewRouter.loggedIn = true
                        viewRouter.currentPage = "myprofile"
                        do {
                            try keychain.set(self.userName, key: "user_email")
                            try keychain.set("\(self.user_id)", key: "user_id")
                            try keychain.set(finalData.access_token!, key: "access_token")
                            try keychain.set(finalData.refresh_token!, key: "refresh_token")
                        }
                        catch let error {
                            print(error)
                        }
                        //self.authenticated = true
                    }
                }
                //print(finalData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func forgotPassword(viewRouter: ViewRouter){
        if self.isPhoneValid && !self.otp_reference_id.isEmpty && !self.otp_code.isEmpty {
            let otpVerificationRequest = OtpVerificationRequest(otp_code: self.otp_code, otp_reference_id: self.otp_reference_id, user_reference_code: self.user_reference_code)
            debugPrint("______________OtpVerificationRequest_______________",otpVerificationRequest)
            APIClient.otpVerificationRequest(otpVerificationRequest: otpVerificationRequest){result in
                switch result {
                    case .success(let emptyDataNoId):
                        debugPrint("______________EmptyDataNoId_______________",emptyDataNoId)
                        let updatePasswordRequest = UpdatePasswordRequest(new_password: self.password, otp_reference_id: self.otp_reference_id, username: self.userName)
                        APIClient.forgotPassword(updatePasswordRequest: updatePasswordRequest){result in
                            switch result {
                                case .success(let emptyDataNoId):
                                    debugPrint("______________EmptyDataNoId Updateed pass_______________",emptyDataNoId)
                                    self.login(viewRouter: viewRouter)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    func otpVerificationRequest(viewRouter: ViewRouter){
        if self.isPhoneValid && !self.otp_reference_id.isEmpty && !self.otp_code.isEmpty {
            let otpVerificationRequest = OtpVerificationRequest(otp_code: self.otp_code, otp_reference_id: self.otp_reference_id, user_reference_code: self.user_reference_code)
            debugPrint("______________OtpVerificationRequest_______________",otpVerificationRequest)
            APIClient.otpVerificationRequest(otpVerificationRequest: otpVerificationRequest){result in
                switch result {
                    case .success(let emptyDataNoId):
                        debugPrint("______________EmptyDataNoId_______________",emptyDataNoId)
                        viewRouter.currentPage = "myprofile"
                        
                        //self.otpVerificationStatus = true
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    func reSendOtpRequest(){
        if self.isPhoneValid && !self.otp_reference_id.isEmpty {
            let resendOtpRequest = ResendOtpRequest(otp_reference_id: self.otp_reference_id)
            debugPrint("______________ResendOtpRequest_______________",resendOtpRequest)
            APIClient.resendOtpRequest(resendOtpRequest: resendOtpRequest){result in
                switch result {
                    case .success(let otpResData):
                        debugPrint("______________OtpResData_______________",otpResData)
                        self.otp_reference_id = otpResData.data.otp_reference_id ?? ""
                        self.user_reference_code = otpResData.data.user_reference_code ?? ""
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    func sendOtpRequest(){
        if self.isPhoneValid {
            let otpRequest = OtpRequest(delivery_channel: "SMS", email: self.userName, is_generate_ref_code: true, mobile_number: self.mobile_number, user_id: self.user_id)
            debugPrint("______________OtpRequest_______________",otpRequest)
            APIClient.otpRequest(otpRequest: otpRequest){result in
                switch result {
                    case .success(let otpResData):
                        debugPrint("______________OtpResData_______________",otpResData)
                        self.otp_reference_id = otpResData.data.otp_reference_id ?? ""
                        self.user_reference_code = otpResData.data.user_reference_code ?? ""
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    private var isUsernameValidPublisher: AnyPublisher<Int, Never> {
        $userName
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                var unameValidate: Int = 0
                if !input.isEmail() {
                    unameValidate = 1
                }else{
                    APIClient.simpleProfile(email: input){ result in
                        switch result {
                            case .success(let existUsers):
                                print("______________ExistUsers______________")
                                print(existUsers.data)
                                if existUsers.data.count > 0 {
                                    unameValidate = 2
                                    self.mobile_number = existUsers.data[0].mobile_number
                                    self.user_id = existUsers.data[0].id
                                    if self.from == "forgotpass" {
                                        self.sendOtpRequest()
                                    }
                                }
                            case .failure(let error):
                                print(error)
                        }
                        
                    }
                }
                return unameValidate
        }
        .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password.count < 6
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
    /*Neu signup thi check email chưa dc đăng ký -> true, còn lại phải check email đã tồn tại hay chưa*/
    /*Trong forgot password , bước đầu check email đã exist hay chưa tương đương isFormValidPublisher là true <=> isValid == true**/
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
            .map { userNameIsValid, passwordIsValid in
                if self.from == "signup" {
                    return userNameIsValid == 0 && (passwordIsValid == .valid)
                }else if self.from == "signin" {
                    return userNameIsValid == 0 && (passwordIsValid == .valid)// phai sua lai 2 ve sau
                }else if self.from == "forgotpass" {
                    return userNameIsValid == 2
                }else{
                    return true
                }
        }
        .eraseToAnyPublisher()
    }
    
    init(from: String) {
        self.from = from
        isUsernameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                if self.from == "signup" {
                    return valid == 0 ? "" : ((valid == 1) ? "Invalid email format." : "Email address is already registed. Please sign in. ")
                }else{
                    return valid == 0 ? "Email & password combination is not recognized. Please try again or Sign up" : ((valid == 1) ? "Invalid email format." : "")
                }
                
        }
        .assign(to: \.usernameMessage, on: self)
        .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                
                switch passwordCheck {
                case .empty:
                    return "Password must be at least 6 characters in length."
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
        
        isPhoneNumberValidPublisher
        .receive(on: RunLoop.main)
        .map{ valid in
            (valid) ? "" : "Invalid phone format."
        }.assign(to: \.phoneMessage, on: self)
        .store(in: &cancellableSet)
        
        isOtpValidPublisher
        .receive(on: RunLoop.main)
        .map{ valid in
            (valid) ? "" : "Otp must be at least 2 characters in length."
        }.assign(to: \.otpMessage, on: self)
        .store(in: &cancellableSet)
        
        isPhoneNumberValidPublisher
        .receive(on: RunLoop.main)
        .assign(to: \.isPhoneValid, on: self)
        .store(in: &cancellableSet)
    }
}
