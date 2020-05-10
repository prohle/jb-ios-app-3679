//
//  APIClient.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation

import Alamofire
import KeychainAccess
/*
extension DataRequest {
    func customValidate() -> Self {
        return self.validate { _, response, data -> Request.ValidationResult in
            guard (401...599) ~= response.statusCode else { return .success() }
            guard let data = data else { return .failure() }

            guard let errorResponse = try? JSONDecoder().decode(ErrorRespone.self, from: data) else {
                return .failure()
            }

            return .failure(MyAppGeneralError.responseError(errorResponse))
        }
    }

}*/
///     struct XMLParsingError: Error {
///         enum ErrorKind {
///             case invalidCharacter
///             case mismatchedTag
///             case internalError
///         }
///
///         let line: Int
///         let column: Int
///         let kind: ErrorKind
///     }
///
///     func parse(_ source: String) throws -> XMLDoc {
///         // ...
///         throw XMLParsingError(line: 19, column: 5, kind: .mismatchedTag)
///         // ...
///     }
///
/// Once again, use pattern matching to conditionally catch errors. Here's how
/// you can catch any `XMLParsingError` errors thrown by the `parse(_:)`
/// function:
///
///     do {
///         let xmlDoc = try parse(myXMLData)
///     } catch let e as XMLParsingError {
///         print("Parsing error: \(e.kind) [\(e.line):\(e.column)]")
///     } catch {
///         print("Other error: \(error)")
///     }
///     // Prints "Parsing error: mismatchedTag [19:5]"

