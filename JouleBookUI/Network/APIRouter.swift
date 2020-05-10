//
//  APIRouter.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/14/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import Foundation
import Alamofire
/*
struct RequestEncodableConvertible<Parameters: Encodable>: URLRequestConvertible {
    let url: URLConvertible
    let method: HTTPMethod
    let parameters: Parameters?
    let encoder: ParameterEncoder
    let headers: HTTPHeaders?
    let requestModifier: RequestModifier?

    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: url, method: method, headers: headers)
        try requestModifier?(&request)

        return try parameters.map { try encoder.encode($0, into: request) } ?? request
    }
}*/
struct DealQuery: Encodable {
    let size:Int
    let from:Int
    let cat:Int
    let q:String
    let northeast:String
    let southwest:String
    let latlng:String
}

public typealias RequestModifier = (inout URLRequest) throws -> Void
enum APIRouter: URLRequestConvertible {
    case login(username:String, password:String)
    case refreshtoken(refreshToken: String)
    case addresss(size: Int,from: Int)
    case deals(size: Int,from: Int, cat: Int, q: String, northeast: String, southwest: String, latlng: String)
    case dealdetail(id: Int)
    case createdeal(createDealQuery: CreateDealQuery)
    case createaddress(createAddressQuery: CreateAddressQuery)
    case putaddress(id:Int, createAddressQuery: CreateAddressQuery)
    case postlicense(licenseRequest: LicenseRequest)
    case putlicense(id: Int, licenseRequest: LicenseRequest)
    case getlicensess(size: Int,from: Int)
    case postskill(skillRequest: SkillRequest)
    case putskill(id: Int,skillRequest: SkillRequest)
    case getskills(size: Int,from: Int)
    case postvehicle(vehicleRequest: VehicleRequest)
    case putvehicle(id: Int,vehicleRequest: VehicleRequest)
    case getvehicles(size: Int,from: Int)
    case postinsurance(insuranceRequest: InsuranceRequest)
    case putinsurance(id: Int,insuranceRequest: InsuranceRequest)
    case getinsurances(size: Int,from: Int)
    
