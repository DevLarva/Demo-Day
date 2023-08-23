//
//  OAuthCredential.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/10.
//

import Foundation
import Alamofire

struct OAuthCredential : AuthenticationCredential {
    
    let accessToken: String
    
    let refreshToken: String
    
    /// 토큰 만료 시간은 따로 백엔드에서 넘겨 주지 않음.
    let expiration: Date
    
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 14) > expiration }
    
}
