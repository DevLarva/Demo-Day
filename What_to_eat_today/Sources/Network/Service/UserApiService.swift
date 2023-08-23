//
//  UserApiService.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/20.
//

import Foundation
import Alamofire
import Combine

enum UserApiService {
    static func userInfo() -> AnyPublisher<UserInfoResponse, Error> {
        print("UserApiService - userInfo() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.userInfo, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: UserInfoResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    static func userDetail() -> AnyPublisher<UserDetailInfoResponse, Error> {
        print("UserApiService - userDetail() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.userDetail, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: UserDetailInfoResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    static func nickNameChange(nickname: String) -> AnyPublisher<Bool, Error> {
        print("UserApiService - nickNameChange() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.nickNameChange(nickname: nickname), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 204:
                    return true
                case 401:
                    throw NSError(domain: "로그인을 진행해주세요.(Access 토큰 만료)", code: 401, userInfo: nil)
                case 404:
                    throw NSError(domain: "사용자를 찾을 수 없습니다.”", code: 404, userInfo: nil)
                case 405:
                    throw NSError(domain: "중복된 닉네임입니다.", code: 405, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func emailChange(email: String) -> AnyPublisher<Bool, Error> {
        print("UserApiService - emailChange() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.emailChange(email: email), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 204:
                    return true
                case 401:
                    throw NSError(domain: "로그인을 진행해주세요.(Access 토큰 만료)", code: 401, userInfo: nil)
                case 404:
                    throw NSError(domain: "사용자를 찾을 수 없습니다.”", code: 404, userInfo: nil)
                case 405:
                    throw NSError(domain: "중복된 이메일입니다.", code: 405, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func passwordChange(oldPassword: String, newPassword: String) -> AnyPublisher<Bool, Error> {
        print("UserApiService - passwordChange() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.passwordChange(oldPassword: oldPassword, newPassword: newPassword), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 204:
                    return true
                case 400:
                    throw NSError(domain: "기존의 비밀번호와 일치하지 않습니다.", code: 401, userInfo: nil)
                case 401:
                    throw NSError(domain: "로그인을 진행해주세요.(Access 토큰 만료)", code: 401, userInfo: nil)
                case 404:
                    throw NSError(domain: "사용자를 찾을 수 없습니다.”", code: 404, userInfo: nil)
                case 405:
                    throw NSError(domain: "중복된 이메일입니다.", code: 405, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func marketing(isAgree: String) -> AnyPublisher<Bool, Error> {
        print("UserApiService - marketing() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.marketing(isAgree: isAgree), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 204:
                    return true
                case 401:
                    throw NSError(domain: "로그인을 진행해주세요.(Access 토큰 만료)", code: 401, userInfo: nil)
                case 402:
                    throw NSError(domain: "입력 형식이 올바르지 않습니다.", code: 402, userInfo: nil)
                case 404:
                    throw NSError(domain: "사용자를 찾을 수 없습니다.”", code: 404, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
}

//    case userInfo
//    case userDetail
//    case nickNameChange(nickname: String)
//    case emailChange(email: String)
//    case passwordChange(oldPassword: String, newPassword: String)
//    case profileImageChange(image: UIImage)
//    case allInquery(wating: String) ///쿼리 파라미터
//    case inqueryDetail(id: String) ///쿼리 파라미터
//    case inqueryWrite(dto: InquiryResponse, images: UIImage?)///form-data
//    case inqueryResponse(id: String, content: String)///id는 쿼리 파라미터
//    case notice(type: String)///쿼리 파라미터
//    case fAQ(type: String)///쿼리 파라미터
//    case terms(type: String)///쿼리 파라미터
//    case marketing(type: String)
