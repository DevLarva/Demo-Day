//
//  LoginView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/08.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import AuthenticationServices


struct LoginView: View {
    @StateObject private var authVM = AuthVM()
    @State var registerData: RegisterRequest = RegisterRequest.init()
    @Binding var isLogged: Bool?
    
    @State private var showMainView = true  //스플래쉬 화면
//    @State private var isActive: Bool = false
    @State private var isError: Bool = false
    @State private var isNotAccount: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                    
                    VStack {
                        Spacer().frame(height: 68)
                        VStack(alignment: .leading,spacing: 16) {
                            Text("믿을만한\n대학주변\n맛집리스트")
                                .multilineTextAlignment(.leading)
                                .font(
                                    Font.custom("Pretendard", size: 32)
                                        .weight(.semibold)
                                )
                                .foregroundColor(.GrayScale900)
                                .frame(width: 140, height: 126)
                            Text("대학생들의 ")
                                .font(Font.custom("Pretendard", size: 18))
                                .foregroundColor(.GrayScale600)
                            + Text("찐 후기")
                                .font(Font.custom("Pretendard", size: 18))
                                .foregroundColor(.PrimaryOrange300)
                            + Text("를 모아보세요.")
                                .font(Font.custom("Pretendard", size: 18))
                                .foregroundColor(.GrayScale600)
                            
                            Spacer().frame(height: 280)
                            VStack(alignment: .leading,spacing: 8) {

                                    Button {
                                        if (UserApi.isKakaoTalkLoginAvailable()) {
                                            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                                                if let token = oauthToken?.accessToken {
                                                    authVM.kakaoLogin(kakaoAccessToken: token)
                                                }
                                                else {
                                                    isError = true
                                                }
                                            }
                                        } else {
                                            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                                if let token = oauthToken?.accessToken {
                                                    authVM.kakaoLogin(kakaoAccessToken: token)
                                                }
                                                else {
                                                    isError = true
                                                }
                                            }
                                        }
                                    } label : {
                                        Image("login-kakao")
                                            .resizable()
                                            .frame(width: 343,height: 48)
                                    }
//                                }
                                AppleSigninButton(registerData: $registerData, isSingUp: $isNotAccount, isLogin: $isLogged, isError: $isError)
                            }.padding(.bottom, 26)
                            
                        }
                        
                        
                        VStack(alignment: .center,spacing: 8) {
                            HStack(alignment: .center,spacing: 8) {
                                CustomNavLink(destination: SignUpView(registerData: $registerData, isLogged: $isLogged)
                                    .customNavigationTitle("")
                                ) {
                                    Text("회원가입")
                                        .font(Font.custom("Pretendard", size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.GrayScale500)
                                }
                                
                                Image("Vector103")
                                
                                CustomNavLink(destination: ResetPassWordView()
                                    .customNavigationTitle("")
                                ) {
                                    Text("비밀번호 초기화")
                                        .font(Font.custom("Pretendard", size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.GrayScale500)
                                }
                                
                                Image("Vector103")
                                
                                CustomNavLink(destination: EmailLoginView(isLogged: $isLogged)
                                    .customNavigationTitle("")
                                ) {
                                    Text("이메일로 로그인")
                                        .font(Font.custom("Pretendard", size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.GrayScale500)
                                }
                                .navigationBarBackButtonHidden(true)
                            }.padding(.bottom,50)
                                .navigationBarHidden(true)
                        }
                    
                }
                if isError {
                    CustomAlertView(showalert: $isError, alertMessage: "소셜 로그인을 실패하였습니다.")
                        
                }
                if isNotAccount {
                    CustomAlertView(showalert: $isNotAccount, alertMessage: "계정이 존재하지 않습니다.\n회원가입을 진행해주세요.")
                        
                }
            }
        }
        
        .onAppear {
            /// 오류 시
            authVM.loginError.sink { errMsg in
                isNotAccount = false
//                isActive = false
                isLogged = false
                isError = true
            }
            .store(in: &authVM.subscription)
            
            /// 이미 계정이 있을 경우
            authVM.loginSuccess.sink {
                isNotAccount = false
//                isActive = true
                isLogged = true
                isError = false
            
            }
            .store(in: &authVM.subscription)
            
            /// 소셜토큰 값 받아온 경우
            authVM.registerTokenUpdated .sink { registerToken in
                isNotAccount = true
//                isActive = false
                isLogged = true
                isError = false
            }
            .store(in: &authVM.subscription)
        }
    }
    
}


//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
//
