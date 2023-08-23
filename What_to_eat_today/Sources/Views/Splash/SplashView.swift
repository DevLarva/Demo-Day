//
//  SplashView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/10.
//

import SwiftUI

struct SplashView: View {
//    @Binding var isLogged: Bool
    
    let splashImageNames = ["splashfirst", "splashsec", "splashthr", "splashfour", "spalshfive"]
    var randomSplashImage: String {
        
        let randomIndex = Int.random(in: 0..<splashImageNames.count)
        return splashImageNames[randomIndex]
    }
    var body: some View {
        ZStack(alignment: .leading) {
            Image(randomSplashImage)
                .resizable()
            VStack(alignment: .leading) {
                
                Text("든든한 밥\n먹고 공부해요")
                    .font(Font.custom("Pretendard", size: 30))
                    .foregroundColor(.white.opacity(0.66))
                
                Text("밥먹공")
                    .font(Font.custom("Pretendard", size: 30)).bold()
                    .foregroundColor(.white.opacity(0.66))
                
                Spacer().frame(height: 500)
            }.padding()
                .zIndex(1)
        }
        .ignoresSafeArea(.all)
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                withAnimation {
//                    jwtTokenCheck { isLoggedResult in
//                        isLogged = false
//                    }
//                }
//            }
//        }
        
    }
    
//    func jwtTokenCheck(completion: @escaping (Bool) -> Void) {
//        let userDefaults = UserDefaults.standard
//        let accessToken = userDefaults.string(forKey: "accessToken")
//        let refreshToken = userDefaults.string(forKey: "refreshToken")
//        
//        if let _ = accessToken, let _ = refreshToken {
//            completion(true)
//        } else {
//            completion(false)
//        }
//    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
