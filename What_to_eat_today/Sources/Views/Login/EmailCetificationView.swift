//
//  EmailCetificationView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/28.
//

import SwiftUI

struct EmailCetificationView: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    @Binding var isLogged: Bool?
    
    @State var EmailCert = ""
    @State var EmailCertError = "" //이메일 오류 출력
    @State private var isEditing = false
    @State private var isActive = false
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 10) {
                Text("학교 인증을 위해")
                    .font(.title).bold()
                Text("학교 이메일 인증을 해주세요")
                    .font(.title).bold()
                Spacer().frame(height: 10)
                Text(EmailCertError)
                    .font(.caption)
                    .foregroundColor(.StateError)
                    .padding(.top, -4)
                Spacer().frame(height: 20)
                Text("이메일")
                    .font(
                    Font.custom("Pretendard", size: 14)
                    .weight(.medium)
                    )
                    .kerning(0.1)
                    .foregroundColor(.GrayScale500)
                TextField("example.uni.ac.kr", text: $EmailCert)
                    .textInputAutocapitalization(.never)
                Divider()
                
                VStack(alignment: .center, spacing: 10) {
                    CustomNavLinkForThr(destination: SchoolSelectView(registerData: $registerData, isLogged: $isLogged)
                        .customNavigationTitle("")
                                        , curNum: 3, finNum: 5)
                    {
                        Text("인증 건너뛰기")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color.GrayScale300, lineWidth: 1)
                            )
                    }
                    
                    HStack {
                        Image("alert-circle")
                            .frame(width: 16, height: 16)
                        Text("인증을 건너뛸 시 리뷰작성이 불가능합니다.")
                            .font(.caption)
                    }
                    Spacer().frame(height: 200)
                    
                    CustomNavLinkForThr(destination: EmailCertCheckView(registerData: $registerData, EmailCert: $EmailCert, isLogged: $isLogged)
                        .customNavigationTitle("")
                        , isActive: $isActive
                        , curNum: 2, finNum: 5) {
                            Button("완료") {
                                if !isValidEmail(EmailCert) {
                                    EmailCertError = "올바른 이메일을 입력해 주세요"
                                    EmailCert = ""
                                    return
                                } else {
                                    authVM.sendEmail(email: EmailCert) // 이메일 전송 함수 호출
                                    // 에러 발생 시
                                    authVM.emailSendError.sink { errMsg in
                                        if(errMsg.contains("400")) {
                                            EmailCertError = "이미 가입 되어있는 이메일입니다."
                                        }
                                        //EmailCertError = errMsg // 경고문 업데이트
                                    }
                                    .store(in: &authVM.subscription)
                                    // 성공 시
                                    authVM.emailSendSuccess.sink {
                                        EmailCertError = "" // 경고문 초기화
//                                        EmailCert = "" // 이메일 초기화 (뒤에서 진행)
                                        isActive = true
                                    }
                                    .store(in: &authVM.subscription)
                                }
                            }
                        }
                        .foregroundColor(isEditing || EmailCert.isEmpty ? Color.GrayScale600 : .white)
                        .padding(0)
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                        .background(isEditing || EmailCert.isEmpty ? Color.GrayScale200 : Color.PrimaryOrange300) // 버튼 색상 변경
                        .cornerRadius(8)
                    Spacer().frame(height: 10)
                }
            }.padding(.all)
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}


struct EmailCetificationView_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        EmailCetificationView(registerData: $test, isLogged: $isLoggedTest)
    }
}
