//
//  ResetPassWordView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/08.
//

import SwiftUI

struct ResetPassWordView: View {
    @StateObject private var authVM = AuthVM()
    
    @State var ResetEmail = ""
    @State var ResetEmailError = "" //이메일 오류 출력
    @State private var isEditing = false
    
    @State var showalert = false
    @State var isNoAccount = false
    var body: some View {
        ZStack {
            VStack(alignment: .leading,spacing: 20) {
                Text("비밀번호 초기화")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.semibold)
                    )
                    .foregroundColor(.GrayScale800)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text("이메일로 임시 비밀번호를 전송해 드립니다.")
                    .font(Font.custom("Pretendard", size: 12))
                    .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Spacer().frame(height: 32)
                Text("이메일")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .foregroundColor(.GrayScale500)
                    .frame(width: 335, alignment: .topLeading)
                
                
                TextField("이메일을 입력해 주세요", text: $ResetEmail)
                    .font(Font.custom("Pretendard", size: 18))
                    .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Divider()
                
                Text(ResetEmailError)
                    .font(.caption)
                    .foregroundColor(.StateError)
                    .padding(.top, -4)
                
                Spacer().frame(height: 300)
                
                Button("임시 비밀번호 받기") {
                    if !isValidEmail(ResetEmail) {
                        ResetEmailError = "올바른 이메일을 입력해 주세요"
                        ResetEmail = ""
                        return
                    } else {
                        authVM.passwordReset(email: ResetEmail)
                    }
                }
                
                .foregroundColor(isEditing || ResetEmail.isEmpty ? Color.GrayScale600 : .white)
                .padding(0)
                
                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                .background(isEditing || ResetEmail.isEmpty ? Color.GrayScale200 : Color.PrimaryOrange300) // 버튼 색상 변경
                .cornerRadius(8)
                
                
                
                
            }.padding()
            if isNoAccount {
                CustomAlertView(showalert: $isNoAccount, alertMessage: "해당 계정이 존재하지 않습니다.")
            }
            if showalert {
                CustomAlertView(showalert: $showalert, alertMessage: "임시 비밀번호가 발급되었습니다.")
            }
        }
        .onAppear {
            authVM.emailSendError.sink { errMsg in
                if (errMsg.contains("404")) {
                    isNoAccount = true
                }
            }
            .store(in: &authVM.subscription)
            authVM.emailSendSuccess.sink { errMsg in
                ResetEmailError = "" //경고문 초기화
                ResetEmail = "" //이메일 초기화
                showalert = true
            }
            .store(in: &authVM.subscription)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool { //이메일 판단 함수
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let range = email.range(of: emailRegEx, options: .regularExpression, range: nil, locale: nil)
        return range != nil
    }
}





struct ResetPassWordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassWordView()
    }
}
