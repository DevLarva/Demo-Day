//
//  RegisterData.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/12.
//

import Foundation

// MARK: - 회원가입시 보내는 모델
/// - note : 대학교 인증하지 않고 회원가입 할 때
struct RegisterRequest: Codable {
    
    var name: String
    var nickname: String
    var isEmailAuth: Int
    var campersId: String
    var agreement: String
    
    /// - note : 이메일 회원가입 여부
    var email: String?
    var password: String?
    
    /// - note :  대학교 인증 여부
    var universityEmail: String?
    
    /// - note :  소셜 로그인 여부
    var registerAccessToken: String?
    
    init() {
        self.name = ""
        self.nickname =  ""
        self.isEmailAuth = 0
        self.campersId = ""
        self.agreement = ""
        
        self.email = nil
        self.password = nil
        
        self.universityEmail = nil
        
        self.registerAccessToken = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nickname = "nickname"
        case isEmailAuth = "isEmailAuth"
        case campersId = "campersId"
        case agreement = "agreement"
        case email = "email"
        case password = "password"
        case universityEmail = "university_email"
        case registerAccessToken = "registerAccessToken"
    }
}

/// 대학교 인증하고 회원가입 할 때
//let registrationWithUniversity = RegisterRequest(
//    email: "test@gmail.com", name: "테스터1", nickname: "tester1",
//    isEmailAuth: true, password: "lee2371765",
//    universityEmail: "lee237@mail.ulsan.ac.kr", campersId: "12", agreement: true)
//
///// 대학교 인증하지 않고 회원가입 할 때
//let registrationWithoutUniversity = RegisterRequest(
//    email: "test1@nate.com", name: "테스트2", nickname: "tester2",
//    isEmailAuth: false, password: "lee2371765",
//    universityEmail: nil, campersId: nil, agreement: nil)
