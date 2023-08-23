//
//  PasswordView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/14.
//

import SwiftUI

enum Field: Hashable {
    case password
}

struct PasswordView: View {
    @StateObject private var userVM = UserVM()
    
    @State var curpassword: String = "" //현재 비밀번호
    @State var newpassword: String = "" //새 비밀번호
    @State var checkpassword: String = "" //새 비밀번호 확인
    @State var showalert = false
    @State var curSecureMode: Bool = true //현재 비번 눈알
    @State var newSecureMode: Bool = true //새 비번 눈알
    @State var checkSecureMode: Bool = true //새 비번 확인 눈알
    @FocusState private var focusedField: Field?
    @State var ResetEmailError = "" //오류 출력
    @State var isSamePassword: Bool = false // 현재 비밀번호와 새 비밀번호가 같은지 확인
    @State var isValidInput: Bool = false // 입력 값이 유효한지 확인
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 24) {
                    
// - MARK: 현재 비번
                    Text("현재 비밀번호")
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(.GrayScale500)
                    HStack {
                        if curSecureMode {
                            SecureField("비밀번호를 입력해주세요.", text: $curpassword)
                                .foregroundColor(.GrayScale800)
                                .textFieldStyle(.plain)
                                
                        } else {
                            TextField("비밀번호를 입력해주세요.", text: $curpassword).textFieldStyle(.plain)
                                .foregroundColor(.GrayScale800)
                                

                        }
                        Button {
                            curSecureMode.toggle()
                        } label: {
                            Image(curSecureMode ? "eye-off" : "eye").frame(width: 20, height: 20)
                        }
                        
                    }
                    Divider()
                    
                
// - MARK: 새 비번
                    Text("새 비밀번호")
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(.GrayScale500)
                    HStack {
                        if newSecureMode {
                            SecureField("비밀번호를 입력해주세요.", text: $newpassword)
                                .foregroundColor(.GrayScale800)
                                .textFieldStyle(.plain)
                                
                        } else {
                            TextField("비밀번호를 입력해주세요.", text: $newpassword).textFieldStyle(.plain)
                                .foregroundColor(.GrayScale800)
                                

                        }
                        Button {
                            newSecureMode.toggle()
                        } label: {
                            Image(newSecureMode ? "eye-off" : "eye").frame(width: 20, height: 20)
                        }
                    }
                    Divider()
                    
// - MARK: 새 비번 확인
                    VStack(alignment: .leading) {
                        Text("새 비밀번호 확인")
                            .font(Font.custom("Pretendard", size: 14))
                            .foregroundColor(.GrayScale500)
                        HStack {
                            if checkSecureMode {
                                SecureField("비밀번호를 입력해주세요.", text: $checkpassword)
                                    .foregroundColor(.GrayScale800)
                                    .textFieldStyle(.plain)
                                
                            } else {
                                TextField("비밀번호를 입력해주세요.", text: $checkpassword).textFieldStyle(.plain)
                                    .foregroundColor(.GrayScale800)
                                
                                
                            }
                            Button {
                                checkSecureMode.toggle()
                            } label: {
                                Image(checkSecureMode ? "eye-off" : "eye").frame(width: 20, height: 20)
                            }
                        }
                        Divider().padding(.bottom)
                        
                        Text(ResetEmailError)
                                          .font(.caption)
                                          .foregroundColor(.StateError)
                                          .padding(.top, -4)
                    }
                    VStack(alignment: .center) {
                        Spacer()
                        
                        Button("변경하기") {
                            if curpassword.isEmpty || newpassword.isEmpty || checkpassword.isEmpty {
                                ResetEmailError = "현재 비밀번호와 새 비밀번호를 입력해주세요."
                            } else if curpassword == newpassword {
                                ResetEmailError = "새 비밀번호는 현재 비밀번호와 달라야 합니다."
                            } else if newpassword != checkpassword {
                                ResetEmailError = "새 비밀번호가 서로 일치하지 않습니다."
                            } else {
                                userVM.passwordChange(oldPassword: curpassword, newPassword: newpassword)
                                userVM.taskError.sink { errMsg in
                                    if (errMsg.contains("일치하지 않습니다")) {
                                        ResetEmailError = "기존의 비밀번호와 일치하지 않습니다."
                                    }
                                }
                                .store(in: &userVM.subscription)
                                userVM.taskSuccess.sink {
                                    ResetEmailError = ""
                                    showalert = true
                                }
                                .store(in: &userVM.subscription)
                            }
                        }
                        .font(Font.custom("Pretendard", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(!isValidInput ? .white : .GrayScale600) // 입력 값이 유효하면 primaryOrange300, 그렇지 않으면 GrayScale600
                        .padding(0)
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                        .background(!isValidInput ? .PrimaryOrange300 : Color.GrayScale200)
                        .cornerRadius(8)
                    }
                    .onChange(of: ResetEmailError, perform: { newValue in
                        isValidInput = newValue.isEmpty && !curpassword.isEmpty && !newpassword.isEmpty && !checkpassword.isEmpty
                        // 오류 메시지가 없고 각 필드가 비어있지 않으면 유효한 입력 값으로 간주
                    })
                }.padding(.all)
            }
            if showalert {  //showalert true = 커스텀뷰 출력
                CustomAlertView(showalert: $showalert, alertMessage: "비밀번호 변경이\n완료되었습니다.")
            }
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
