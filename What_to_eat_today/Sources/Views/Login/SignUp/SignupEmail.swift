//
//  SignupEmail.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/13.
//

import SwiftUI

struct SignupEmail: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    @Binding var isLogged: Bool?
    
    @State var SignupEmail = ""
    @State var SignupError = "" //이메일 오류 출력
    @State var isSecureMode: Bool = true //비밀번호 보이게/ 안보이게
    @State var newsecureMode: Bool = true //비밀번호 보이게/ 안보이게
    @State var SignupPassword = ""
    @State var isCorrectPassword = ""
    @State private var isEditing = false
    @State private var showingAlert = false
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,spacing: 32) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("이메일을")
                            .font(
                                Font.custom("Pretendard", size: 24)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.GrayScale800)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Text("입력해 주세요")
                            .font(
                                Font.custom("Pretendard", size: 24)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.GrayScale800)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                    }
                    .frame(width: 343, height: 68, alignment: .topLeading)
                    
                    Text(SignupError)
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.StateError)
                }
                    .frame(width: 343, alignment: .topLeading)
                
                VStack(alignment: .leading,spacing: 20) {
                    Text("이메일")
                        .font(
                        Font.custom("Pretendard", size: 14)
                        .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(.GrayScale500)
                    
                    TextField("이메일을 입력하세요", text: $SignupEmail)
                        .padding(.bottom,0)
                        .foregroundColor(.GrayScale400)
                        .textInputAutocapitalization(.never)
                    Divider()
                    
                    Text("비밀번호")
                        .font(
                        Font.custom("Pretendard", size: 14)
                        .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(.GrayScale500)
                    
                    HStack {
                        if isSecureMode {
                            SecureField("비밀번호를 입력해주세요.", text: $SignupPassword)
                                .foregroundColor(.GrayScale400)
                                .textFieldStyle(.plain)
                        } else {
                            TextField("비밀번호를 입력해주세요.", text: $SignupPassword).textFieldStyle(.plain)
                                .foregroundColor(.GrayScale400)
                                .textInputAutocapitalization(.never)
                        }
                        Button {
                            isSecureMode.toggle()
                        } label: {
                            Image(isSecureMode ? "eye-off" : "eye").frame(width: 20, height: 20)
                        }
                    }
                    
                    Divider()
                    
                    Text("비밀번호 확인")
                        .foregroundColor(.GrayScale500)
                    
                    HStack {
                        if newsecureMode {
                            SecureField("비밀번호를 입력해주세요.", text: $isCorrectPassword)
                                .foregroundColor(.GrayScale400)
                                .textFieldStyle(.plain)
                        } else {
                            TextField("비밀번호를 입력해주세요.", text: $isCorrectPassword).textFieldStyle(.plain)
                                .foregroundColor(.GrayScale400)
                                .textInputAutocapitalization(.never)
                        }
                        Button {
                            newsecureMode.toggle()
                        } label: {
                            Image(newsecureMode ? "eye-off" : "eye").frame(width: 20, height: 20)
                        }
                    }
                    Divider()
                }
                Spacer().frame(height: 100)
                //registerData
                CustomNavLinkForThr(destination: EmailCetificationView(registerData: $registerData, isLogged: $isLogged)
                    .customNavigationTitle("")
                    , isActive: $isActive
                                    , curNum: 2, finNum: 5
                ) {

                        Button("완료") {
                            if (SignupEmail.isEmpty ||
                                SignupPassword.isEmpty ||
                                isCorrectPassword.isEmpty
                            ) {
                                SignupError = "항목이 비어있습니다. "
                            } else if !isValidEmail(SignupEmail) {
                                SignupError = "올바른 이메일을 입력해 주세요"
                                SignupEmail = ""
                            } else if SignupPassword != isCorrectPassword {
                                SignupError = "비밀번호가 일치하지 않습니다. 다시 확인해주세요."
                                isCorrectPassword = ""
                            } else {
                                authVM.emailValidate(email: SignupEmail)
                                authVM.ValidateError.sink { errMsg in /// 오류 시
                                    if (errMsg.contains("400")) {
                                        SignupError = "이미 존재하는 이메일계정 입니다."
                                        SignupEmail = ""
                                    }
                                }
                                .store(in: &authVM.subscription)
                                authVM.ValidateSuccess.sink { /// 성공 시
                                    registerData.email = SignupEmail
                                    registerData.password = isCorrectPassword

                                    SignupError = "" // 경고문 초기화
                                    SignupEmail = "" // 이메일 초기화
                                    showingAlert = true // alert 출력
                                    isActive = true
                                }
                                .store(in: &authVM.subscription)
                            }
                        }
                    }
                .foregroundColor(!SignupEmail.isEmpty || isCorrectPassword.isEmpty ? Color.white : Color.GrayScale600)
                    .padding(0)
                
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                    .background(isEditing || SignupEmail.isEmpty ? Color.GrayScale200 : Color.PrimaryOrange300) // 버튼 색상 변경
                    .cornerRadius(8)
            }
            .padding(.top, 32)
            .padding(.horizontal, 16)
            .fixedSize()
        }
        .frame(width: 375, height: 710)
        .fixedSize()
        .background(Color.white)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}

struct SignupEmail_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        SignupEmail(registerData: $test, isLogged: $isLoggedTest)
    }
}


// 위에 커스텀 네비 있다는 가정하에 위쪽 마진 32
// 양옆 마진 16
