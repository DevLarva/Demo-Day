//
//  UserInfoResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/20.
//

import Foundation

struct UserInfoResponse: Codable {
    let user: User
}

struct User: Codable {
    let id: String
    let nickname: String
    let imageURL: String?
    let campers: CampersInfo?
    let isEmailAuth: Int // 0 = 인증 되어 있지 않음, 1 = 인증 되어 있음
}

struct CampersInfo: Codable {
    let university: UniversityInfo
    let campers: String
    
    enum CodingKeys: String, CodingKey {
        case university = "university"
        case campers = "campers"
    }
}

struct UniversityInfo: Codable {
    let name: String
}
