//
//  AppleSigninButton.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/13.
//

import AuthenticationServices
import SwiftUI
import Foundation

struct AppleSigninButton: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    
    @Binding var isSingUp: Bool
    @Binding var isLogin: Bool?
    @Binding var isError: Bool
    
    var body: some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    if case let appleIDCredential as ASAuthorizationAppleIDCredential = authResults.credential {
                        // 계정 정보 가져오기
                        let userIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        
                        print("UserIdentifier: \(userIdentifier)")
                        print("fullName: \(name)")
                        print("email: \(email ?? "")")
                        print("AuthorizationCode: \(authorizationCode ?? "")")
                        print("IdentityToken: \(identityToken ?? "")")
                        
                        authVM.appleLogin(code: authorizationCode ?? "", idToken: identityToken ?? "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    isError = true
                }
            }
        )
        .frame(width: 343,height: 48)
        .cornerRadius(5)
        .onAppear {
            /// UserDefault 값 있을 경우 바로 이동
            
            
            /// 오류 시
            authVM.loginError.sink { errMsg in
                isError = true
            }
            .store(in: &authVM.subscription)

            /// 성공 시
            authVM.loginSuccess.sink {
                isSingUp = false
                isLogin = true
            }
            .store(in: &authVM.subscription)

            /// register 토큰 값 받아온 경우
            authVM.registerTokenUpdated .sink { registerToken in
                registerData.registerAccessToken = registerToken
                print("데이터 : \(registerData)")
                isSingUp = true
                isLogin = false
            }
            .store(in: &authVM.subscription)

            /// JWTToken 토큰 값 받아온 경우
            authVM.jwtTokenUpdated .sink { jwtToken in
                /// 토큰 저장 로직
                isSingUp = false
                isLogin = true
            }
            .store(in: &authVM.subscription)
        }
    }
}


