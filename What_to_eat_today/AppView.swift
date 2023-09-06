//
//  AppView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/19.
//

import SwiftUI
import Combine

struct AppView: View {
    @StateObject private var userVM = UserVM()
    
    @State private var isLogged: Bool? = nil
    @State private var currentView: AnyView = AnyView(EmptyView())
    
    var body: some View {
        currentView
            .onChange(of: isLogged) { _ in
                currentView = (isLogged ?? true) ? AnyView(ContentView(isLogged: $isLogged)) : AnyView(LoginView(isLogged: $isLogged))
            }
            .onAppear {
                currentView = AnyView(SplashView())
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.jwtTokenCheck { isLoggedResult in
                            self.isLogged = isLoggedResult
                            if isLogged ?? false {
                                userVM.userInfo()
                                userVM.infoSuccess .sink{ _ in
                                    UserDefaults.standard.set(userVM.userInfoData.campers?.university.name, forKey: UniversityName.universityName.rawValue)
                                    UserDefaults.standard.set(userVM.userInfoData.nickname, forKey: UserNickname.userNickname.rawValue)
                                }.store(in: &userVM.subscription)
                            }
                        }
                    }
                }
            }
    }
    
    func jwtTokenCheck(completion: @escaping (Bool) -> Void) {
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        let refreshToken = userDefaults.string(forKey: "refreshToken")
        
        if let _ = accessToken, let _ = refreshToken {
            completion(true)
        } else {
            completion(false)
        }
    }
}



