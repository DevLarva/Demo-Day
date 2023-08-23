//
//  ApiClient.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/10.
//

import Foundation
import Alamofire

// MARK: - api 호출 클라이언트
/// ApiClient.shared.session() <= 사용방식
final class ApiClient {
    
    /// 싱글톤
    static let shared = ApiClient()
    
    /// 베이스 URL
    static let BASE_URL = "https://junhyeokpark.shop/api/v1"
    
    /// 인터셉터 선언
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor() // application/json
    ])
    
    /// Logger 선언
    let monitors = [ApiLogger()] as [EventMonitor]
    
    /// 세션 선언
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}