struct ServerRestApiError: Error {
    let code: String
    let message: String
}
fileprivate typealias ErrorReason = AFError.ResponseValidationFailureReason
class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError>)->Void) -> DataRequest {
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        let interceptor = RequestInterceptor(storage: keychain)
        decoder.dateDecodingStrategy =  .formatted(DateFormatter.iso8601Full)
        return AF.request(route, interceptor: interceptor)
            .validate(contentType: ["application/json"])
            /*.validate(statusCode: 399..<500)
            .responseDecodable (decoder: decoder){ (response: DataResponse<ErrorRespone,AFError>) in
                debugPrint("------PHU_LAY_ERROR----",response)
            }*/
            .validate(statusCode: 200..<401)
            .validate ({ (request, response, data) -> Request.ValidationResult in
                /*if acceptableStatusCodes.contains(response.statusCode) {
                    return .success(Void())
                } else {
                    let reason: ErrorReason = .unacceptableStatusCode(code: response.statusCode)
                    return .failure(AFError.responseValidationFailed(reason: reason))
                }**/
                if(response.statusCode == 400){
                    //let errorResponse = try? JSONDecoder().decode(ErrorRespone.self, from: data!)
                    guard let errorResponse = try? JSONDecoder().decode(ErrorRespone.self, from: data!) else {
                        let reason: ErrorReason = .unacceptableStatusCode(code: 501)
                        return .failure(AFError.responseValidationFailed(reason: reason))
                    }
                    debugPrint("---------REALERROR-------------",errorResponse)
                    //let reason: ErrorReason
                    //reason = .customValidationFailed(error: ServerRestApiError(code: errorResponse.status.code, message: errorResponse.status.message))
                    /*if errorResponse.status.code == "access_token_expire" {
                        reason = .customValidationFailed(error: ServerRestApiError(code: ""))
                    }else{
                        reason = .customValidationFailed(code: 402)
                    }*/
                    
                    //let reason: ErrorReason = .unacceptableStatusCode(code: response.statusCode)
                    //AFError.responseValidationFailed(reason: reason)
                    return Request.ValidationResult.failure(ServerRestApiError(code: errorResponse.status.code, message: errorResponse.status.message))
                }else{
                    return Request.ValidationResult.success(Void())
                }
                
            })
            .responseDecodable (decoder: decoder){ (response: DataResponse<T,AFError>) in
                completion(response.result)
                /*let statusCode = response.response?.statusCode
                if(statusCode ?? 200 < 400){
                    completion(response.result)
                }else{
                    
                }*/
        }
    }
    static func upload(image: Data, to url: Alamofire.URLRequestConvertible, params: [String: Any]) {
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(image, withName: "file", fileName: "file.png", mimeType: "image/jpeg")
        }, with: url)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
                //Do what ever you want to do with response
            })
    }
    static func loadDeals(size: Int,from: Int, cat: Int, q: String,northeast: String, southwest: String, latlng: String, completion:@escaping (Result<ListDeal,AFError>)->Void){
        performRequest(route: APIRouter.deals(size: size, from: from, cat: cat, q: q, northeast: northeast, southwest: southwest, latlng: latlng), completion: completion)
    }
    
    static func login(username: String, password: String, completion:@escaping (Result<TokenMessage,AFError>)->Void) {
        performRequest(route: APIRouter.login(username: username, password: password), completion: completion)
    }
    static func refreshToken(refreshToken: String, completion:@escaping (Result<TokenMessage,AFError>)->Void) {
        performRequest(route: APIRouter.refreshtoken(refreshToken: refreshToken), completion: completion)
    }
    static func getCards(size: Int,from: Int,completion:@escaping (Result<ListCardObj,AFError>)->Void){
        performRequest(route: APIRouter.getcards(size: size, from: from), completion: completion)
    }
    static func postCard(createCardQuery: CreateCardQuery,completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.postcard(createCardQuery: createCardQuery), completion: completion)
    }
    static func putCard(id: Int, createCardQuery: CreateCardQuery,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.putcard(id: id, createCardQuery: createCardQuery), completion: completion)
    }
    /*
    static func delCard(id: Int,  completion:@escaping (Result<Void,AFError>)->Void){
        performRequest(route: APIRouter.delcard(id: id), completion: completion)
    }*/
    static func loadAddresss(size: Int,from: Int,completion:@escaping (Result<ListAddressObj,AFError>)->Void){
        performRequest(route: APIRouter.addresss(size: size, from: from), completion: completion)
    }
    static func createDeal(createDealQuery: CreateDealQuery,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.createdeal(createDealQuery: createDealQuery), completion: completion)
    }
    static func createAddress(createAddressQuery: CreateAddressQuery,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.createaddress(createAddressQuery: createAddressQuery), completion: completion)
    }
    static func putAddress(id: Int, createAddressQuery: CreateAddressQuery,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.putaddress(id:id,createAddressQuery: createAddressQuery), completion: completion)
    }
    static func loadLicenses(size: Int,from: Int,completion:@escaping (Result<ListLicensesObj,AFError>)->Void){
        performRequest(route: APIRouter.getlicensess(size: size, from: from), completion: completion)
    }
    static func postLicense(licenseRequest: LicenseRequest,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.postlicense(licenseRequest: licenseRequest), completion: completion)
    }
    static func putLicense(id: Int, licenseRequest: LicenseRequest,  completion:@escaping (Result<EmptyDataNoId,AFError>)->Void){
        performRequest(route: APIRouter.putlicense(id: id, licenseRequest: licenseRequest), completion: completion)
    }
    static func postSkill(skillRequest: SkillRequest,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.postskill(skillRequest: skillRequest), completion: completion)
    }
    static func putSkill(id: Int,skillRequest: SkillRequest,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.putskill(id:id,skillRequest: skillRequest), completion: completion)
    }
    static func loadSkills(size: Int,from: Int,completion:@escaping (Result<ListSkillsObj,AFError>)->Void){
        performRequest(route: APIRouter.getskills(size: size, from: from), completion: completion)
    }
    static func postVehicle(vehicleRequest: VehicleRequest,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.postvehicle(vehicleRequest: vehicleRequest), completion: completion)
    }
    static func putVehicle(id: Int, vehicleRequest: VehicleRequest,  completion:@escaping (Result<EmptyDataNoId,AFError>)->Void){
        performRequest(route: APIRouter.putvehicle(id:id, vehicleRequest: vehicleRequest), completion: completion)
    }
    static func loadVehicles(size: Int,from: Int,completion:@escaping (Result<ListVehiclesObj,AFError>)->Void){
        performRequest(route: APIRouter.getvehicles(size: size, from: from), completion: completion)
    }
    static func postInsurance(insuranceRequest: InsuranceRequest,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.postinsurance(insuranceRequest: insuranceRequest), completion: completion)
    }
    static func putInsurance(id: Int, insuranceRequest: InsuranceRequest,  completion:@escaping (Result<EmptyDataNoId,AFError>)->Void){
        performRequest(route: APIRouter.putinsurance(id: id, insuranceRequest: insuranceRequest), completion: completion)
    }
    static func loadInsurances(size: Int,from: Int,completion:@escaping (Result<ListInsurancesObj,AFError>)->Void){
        performRequest(route: APIRouter.getinsurances(size: size, from: from), completion: completion)
    }
    static func getDealDetail(id: Int,completion:@escaping (Result<DealDetailData,AFError>)->Void){
        performRequest(route: APIRouter.dealdetail(id: id), completion: completion)
    }
    static func cardSetups(completion:@escaping (Result<CardSetupsObj,AFError>)->Void){
        performRequest(route: APIRouter.cardsetups, completion: completion)
    }
    static func putMyprofile(updateProfileQuery: UpdateProfileQuery,  completion:@escaping (Result<EmptyDataNoId,AFError>)->Void){
        performRequest(route: APIRouter.putmyprofile(updateProfileQuery: updateProfileQuery), completion: completion)
    }
    static func getUserProfile( completion:@escaping (Result<UserProfileData,AFError>)->Void){
        performRequest(route: APIRouter.getuserprofile, completion: completion)
    }
    static func postConnectAccount(createConnectAccountQuery: CreateConnectAccountQuery,  completion:@escaping (Result<EmptyDataWithId,AFError>)->Void){
        performRequest(route: APIRouter.postconnectaccount(createConnectAccountQuery: createConnectAccountQuery), completion: completion)
    }
    static func simpleProfile(email: String,completion:@escaping (Result<SimpleProfileData,AFError>)->Void){
        performRequest(route: APIRouter.simpleprofile(email: email), completion: completion)
    }
    static func otpRequest(otpRequest: OtpRequest,  completion:@escaping (Result<OtpResData,AFError>)->Void){
        performRequest(route: APIRouter.otprequest(otpRequest: otpRequest), completion: completion)
    }
    static func otpVerificationRequest(otpVerificationRequest: OtpVerificationRequest,  completion:@escaping (Result<EmptyDataNoId,AFError>)->Void){
        performRequest(route: APIRouter.otpverificationrequest(otpVerificationRequest: otpVerificationRequest), completion: completion)
    }
    static func resendOtpRequest(resendOtpRequest: ResendOtpRequest,  completion:@escaping (Result<OtpResData,AFError>)->Void){
        performRequest(route: APIRouter.resendotprequest(resendOtpRequest: resendOtpRequest), completion: completion)
    }
    static func forgotPassword(updatePasswordRequest: UpdatePasswordRequest,  completion:@escaping (Result<OtpResData,AFError>)->Void){
        performRequest(route: APIRouter.forgotpassword(updatePasswordRequest: updatePasswordRequest), completion: completion)
    }
    static func bookDeal(id: Int, bookDealQuery: BookDealQuery,  completion:@escaping (Result<EmptyDataNoId,AFError>)->Void){
        performRequest(route: APIRouter.bookdeal(id: id, bookDealQuery: bookDealQuery), completion: completion)
    }
    static func multiBookDeal(id: Int, multiBookDealQuery: [BookDealQuery],  completion:@escaping (Result<EmptyDataNoId,AFError>)->Void){
        performRequest(route: APIRouter.multibookdeal(id: id, mulBookDealQuery: multiBookDealQuery), completion: completion)
    }
}
extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
