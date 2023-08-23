//
//  SchoolSelectView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/14.
//

import SwiftUI

struct SchoolSelectView: View {
    @Binding var registerData: RegisterRequest
    @Binding var isLogged: Bool?
    @State private var isInputEmpty: Bool = true /// 텍스트 필드 비었는지
    @State private var showError: Bool = false /// 학교 입력 에러 보여주기
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 6) {
                Text("학교정보를")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color.GrayScale900)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text("입력해주세요")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color.GrayScale900)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .frame(width: 343, height: 68)
            .multilineTextAlignment(.center)
            
            
                if isInputEmpty == true {
                    Text("학교 정보를 입력해 주세요.")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.StateError)
                        .padding(.leading)
                }
            

            VStack(alignment: .leading, spacing: 4) {
                Text("학교")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .foregroundColor(Color.GrayScale500)
                    .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                
                SchoolSelectTextField(registerData: $registerData, isTextFieldEmpty: $isInputEmpty)
            }
            .frame(width: UIScreen.main.bounds.width - 32, alignment: .topLeading)
            
            Spacer()
            
            CustomNavLink(destination: ProfileView(registerData: $registerData, isLogged: $isLogged)) {
                
                
                Text("완료")
                    .font(.headline).bold()
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.PrimaryOrange300)
                    .cornerRadius(10)
            }
            .disabled(isInputEmpty)
            .padding(.bottom, 8)
        }
        .padding(.top, 32)
        .padding(.horizontal, 16)
    }
}

struct SchoolSelectView_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        SchoolSelectView(registerData: $test, isLogged: $isLoggedTest)
    }
}
