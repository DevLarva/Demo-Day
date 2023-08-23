//
//  UserDefaultManager.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/13.
//

import Foundation

/// 차후 키체인을 변경
class UserDefaultsManager {
    enum Key: String, CaseIterable{
        case refreshToken, accessToken
    }
    
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    
    // 저장된 모든 데이터 지우기
    func clearAll(){
        print("UserDefaultsManager - clearAll() called")
        Key.allCases.forEach{ UserDefaults.standard.removeObject(forKey: $0.rawValue) }
    }
    
    // 토큰들 저장
    func setTokens(accessToken: String, refreshToken: String, social: Bool){
        print("UserDefaultsManager - setTokens() called")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.set(social, forKey: "social")
        UserDefaults.standard.synchronize()
    }
    
    // refresh
    func refreshTokens(accessToken: String, refreshToken: String){
        print("UserDefaultsManager - refreshTokens() called")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    // 토큰들 가져오기
    func getTokens()->TokenData{
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue) ?? ""
        return TokenData(accessToken: accessToken, refreshToken: refreshToken)
    }
}
