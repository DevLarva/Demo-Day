//
//  UserDetailInfoResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/20.
//

import Foundation

import Foundation

// 최상위 구조체
struct UserDetailInfoResponse: Codable {
    let user: User
    
    struct User: Codable {
        let id: String
        let name: String
        var nickname: String
        let email: String
        let universityEmail: String?
        let imageURL: String?
        let campers: Campers?
        let isEmailAuth: Int
        var agreement: Bool

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case nickname
            case email
            case universityEmail = "university_email"
            case imageURL = "imageURL"
            case campers
            case isEmailAuth = "isEmailAuth"
            case agreement
        }
    }

    // Campers 구조체
    struct Campers: Codable {
        let university: University
        let campers: String
    }

    // University 구조체
    struct University: Codable {
        let name: String
    }
}
