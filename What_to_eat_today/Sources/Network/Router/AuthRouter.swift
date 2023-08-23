//
//  AuthRouter.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/10.
//

import Foundation
import Alamofire

// MARK: - AuthRouter
///인증 및 인가와 관련된 기능을 포함
enum AuthRouter: URLRequestConvertible {
    
    // MARK: - case 분류
    /// - note: 회원가입
    ///  (학교)이메일 전송 [POST]
    case emailSend(email: String)
    ///  이메일 유효성 검사[POST]
    case emailValidate(email: String)
    ///  닉네임 유효성 검사[POST]
    case nickNameValidate(nickname: String)
    ///  이메일 인증 (로그인 상태일 때) [POST]
    case emailAuthLogin(email: String, authNum: String)
    ///  이메일 인증 (회원가입 할 때) [POST]
    case emailAuthRegister(email: String, authNum: String)
    ///  회원가입 [POST] (form-data)
    case register(dto: RegisterRequest, image: UIImage?)
    
    /// - note: 로그인
    ///  로그인 [POST]
    case login(email: String, password: String)
    ///  카카오 로그인 [POST](보류)
    case kakaoLogin(kakaoAccessToken: String)
    ///  애플 로그인 [POST](보류)
    case appleLogin(code: String, idToken: String)
    /// 로그아웃 [POST]
    case logout
    /// 회원탈퇴 [POST]
    case deleteUser
    
    /// - note: 비밀번호 및 기타
    ///  비밀번호 초기화 [POST]
    case passwordReset(email: String)
    ///  대학교 검색 [GET]  (쿼리 스트링)(보류)
    case searchUniversity(keyword: String)
    /// 토큰 재발급 [POST]
    case tokenRefresh
    
    // MARK: - BaseURL
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    
    // MARK: - EndPoint
    var endPoint: String {
        switch self {
        case .emailSend:
            return "auth/email"
        case .emailValidate:
            return "auth/email-validate"
        case .nickNameValidate:
            return "auth/nickname-validate"
        case .emailAuthLogin:
            return "auth/email-auth"
        case .emailAuthRegister:
            return "auth/email-auth"
        case .register:
            return "auth/register"
        case .login:
            return "auth/login"
        case .kakaoLogin:
            return "auth/kakao-login"
        case .appleLogin:
            return "auth/apple-login"
        case .logout:
            return "auth/logout"
        case .deleteUser:
            return "auth/delete-user"
        case .passwordReset:
            return "auth/password-reset"
        case .searchUniversity:
            return "auth/searchUniversities"
        case .tokenRefresh:
            return "auth/refresh"
        default:
            return ""
        }
    }
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .emailSend:
            return .post
        case .emailValidate:
            return .post
        case .nickNameValidate:
            return .post
        case .emailAuthLogin:
            return .post
        case .emailAuthRegister:
            return .post
        case .register:
            return .post
        case .login:
            return .post
        case .kakaoLogin:
            return .post
        case .appleLogin:
            return .post
        case .logout:
            return .post
        case .deleteUser:
            return .post
        case .passwordReset:
            return .post
        case .searchUniversity:
            return .get
        case .tokenRefresh:
            return .post
        default:
            return .head
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters{
        switch self {
        case .emailSend(let email):
            var params = Parameters()
            params["university_email"] = email
            return params
        case .emailValidate(let email):
            var params = Parameters()
            params["email"] = email
            return params
        case .nickNameValidate(let nickname):
            var params = Parameters()
            params["nickname"] = nickname
            return params
        case .emailAuthLogin(let email, let authNum):
            var params = Parameters()
            params["university_email"] = email
            params["authNum"] = authNum
            return params
        case .emailAuthRegister(let email, let authNum):
            var params = Parameters()
            params["university_email"] = email
            params["authNum"] = authNum
            return params
        case .register(let dto, let image):
            var params = Parameters()
            params["dto"] = dto
            params["image"] = image
            return params
        case .login(let email, let password):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            return params
        case .kakaoLogin(let kakaoAccessToken):
            var params = Parameters()
            params["kakaoAccessToken"] = kakaoAccessToken
            return params
        case .appleLogin(let code, let idToken):
            var params = Parameters()
            params["code"] = code
            params["id_token"] = idToken
            return params
        case .passwordReset(let email):
            var params = Parameters()
            params["email"] = email
            return params
        case .searchUniversity(let keyword):
            var params = Parameters()
            params["keyword"] = keyword
            return params
        case .tokenRefresh:
            var params = Parameters()
            let tokenData = UserDefaultsManager.shared.getTokens()
            params["accessToken"] = tokenData.accessToken
            params["refreshToken"] = tokenData.refreshToken
            return params
            /// 파라미터 없을 경우
        default:
            var params = Parameters()
            return params
        }
    }
    
    // MARK: - asURLRequest()
    func asURLRequest() throws -> URLRequest {
        /// BaseURL에 EndPoint 추가
        let url = baseURL.appendingPathComponent(endPoint)
        /// 반환해줄 request
        var request = URLRequest(url: url)
        /// method 지정
        request.method = method
        
        switch self {
        case .register(let dto, let image): /// form-data
            request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            request = try! MultipartFormDataStreamer(dto: dto, image: image).encode(request)
            return request
        case .searchUniversity:/// query string
            request = try URLEncoding.queryString.encode(request, with: parameters)
            return request
        default:/// raw
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
            return request
        }
    }
}

/// - 회원가입
///(학교)이메일 전송 [POST]
///이메일 인증 (로그인 상태일 때) [POST]
///이메일 인증 (회원가입 할 때) [POST]
///회원가입 [POST]
///
/// - 로그인
///로그인 [POST]
///애플 로그인 [POST]
///카카오 로그인 [POST]
///로그인 성공 [GET]
///로그아웃 [POST]
///회원탈퇴 [POST]
///
/// - 비밀번호
///비밀번호 초기화 [POST]
///
/// - 기타
///대학교 검색 [GET]
///토큰 재발급 [POST]
