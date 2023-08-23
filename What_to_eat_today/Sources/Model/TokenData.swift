//
//  TokenData.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/11.
//

import Foundation

// MARK: - TokenData
struct TokenData: Codable {
//    let tokenType: String = ""
//    let expiresIn: Int = 0
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
//        case tokenType = "token_type"
//        case expiresIn = "expires_in"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
