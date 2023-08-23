//
//  SocialResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/15.
//

import Foundation

struct SocialResponse: Codable {
    let result: SocialToken
}

struct SocialToken: Codable {
    let registerAccessToken: String?
    let accessToken: String?
    let refreshToken: String?
}
