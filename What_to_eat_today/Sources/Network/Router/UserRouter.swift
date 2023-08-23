//
//  UserRouter.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/10.
//

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible {
    // MARK: - case 분류
    case userInfo
    case userDetail
    case nickNameChange(nickname: String)
    case emailChange(email: String)
    case passwordChange(oldPassword: String, newPassword: String)
    case profileImageChange(image: UIImage)
    case allInquery(wating: String) ///쿼리 파라미터
    case inqueryDetail(id: String) ///쿼리 파라미터
    case inqueryWrite(dto: InquiryResponse, images: UIImage?)///form-data
    case inqueryResponse(id: String, content: String)///id는 쿼리 파라미터
    case notice(type: String)///쿼리 파라미터
    case fAQ(type: String)///쿼리 파라미터
    case terms(type: String)///쿼리 파라미터
    case marketing(isAgree: String)

    // MARK: - BaseURL
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    
    // MARK: - EndPoint
    var endPoint: String {
        switch self {
        case .userInfo:
            return "users"
        case .userDetail:
            return "users/detail"
        case .nickNameChange:
            return "users/nickname"
        case .emailChange:
            return "users/email"
        case .passwordChange:
            return "users/password"
        case .profileImageChange:
            return "users/profile"
        case .allInquery:  //쿼리파라미터
            return "users/inquirys"
        case .inqueryDetail:
            return "users/inquiry/:id"
        case .inqueryWrite:
            return "users/inquiry"
        case .inqueryResponse:
            return "users/inquire/:id"
        case .notice:
            return "users/notice?type=NOTICE"
        case .fAQ:
            return "users/notice?type=FAQ"
        case .terms:
            return "users/notice?type=TERMS"
        case .marketing:
            return "users/agreement"
        default:
            return ""
        }
    }
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .userInfo:
            return .get
        case .userDetail:
            return .get
        case .nickNameChange:
            return .patch
        case .emailChange:
            return .patch
        case .passwordChange:
            return .patch
        case .profileImageChange:
            return .patch
        case .allInquery:
            return .get
        case .inqueryDetail:
            return .get
        case .inqueryWrite:
            return .post
        case .inqueryResponse:
            return.post
        case .notice:
            return .get
        case .fAQ:
            return .get
        case .terms:
            return .get
        case .marketing:
            return .post
        default:
            return .head /// 헤드 리턴.
        }
    }
    // MARK: - Parameters
    var parameters: Parameters{
        switch self {
        case .userInfo:
            var params = Parameters()
            return params
        case .userDetail:
            var params = Parameters()
            return params
        case .nickNameChange(let nickname):
            var params = Parameters()
            params["nickname"] = nickname
            return params
        case .emailChange(let email):
            var params = Parameters()
            params["email"] = email
            return params
        case .passwordChange(let oldPassword, let newPassword):
            var params = Parameters()
            params["oldPassword"] = oldPassword
            params["newPassword"] = newPassword
            return params
        case .profileImageChange(let image):
            var params = Parameters()
            params["image"] = image
            return params
        case .allInquery:
            var params = Parameters()
            return params
        case .inqueryDetail(let id): //파라미터
            var params = Parameters()
            params["id"] = id
            return params
        case .inqueryWrite(let title, let content):
            var params = Parameters()
            params["title"] = title
            params["content"] = content
            return params
        case .inqueryResponse(let content, let inquiryId):
            var params = Parameters()
            params["content"] = content
            params["inquiryId"] = inquiryId
            return params
// MARK: - 여기서 부터 쿼리 파라미터
        case .notice(let type):
            var params = Parameters()
            params["type"] = type
            return params
        case .fAQ(let type):
            var params = Parameters()
            params["type"] = type
            return params
        case .terms(let type):
            var params = Parameters()
            params["type"] = type
            return params
        case .marketing(let isAgree):
            var params = Parameters()
            params["isAgree"] = isAgree
            return params
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
        case .inqueryWrite(let dto, let images):
            request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            request = try! inqueryWriteFormDataStreamer(dto: dto, image: images).encode(request)
            return request
        case .userInfo, .userDetail, .allInquery, .inqueryDetail, .notice, .fAQ, .terms:
            request = try URLEncoding.queryString.encode(request, with: parameters)
            return request
        default:
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
            return request
        }
    }
}


// MARK: - UserRouter
//회원 관련 기능을 포함
//
// - 마이페이지
//내 정보 조회 [GET]
//내 정보 상세조회 [GET]
//닉네임 변경 [PATCH]
//이메일 변경 [PATCH]
//비밀번호 변경 [PATCH]
//프로필 이미지 변경 [PATCH]
//문의내역 전체조회 [GET]
//문의내역 상세조회 [GET]
//문의하기 [POST]
//문의 답변하기 [POST]
//공지사항 [GET]
//FAQ [GET]
//약관 확인 [GET]
//마케팅 수신동의 [POST]

//case userInfo
//case userDetail
//case nickNameChange(nickname: String)
//case emailChange(email: String)
//case passwordChange(oldPassword: String, newPassword: String)
//case profileImageChange(image: UIImage)
//case allInquery(wating: String)
//case inqueryDetail(id: String)
//case inqueryWrite(dto: 문의글json, content: String)
//case inqueryResponse(id: String, content: String)
//case notice
//case fAQ
//case terms
//case agreementCheck(isAgree: Bool)
