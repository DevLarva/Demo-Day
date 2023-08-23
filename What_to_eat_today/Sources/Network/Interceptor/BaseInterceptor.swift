//
//  BaseInterceptor.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/10.
//

import Foundation
import Alamofire

// MARK: -  HTTP 요청과 응답을 중간에서 가로채서, 요청 및 응답 프로세스에 대한 추가 작업을 수행할 수 있는 컴포넌트
/// 헤더 부분 정보 삽입
class BaseInterceptor: RequestInterceptor {
    
    /// HTTP 헤더에 정보를 추가하는 역할
    ///
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest
        
        // 헤더 부분 넣어주기
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
    }
}
