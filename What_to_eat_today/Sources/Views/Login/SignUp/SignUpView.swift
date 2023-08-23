//
//  SignUpView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/13.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import AuthenticationServices

struct SignUpView: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    @Binding var isLogged: Bool?
    
    @State private var isAppleSignInCompleted: Bool = false
    @State private var shouldNavigate: Bool = false
    @State private var showMainView = false  //스플래쉬 화면
    
    @State var showAlreadyAlert: Bool? = false  /// 이미 가입된 계정인 경우
    @State var showErrorAlert = false    /// 소셜 로그인 실패
    @State private var isActive: Bool = false
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading,spacing: 16) {
                    
                        Text("오늘 뭐먹지에\n오신 것을\n환영합니다:)")
                            .multilineTextAlignment(.leading)
                            .font(
                                Font.custom("Pretendard", size: 32)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.GrayScale900)
                        
                        Text("간편한 소셜로 회원가입 하세요!")
                            .font(Font.custom("Pretendard", size: 18))
                            .foregroundColor(.GrayScale600)
                    
                    Spacer().frame(height: 299)
                    VStack(alignment: .leading,spacing: 8) {
                        /// 카카오 소셜 로그인
                        CustomNavLink(destination: EmailCetificationView(registerData: $registerData, isLogged: $isLogged)
                            .customNavigationTitle("")
                            ,isActive: $isActive
                        ) {
                            Button {
                                if (UserApi.isKakaoTalkLoginAvailable()) {
                                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                                        if let token = oauthToken?.accessToken {
                                            authVM.kakaoLogin(kakaoAccessToken: token)
                                        }
                                        else {
                                            showErrorAlert = true
                                        }
                                    }
                                } else {
                                    UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                        if let token = oauthToken?.accessToken {
                                            authVM.kakaoLogin(kakaoAccessToken: token)
                                        }
                                        else {
                                            showErrorAlert = true
                                        }
                                    }
                                }
                                
                            } label : {
                                Image("signup-kakao")
                                    .resizable()
                                    .frame(width: 343,height: 48)
                            }
                        }
                        
                        /// 애플 소셜 로그인
                        AppleSigninButton(registerData: $registerData, isSingUp: $isActive, isLogin: $showAlreadyAlert, isError: $showErrorAlert)
                    }.padding(.bottom, 28)
                    
                    
                }
                VStack(alignment: .center,spacing: 8) {
                    CustomNavLinkForThr(destination: SignupEmail(registerData: $registerData, isLogged: $isLogged)
                        .customNavigationTitle("") , curNum: 1, finNum: 5
                    ) {
                        Text("이메일로 회원가입")
                            .font(Font.custom("Pretendard", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.GrayScale500)
                    }
                    
                }
            }
            if showErrorAlert {
                CustomAlertView(showalert: $showErrorAlert, alertMessage: "소셜 로그인을 실패하였습니다.")
            }
            if showAlreadyAlert ?? false {
                CustomAlertBoolView(showalert: $showAlreadyAlert, alertMessage: "이미 소셜 로그인 계정이 존재합니다.")
            }
        }
        .onAppear {
            /// 오류 시
            authVM.loginError.sink { errMsg in
                isActive = false
                showErrorAlert = true
                showAlreadyAlert = false
            }
            .store(in: &authVM.subscription)
            
            /// 이미 계정이 있을 경우
            authVM.loginSuccess.sink {
                isActive = false
                showErrorAlert = false
                showAlreadyAlert = true
            }
            .store(in: &authVM.subscription)
            
            /// 소셜토큰 값 받아온 경우
            authVM.registerTokenUpdated .sink { registerToken in
                registerData.registerAccessToken = registerToken
                print("데이터 : \(registerData)")
                isActive = true
                isLogged = false
                showErrorAlert = false
                showAlreadyAlert = false
            }
            .store(in: &authVM.subscription)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        SignUpView(registerData: $test, isLogged: $isLoggedTest)
    }
}
