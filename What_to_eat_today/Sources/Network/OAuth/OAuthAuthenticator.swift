////
////  OAuthAuthenticator.swift
////  What_to_eat_today
////
////  Created by 준호 on 2023/08/10.
////

import Foundation
import Alamofire

class OAuthAuthenticator : Authenticator {
    // MARK: - 헤더에 인증 추가
    /// 인증 정보를 활용하여 요청 인증을 적용하고, 헤더에 액세스 토큰을 포함합니다. 네트워크 요청에 인증 토큰을 추가하는 작업.
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
            // 헤더에 Authrization 키로 Bearer 토큰값
            urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        
            // 만약에 커스텀이면
//            urlRequest.headers.add(name: "ACCESS_TOKEN", value: credential.accessToken)
        }

    // MARK: - 토큰 리프레시
    /// 액세스 토큰이 만료되면 이 메소드를 사용하여 토큰을 리프레시. 서버에 새로운 액세스 토큰을 요청하고, 이를 로컬에 저장하며, 새로 원하는 크리덴셜을 생성하여 호출자에게 반환.
    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        
        print("OAuthAuthenticator - refresh() called")
        // 여기서 토큰 재발행 api 태우면 됩니다.
        
        let request = session.request(AuthRouter.tokenRefresh)
        
        request.responseDecodable(of: JWTToken.self){ result in
            switch result.result {
                
            case .success(let value):
                
                // 재발행 받은 토큰 저장
                UserDefaultsManager.shared.refreshTokens(accessToken: value.accessToken,
                                                     refreshToken: value.refreshToken)
                
                let expiration = Date(timeIntervalSinceNow: 60 * 120)
                
                // 새로운 크리덴셜
                let newCredential = OAuthCredential(accessToken: value.accessToken,
                                                    refreshToken: value.refreshToken,
                                                    expiration: expiration)
                completion(.success(newCredential))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }

    // MARK: - api 요청 완료후 호출
    /// 만약 요청이 401 (Unauthorized) 상태 코드로 실패한 경우, 애플리케이션은 리프레시 토큰을 사용하여 액세스 토큰을 재발급받아야 한다는 신호로 간주
    /// 추가 네트워크 오류 있을 경우 밑에 정리
    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        
        print("OAuthAuthenticator - didRequest() called")
        
        // 401 코드가 떨어지면 리프레시 토큰으로 액세스 토큰을 재발행 하라고 요청
        switch response.statusCode {
            case 401: return true
            default: return false
        }
    }

    // MARK: - 크리덴셜과 함께 인증되었는지 여부를 검사.
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        return true
    }
}
