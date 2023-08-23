//
//  EmailCertCheckView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/02.
//

import SwiftUI

struct EmailCertCheckView: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    @Binding var EmailCert: String
    @Binding var isLogged: Bool?
    @State private var isButtonActive: Bool = false ///버튼 비활성 / 활성
    @State var codeStatus: codeCertError = .none
    
    @State private var firstDigit: String = ""
    @State private var secondDigit: String = ""
    @State private var thirdDigit: String = ""
    @State private var fourthDigit: String = ""
    
    @State private var timeRemaining = 180
    @State private var isActive = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            
            VStack(alignment: .leading, spacing: 6) {
                Text("학교 인증을 위해\n학교 이메일 인증을 해주세요")
                    .font(
                    Font.custom("Pretendard", size: 24)
                    .weight(.semibold)
                    )
                    .foregroundColor(.GrayScale900)
                
                if codeStatus == .notCorrect {
                    Text("인증번호가 올바르지 않습니다")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(Color(red: 0.94, green: 0.17, blue: 0.16))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                } else if codeStatus == .timeOver {
                    Text("인증번호 재전송 버튼을 눌러주세요")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(Color(red: 0.94, green: 0.17, blue: 0.16))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            
            HStack {
                Image("time")
                    .font(
                    Font.custom("Pretendard", size: 14)
                    .weight(.medium)
                    )
                    .foregroundColor(.PrimaryOrange300)
                
                Text("\((timeRemaining / 60) % 60, specifier: "%02d"):\(timeRemaining % 60, specifier: "%02d")")
                    .foregroundColor(.PrimaryOrange300)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                            if timeRemaining <= 179 && codeStatus != .notCorrect { // 추가된 조건문
                                isButtonActive = true
                            }
                        } else {
                            isButtonActive = false // 시간이 다 만났을 때 버튼 비활성화
                            if timeRemaining == 0 {
                                codeStatus = .timeOver
                            }
                        }
                    }
            }
            
            CustomTextField(firstDigit: $firstDigit, secondDigit: $secondDigit, thirdDigit: $thirdDigit, fourthDigit: $fourthDigit)
            
            /// 인증번호 재전송
            Button(action: {
                authVM.sendEmail(email: EmailCert)
                authVM.emailSendError.sink { errMsg in /// 오류 시
                }
                .store(in: &authVM.subscription)
                authVM.emailSendSuccess.sink { /// 성공 시
                }
                .store(in: &authVM.subscription)
                
                timeRemaining = 180
                codeStatus = .none
                isButtonActive = false // 인증번호 재전송 후 버튼 비활성화
                codeStatus = .none
            }) {
                Text("인증번호 재전송")
                    .underline()
                    .foregroundColor(.GrayScale500)
                
            }
            
            Spacer()
            
            
            CustomNavLinkForThr(destination: SchoolSelectView(registerData: $registerData, isLogged: $isLogged)
                .customNavigationTitle(""), isActive: $isActive, curNum: 3, finNum: 5) {
                    Button {
                        // 이메일 전송 함수 호출
                        authVM.emailAuthRegister(email: EmailCert, authNum: "\(firstDigit+secondDigit+thirdDigit+fourthDigit)")
                        /// 에러 발생 시
                        authVM.codeError.sink { errMsg in
                            if (errMsg.contains("404")){
                                codeStatus = .notCorrect
                            }
                        }
                        .store(in: &authVM.subscription)
                        /// 성공 시
                        authVM.codeSuccess.sink {
                            /// 데이터
                            registerData.universityEmail = EmailCert
                            registerData.isEmailAuth = 1
                            
                            EmailCert = "" /// 이메일 초기화
                            codeStatus = .none  /// 인증번호 상태 초기화
                            isActive = true
                        }
                        .store(in: &authVM.subscription)
                    }
                label: {
                    Text("완료")
                        .font(.headline).bold()
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background(Color.PrimaryOrange300)
                        .cornerRadius(10)
                }.disabled(!isButtonActive) // 활성화 여부 적용
                    
                }
        }.padding()
        
    }
}

struct EmailCertCheckView_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var EmailCert = ""
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        EmailCertCheckView(registerData: $test, EmailCert: $EmailCert, isLogged: $isLoggedTest)
    }
}
