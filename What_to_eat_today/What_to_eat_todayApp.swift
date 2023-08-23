//
//  What_to_eat_todayApp.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/13.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct What_to_eat_todayApp: App {
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey:"a3b718e3e05617351ccc7f7d3a518254")
        
    }
    var body: some Scene {
        WindowGroup {
                AppView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}


