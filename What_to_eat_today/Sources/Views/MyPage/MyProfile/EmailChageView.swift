//
//  EmailChageView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/15.
//

import SwiftUI

struct EmailChageView: View {
    @StateObject private var userVM = UserVM()
    
    @State var ChangeEmail = "" //변경 이메일
    @State var CertCode = "" // 입력받을 인증코드
    @State var showalert = false // alert
    @State var showErrorAlert = false // erroralert
    @State var EmaileEditing = false // 이메일 입력중
    @State var requestText = "인증 요청" // 인증 요청 버튼의 글자를 업데이트하는 상태 변수
    @State private var timeRemaining = 180 //타이머
    @State var showVerifyButton = false // 인증코드 확인 버튼 출력 여부
    let correctCertCode = "1234" // 일치하는 인증 코드
    @State var isCertCodeValid = false // 현재 입력된 인증번호의 유효성을 나타내는 변수
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("이메일")
                        .font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(.GrayScale600)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    HStack {
                        TextField("이메일을 입력하세요", text: $ChangeEmail, onEditingChanged: { editing in
                            EmaileEditing = editing // 이메일 입력중 상태 업데이트
                        })
                        .padding(.bottom, 0)
                        .foregroundColor(.GrayScale400)
                        .textInputAutocapitalization(.never)
                        
//                        Button(action: {
//                            startCountdownTimer()
//                            showVerifyButton = true // 인증코드 확인 버튼 출력
//                        }) {
//                            Text(requestText)
//                                .font(
//                                    Font.custom("Pretendard", size: 14)
//                                        .weight(.medium)
//                                )
//                                .kerning(0.1)
//                                .foregroundColor(ChangeEmail.isEmpty ? .GrayScale300 : .PrimaryOrange300)
//                        }
                    }
                    
                    Divider()
                }
                
//                VStack(alignment: .leading, spacing: 6) {
//
//                    Text("인증번호 입력")
//                        .font(
//                            Font.custom("Pretendard", size: 14)
//                                .weight(.medium)
//                        )
//                        .kerning(0.1)
//                        .foregroundColor(.GrayScale600)
//                        .frame(maxWidth: .infinity, alignment: .topLeading)
//
//                    HStack {
//                        TextField("인증번호를 입력해주세요", text: $CertCode)
//                            .keyboardType(.numberPad)
//                            .padding(.bottom,0)
//                            .foregroundColor(.GrayScale400)
//                            .textInputAutocapitalization(.never)
//
//
//
//                        if showVerifyButton { // 인증코드 확인 버튼 출력 여부 확인
//
//                            if timeRemaining > 0 && !isCertCodeValid {
//                                Text("\(formatTime(timeRemaining))")
//                                    .font(
//                                        Font.custom("Pretendard", size: 14)
//                                            .weight(.medium)
//                                    )
//                                    .kerning(0.15)
//                                    .foregroundColor( .PrimaryOrange300)
//                                    .padding(.trailing, 4)
//                            }
//
//                            Button("확인") {
//                                if CertCode == correctCertCode {
//                                    isCertCodeValid = true
//                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
//                                        timeRemaining = 0
//                                    }
//                                } else {
//                                    requestText = "재전송"
//                                    CertCode = ""
//                                    isCertCodeValid = false
//                                }
//
//                                if isCertCodeValid {
//                                    timeRemaining = 0
//                                }
//                            }
//                            .font(
//                                Font.custom("Pretendard", size: 14)
//                                    .weight(.medium)
//                            )
//                            .kerning(0.1)
//                            .foregroundColor(isCertCodeValid ? .GrayScale300 : .PrimaryOrange300)
//
//
//                        }
//
//                    }
//
//
//
//                    Divider()
//                }
                
                VStack(alignment: .center) {
                    Spacer()
                    Button("변경하기") {
                        userVM.emailChange(email: ChangeEmail)
                        userVM.taskError.sink { errMsg in
                            if (errMsg.contains("405")) {
                                showErrorAlert = true
                            }
                        }
                        .store(in: &userVM.subscription)
                        /// 이미 계정이 있을 경우
                        userVM.taskSuccess.sink {
                            showalert = true
                        }
                        .store(in: &userVM.subscription)
                        
//                        if isCertCodeValid {  //인증번호가 일치할시에만 alert 출력
//                              showalert = true
//                          }
                    }
                    .font(Font.custom("Pretendard", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(EmaileEditing ? Color.white : .GrayScale600)
                    .padding(0)
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                    .background(EmaileEditing ? Color.PrimaryOrange300 : Color.GrayScale200)
                    .cornerRadius(8)
                }
                
            }.padding(.all)
            
            if showalert {  //showalert true = 커스텀뷰 출력
                CustomAlertView(showalert: $showalert, alertMessage: "이메일 변경이\n완료되었습니다.")
            }
            if showErrorAlert {
                CustomAlertView(showalert: $showErrorAlert, alertMessage: "이미 존재하는 이메일입니다.")
            }
        }
        .onAppear {
            
        }
    }
    func startCountdownTimer() { // 카운트 다운 함수
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        RunLoop.main.add(timer, forMode: .common)
        timer.tolerance = 0.5
    }
   
    func formatTime(_ seconds: Int) -> String {  // 초단위 -> 분단위
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
}

struct EmailChageView_Previews: PreviewProvider {
    static var previews: some View {
        EmailChageView()
    }
}

