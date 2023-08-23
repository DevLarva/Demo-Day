//
//  LoginView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/17.
//

import SwiftUI

struct EmailLoginView: View {
    @StateObject private var authVM = AuthVM()
    @Binding var isLogged: Bool?
    
    @State var Email = ""
    @State var Password = ""
    @State var isSecureMode: Bool = true
    @State var isActive: Bool = false
    var body: some View {
        VStack {
            VStack(alignment: .leading,spacing: 10) {
                Text("믿을만한\n대학주변\n맛집리스트")
                    .frame(width: 140,height: 126)
                    .font(
                    Font.custom("Pretendard", size: 32)
                    .weight(.semibold)
                    )
                    .foregroundColor(.GrayScale900)
                
                Spacer().frame(height: 20)
                
                Text("대학생들의 ")
                    .font(Font.custom("Pretendard", size: 18))
                    .foregroundColor(.GrayScale600)
                + Text("찐 후기")
                    .font(Font.custom("Pretendard", size: 18))
                    .foregroundColor(Color.PrimaryOrange300)
                + Text("를 모아보세요")
                    .font(Font.custom("Pretendard", size: 18))
                    .foregroundColor(.GrayScale600)
                
                Spacer().frame(height: 25)
                
                VStack(alignment: .leading,spacing: 20) {
                    Text("이메일")
                        .foregroundColor(.GrayScale500)
                    
                    TextField("이메일을 입력하세요", text: $Email)
                        .padding(.bottom,0)
                        .foregroundColor(.GrayScale400)
                        .textInputAutocapitalization(.never)
                    Divider()
                    
                    Text("비밀번호")
                        .foregroundColor(.GrayScale500)
                    HStack {
                        if isSecureMode {
                            SecureField("비밀번호를 입력해주세요.", text: $Password)
                                .foregroundColor(.GrayScale800)
                                .textFieldStyle(.plain)
                                
                        } else {
                            TextField("비밀번호를 입력해주세요.", text: $Password).textFieldStyle(.plain)
                                .foregroundColor(.GrayScale800)
                                
//                                .textInputAutocapitalization(.never)
                        }
                        Button {
                            isSecureMode.toggle()
                        } label: {
                            Image(isSecureMode ? "eye-off" : "eye").frame(width: 20, height: 20)
                        }
                    }
                    Divider()
                    
                    
                }
            }
            Spacer().frame(height: 32)
            
            VStack(alignment: .leading,spacing: 10) {
                
                HStack(alignment: .center, spacing: 2) {
                    CustomNavLink(destination: ContentView(isLogged: $isLogged)
                        .customNavigationTitle("")
                        , isActive: $isActive) {
                        Button(action: {
                            authVM.login(email: Email, password: Password)
                            authVM.loginError.sink { errMsg in /// 오류 시
                            }
                            .store(in: &authVM.subscription)
                            authVM.loginSuccess.sink { /// 성공 시
                                isLogged = true
//                                isActive = true
                            }
                            .store(in: &authVM.subscription)
                        }) {
                            Text("로그인")
                                .font(
                                    Font.custom("Pretendard", size: 16)
                                        .weight(.medium)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 0)
                .frame(width: 343, height: 56, alignment: .center)
                .background(Color.PrimaryOrange300)
                .cornerRadius(8)
                 
                Spacer().frame(height: 180)
            }
        }
        .padding(.all) 
    }
}
    

struct EmailLoginView_Previews: PreviewProvider {
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        EmailLoginView(isLogged: $isLoggedTest)
    }
}


//로그인 버튼 양옆으로 늘려라
