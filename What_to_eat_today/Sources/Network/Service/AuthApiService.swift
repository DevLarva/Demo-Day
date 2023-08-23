//
//  AuthApiService.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/10.
//

import Foundation
import Alamofire
import Combine

enum AuthApiService {
    
    /// (학교)이메일 전송 [POST]
    static func emailSend(email: String) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - emailSend() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.emailSend(email: email))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                case 400:
                    throw NSError(domain: "이미 가입되어 있는 이메일입니다.", code: 400, userInfo: nil)
                case 404:
                    throw NSError(domain: "학교 이메일 형식이 아닙니다.", code: 404, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    /// 이메일 유효성 검사[POST]
    static func emailValidate(email: String) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - emailValidate() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.emailValidate(email: email))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                case 400:
                    throw NSError(domain: "이미 가입되어 있는 이메일입니다.", code: 400, userInfo: nil)
                case 408:
                    throw NSError(domain: "학교 이메일 형식이 아닙니다.", code: 404, userInfo: nil)
                case 409:
                    throw NSError(domain: "이메일을 입력해주세요.", code: 409, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// 닉네임 유효성 검사[POST]
    static func nickNameValidate(nickname: String) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - nickNameValidate() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.nickNameValidate(nickname: nickname))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 닉네임 검증을 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                case 400:
                    throw NSError(domain: "이미 존재하는 닉네임입니다.", code: 400, userInfo: nil)
                case 409:
                    throw NSError(domain: "닉네임을 입력해 주세요.", code: 409, userInfo: nil)
                case 410:
                    throw NSError(domain: "특수문자는 사용 불가능 합니다.", code: 410, userInfo: nil)
                case 411:
                    throw NSError(domain: "닉네임의 길이는 최대 8자 입니다.", code: 411, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// 이메일 인증 (로그인 상태일 때) [POST]
    static func emailAuthLogin(email: String, authNum: String) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - emailAuthLogin() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.emailAuthLogin(email: email, authNum: authNum))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                case 404:
                    throw NSError(domain: "인증번호가 일치하지 않습니다.", code: 404, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// 이메일 인증 (회원가입 할 때) [POST]
    static func emailAuthRegister(email: String, authNum: String) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - emailAuthLogin() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.emailAuthLogin(email: email, authNum: authNum))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 201:/// 201이 회원가입때 학교 이메일 인증 성공
                    return true
                case 404:
                    throw NSError(domain: "인증번호가 일치하지 않습니다.", code: 404, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// 회원가입 [POST] (Form-Data)
    static func register(dto: RegisterRequest, image: UIImage? = nil) -> AnyPublisher<RegisterResponse, Error> {
        print("AuthApiService - register() called")
        
        return Future { promise in
            AF.upload(multipartFormData: { multipartFormData in
                let jsonData = try? JSONEncoder().encode(dto)
                /// 옵셔널 풀기
                if let data = jsonData {
                    multipartFormData.append(data, withName: "dto")
                }
                if let email = dto.email {
                    multipartFormData.append(email.data(using: .utf8)!, withName: "email")
                }
                if let password = dto.password {
                    multipartFormData.append(password.data(using: .utf8)!, withName: "password")
                }
                if let universityEmail = dto.universityEmail {
                    multipartFormData.append(universityEmail.data(using: .utf8)!, withName: "university_email")
                }
                if let registerAccessToken = dto.registerAccessToken {
                    multipartFormData.append(registerAccessToken.data(using: .utf8)!, withName: "registerAccessToken")
                }
                if let image = image, let imageData = image.jpegData(compressionQuality: 1) {
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }, with: AuthRouter.register(dto: dto, image: image)).responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(let registerResponse):
                    print("RegisterResponse: \(registerResponse)")
                    /// 로그인 성공시 토큰 값 userdefault에 저장
                    //                    UserDefaultsManager.shared.setTokens(accessToken: registerResponse.accessToken, refreshToken: registerResponse.refreshToken)
                    promise(.success(registerResponse))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// 로그인 [POST]
    static func Login(email: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        return ApiClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: LoginResponse.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    /// 카카오 로그인 [POST]
    static func kakaoLogin(kakaoAccessToken: String) -> AnyPublisher<SocialResponse, Error> {
        return ApiClient.shared.session
            .request(AuthRouter.kakaoLogin(kakaoAccessToken: kakaoAccessToken))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: SocialResponse.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    /// 애플 로그인 [POST]
    static func appleLogin(code: String, idToken: String) -> AnyPublisher<SocialResponse, Error> {
        return ApiClient.shared.session
            .request(AuthRouter.appleLogin(code: code, idToken: idToken))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: SocialResponse.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    /// 로그아웃 [POST]
    static func logout() -> AnyPublisher<Bool, Error> {
        print("AuthApiService - logout() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        /// 인증  interceptor
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(AuthRouter.logout, interceptor: authInterceptor)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 처리하지 못했습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                default:
                    throw NSError(domain: "서버의 오류로 처리하지 못했습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// 회원탈퇴 [POST]
    static func deleteUser() -> AnyPublisher<Bool, Error> {
        print("AuthApiService - deleteUser() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        /// 인증  interceptor
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(AuthRouter.deleteUser, interceptor: authInterceptor)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 처리하지 못했습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                default:
                    throw NSError(domain: "서버의 오류로 처리하지 못했습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// 비밀번호 초기화 [POST]
    static func passwordReset(email: String) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - passwordReset() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.passwordReset(email: email))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                case 404:
                    throw NSError(domain: "해당 사용자를 찾을 수 없습니다.", code: 404, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 이메일 전송에 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// 대학교 검색 [GET]
    static func searchUniversity(keyword: String) -> AnyPublisher<[University], Error> {
        print("AuthApiService - searchUniversity() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.searchUniversity(keyword: keyword))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: [University].self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
}