    case getcards(size: Int,from: Int)
    case postcard(createCardQuery: CreateCardQuery)
    case putcard(id:Int,createCardQuery: CreateCardQuery)
    case delcard(id:Int)
    case putmyprofile(updateProfileQuery: UpdateProfileQuery)
    case getuserprofile
    case getconnectaccount(size: Int,from: Int)
    case postconnectaccount(createConnectAccountQuery: CreateConnectAccountQuery)
    case cardsetups
    case simpleprofile(email: String)
    case otprequest(otpRequest: OtpRequest)
    case resendotprequest(resendOtpRequest: ResendOtpRequest)
    case otpverificationrequest(otpVerificationRequest: OtpVerificationRequest)
    case forgotpassword(updatePasswordRequest: UpdatePasswordRequest)
    case bookdeal(id: Int,bookDealQuery: BookDealQuery)
    case multibookdeal(id: Int,mulBookDealQuery: [BookDealQuery])
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .otprequest,.login, .createdeal,.refreshtoken, .createaddress, .postskill, .postlicense, .postvehicle, .postinsurance, .postcard,.postconnectaccount,.cardsetups,.resendotprequest,.otpverificationrequest,.forgotpassword,.bookdeal,.multibookdeal:
            return .post
        case .deals, .dealdetail, .addresss, .getlicensess, .getskills, .getvehicles, .getinsurances,.getcards,.getconnectaccount,.getuserprofile, .simpleprofile:
            return .get
        case .putskill, .putlicense, .putvehicle, .putinsurance, .putaddress,.putcard,.putmyprofile:
            return .put
        case .delcard:
            return .delete
        }
        
        
    }
    /*
    private var encoder: ParameterEncoder{
        switch self {
        case .login:
            return JSONParameterEncoder.default
        case .deals, .dealdetail, .addresss:
            return URLEncodedFormParameterEncoder.default
        }
    }*/
    private var contentType: String {
        switch self {
        case .login,.refreshtoken,.simpleprofile:
                return "application/x-www-form-urlencoded"
        case .deals, .dealdetail, .addresss, .createdeal, .createaddress, .getlicensess, .getskills, .getvehicles, .getinsurances, .postskill, .postlicense, .postvehicle, .postinsurance, .putskill, .putlicense, .putvehicle, .putinsurance, .putaddress,.postcard,.postconnectaccount,.getcards,.getconnectaccount,.putcard,.delcard,.cardsetups,.putmyprofile,.getuserprofile,.otprequest,.resendotprequest,.otpverificationrequest,.forgotpassword,.bookdeal,.multibookdeal:
                return "application/json"
        }
    }
    private var path: String {
        switch self {
        case .login:
            return "/v1.0/user/oauth/token"
        case .refreshtoken:
            return "/v1.0/user/oauth/token"
        case .addresss:
            return "/user/v1.0/users/address"
        case .deals:
            return "/search/deals"
        case .dealdetail(let id):
            return "/deal/v1.0/deals/\(id)"
        case .createdeal:
            return "/deal/v1.0/deals"
        case .createaddress:
            return "/user/v1.0/users/address"
        case .getuserprofile:
            return "/user/v1.0/users/profiles"
        case .getlicensess, .postlicense:
            return "/user/v1.0/users/licenses"
        case .getskills, .postskill:
            return "/user/v1.0/users/skills"
        case .getvehicles, .postvehicle:
            return "/user/v1.0/users/vehicles"
        case .getinsurances, .postinsurance:
            return "/user/v1.0/users/insurances"
        case .putlicense(let id, _):
            return "/user/v1.0/users/licenses/\(id)"
        case .putskill(let id, _):
            return "/user/v1.0/users/skills/\(id)"
        case .putvehicle(let id, _):
            return "/user/v1.0/users/vehicles/\(id)"
        case .putinsurance(let id, _):
            return "/user/v1.0/users/insurances/\(id)"
        case .putaddress(let id, _):
            return "/user/v1.0/users/address/\(id)"
        case .putmyprofile:
            return "/user/v1.0/users/profiles/buyers"
        case .getcards,.postcard:
            return "/payment/v1.0/cards"
        case .putcard(let id,_):
           return "/payment/v1.0/cards/\(id)/defaults"
        case .delcard(let id):
            return "/payment/v1.0/cards/\(id)"
        case .getconnectaccount,.postconnectaccount:
            return "/payment/v1.0/connect-accounts"
        case .cardsetups:
            return "/payment/v1.0/card-setups"
        case .simpleprofile:
            return "/user/v1.0/users/simple-profiles"
        case .otprequest:
            return "/otp-management/v1.0/otp"
        case .resendotprequest:
            return "/otp-management/v1.0/otp/regeneration"
        case .otpverificationrequest:
            return "/otp-management/v1.0/otp/verification"
            /*
            case getcards(size: Int,from: Int)
            case postcard(createCardQuery: CreateCardQuery)
            case putcard(id:Int,createCardQuery: CreateCardQuery)
            case delcard(id:Int)
            
            case getconnectaccount(size: Int,from: Int)
            case postconnectaccount(createConnectAccountQuery: CreateConnectAccountQuery)*/
        case .forgotpassword:
            return "/user/v1.0/users/identities/passwords"
        case .bookdeal(let id,_):
            return "/deal/v1.0/deals/\(id)/books"
        case .multibookdeal(let id,_):
            return "/deal/v1.0/deals/\(id)/books-multi"
        }
    }
    
    // MARK: - Parameters
    /*private var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return ["grant_type": "password", "username": username,"password": password,"client_id": "client_id_id_client"]
        case .addresss(let size, let from):
            return ["size":size,"from":from]
        case .deals(let size,let from, let cat, let q, let northeast, let southwest, let latlng):
            return ["size":size,"from":from,"cat":cat,"q":q,"northeast":northeast,"southwest":southwest,"latlng":latlng]
        case .dealdetail(let id):
            return ["id":id]
        }
    }*/
    //urlRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
    func asURLRequest() throws -> URLRequest {
        //let requestModifier: RequestModifier?
        let url = try K.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue("Content-Type", forHTTPHeaderField: contentType)
        //urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: contentType)
        //urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Parameters
        
            //=
        //JSONParameterEncoder.default
        /*if let parameters = parameters {
            do {
                try encoder.encode(, into: urlRequest)
                //parameters.map {  encoder.encode($0, into: urlRequest) }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }*/
        /*if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }*/
        //try requestModifier?(&urlRequest)
        switch self {
        case .simpleprofile(let email):
            urlRequest = try URLEncodedFormParameterEncoder.default.encode(["email": email], into: urlRequest)
            //urlRequest = try URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(spaceEncoding: .plusReplaced)).encode(["email":email], into: urlRequest)
        case .addresss(let size, let from), .getskills(let size, let from), .getvehicles(let size, let from), .getlicensess(let size, let from), .getinsurances(let size, let from), .getcards(size: let size, from: let from), .getconnectaccount(size: let size, from: let from):
            urlRequest = try URLEncodedFormParameterEncoder().encode(["size":size,"from":from], into: urlRequest)
        case .deals(let size,let from, let cat, let q, let northeast, let southwest, let latlng):
            urlRequest = try URLEncodedFormParameterEncoder.default.encode(DealQuery(size: size,from: from,cat: cat,q: q,northeast: northeast,southwest: southwest,latlng: latlng), into: urlRequest)
        case .dealdetail(let  id):
            urlRequest = try URLEncodedFormParameterEncoder().encode(["id":id], into: urlRequest)
        case .login(let username, let password):
            urlRequest = try URLEncodedFormParameterEncoder.default.encode(["grant_type": "password", "username": username,"password": password,"client_id": "client_id_id_client"], into: urlRequest)
        case .refreshtoken(let refreshToken):
            urlRequest = try URLEncodedFormParameterEncoder.default.encode(["grant_type": "refresh_token", "refresh_token": refreshToken,"client_id": "client_id_id_client"], into: urlRequest)
        case .createdeal(let createDealQuery):
            urlRequest = try JSONParameterEncoder.default.encode(createDealQuery, into: urlRequest)
        case .createaddress(let createAddressQuery):
            urlRequest = try JSONParameterEncoder.default.encode(createAddressQuery, into: urlRequest)
        case .putaddress(_, let createAddressQuery):
            urlRequest = try JSONParameterEncoder.default.encode(createAddressQuery, into: urlRequest)
        case .postlicense(let licenseRequest):
            urlRequest = try JSONParameterEncoder.default.encode(licenseRequest, into: urlRequest)
        case .putlicense(_, let licenseRequest):
            urlRequest = try JSONParameterEncoder.default.encode(licenseRequest, into: urlRequest)
        case .postskill(let skillRequest):
            urlRequest = try JSONParameterEncoder.default.encode(skillRequest, into: urlRequest)
        case .putskill(_, let skillRequest):
            urlRequest = try JSONParameterEncoder.default.encode(skillRequest, into: urlRequest)
        case .postvehicle(let vehicleRequest):
            urlRequest = try JSONParameterEncoder.default.encode(vehicleRequest, into: urlRequest)
        case .putvehicle(_, let vehicleRequest):
            urlRequest = try JSONParameterEncoder.default.encode(vehicleRequest, into: urlRequest)
        case .postinsurance(let insuranceRequest):
            urlRequest = try JSONParameterEncoder.default.encode(insuranceRequest, into: urlRequest)
        case .putinsurance(_, let insuranceRequest):
            urlRequest = try JSONParameterEncoder.default.encode(insuranceRequest, into: urlRequest)
        case .putmyprofile(let putMyprofileRequest):
            urlRequest = try JSONParameterEncoder.default.encode(putMyprofileRequest, into: urlRequest)
        case .postcard(let createCardQuery):
            urlRequest = try JSONParameterEncoder.default.encode(createCardQuery, into: urlRequest)
        case .putcard(_, let createCardQuery):
            urlRequest = try JSONParameterEncoder.default.encode(createCardQuery, into: urlRequest)
        case .delcard(id: _): break
        case .getuserprofile: break
        case .postconnectaccount(let createConnectAccountQuery):
            urlRequest = try JSONParameterEncoder.default.encode(createConnectAccountQuery, into: urlRequest)
        case .cardsetups:break
        case .otprequest(let otpRequest):
            urlRequest = try JSONParameterEncoder.default.encode(otpRequest, into: urlRequest)
        case .resendotprequest(let resendOtpRequest):
            urlRequest = try JSONParameterEncoder.default.encode(resendOtpRequest, into: urlRequest)
        case .otpverificationrequest(let otpVerificationRequest):
            urlRequest = try JSONParameterEncoder.default.encode(otpVerificationRequest, into: urlRequest)
        case .forgotpassword(let updatePasswordRequest):
            urlRequest = try JSONParameterEncoder.default.encode(updatePasswordRequest, into: urlRequest)
        case .bookdeal(_,let bookDealQuery):
            urlRequest = try JSONParameterEncoder.default.encode(bookDealQuery, into: urlRequest)
        case .multibookdeal(_,let mulBookDealQuery):
            urlRequest = try JSONParameterEncoder.default.encode(mulBookDealQuery, into: urlRequest)
        }
        debugPrint("------------URL_REQUEST----------",urlRequest)
        return urlRequest
        
        }
}

