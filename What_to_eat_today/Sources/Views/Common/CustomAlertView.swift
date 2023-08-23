//
//  ResetAlertView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/10.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var showalert: Bool
    let alertMessage: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                HStack {
                    Spacer()
                    Button(action: {
                        showalert.toggle()
                    }) {
                        Image("close")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                Image("check icon")
                Text(alertMessage)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale900)
                
                HStack(alignment: .center, spacing: 8) {
                    Button(action: {
                        showalert.toggle()
                    }) {
                        Text("확인")
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .foregroundColor(.white)
                    .frame(minWidth: 200, maxWidth: 200, alignment: .center)
                    .background(Color.PrimaryOrange300)
                    .cornerRadius(300)
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 40)
            .frame(width: 335, alignment: .center)
            .background(.white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
        }
    }
}

struct CustomAlertBoolView: View {
    @Binding var showalert: Bool?
    let alertMessage: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                HStack {
                    Spacer()
                    Button(action: {
                        showalert?.toggle()
                    }) {
                        Image("close")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                Image("check icon")
                Text(alertMessage)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale900)
                
                HStack(alignment: .center, spacing: 8) {
                    Button(action: {
                        showalert?.toggle()
                    }) {
                        Text("확인")
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .foregroundColor(.white)
                    .frame(minWidth: 200, maxWidth: 200, alignment: .center)
                    .background(Color.PrimaryOrange300)
                    .cornerRadius(300)
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 40)
            .frame(width: 335, alignment: .center)
            .background(.white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
        }
    }
}

struct CustomSelectAlertView: View {
    @Binding var showalert: Bool
    @Binding var isSelected: Bool
    let alertMessage: String
    var isSelectAlert: Bool? = false
    var selectMessage: String? = ""
    var isDeleteUser: Bool? = false
    @State var isCheck: Bool = false
    
    var body: some View {
        ZStack {
            if(isSelectAlert ?? false) {
                SelectContent
                if isCheck {
                    SelectedContent
                }
            }
        }
        
     
    }
    
}

extension CustomSelectAlertView {
    private var SelectContent: some View {
        VStack(alignment: .center, spacing: 40) {
            Text(alertMessage)
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.semibold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color.GrayScale900)
            
            HStack(alignment: .top, spacing: 8) {
                Button(action: {
                    showalert = false
                }) {
                    Text("취소")
                        .foregroundColor(Color.GrayScale600)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .frame(width: .infinity)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.GrayScale100)
                .cornerRadius(300)
                Button(action: {
                    isCheck = true
                }) {
                    Text("확인")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.PrimaryOrange300)
                .cornerRadius(300)
            }
            .padding(0)
            .frame(width: 295, height: 50, alignment: .topLeading)
        }
        .padding(.horizontal, 24)
        .padding(.top, 40)
        .padding(.bottom, 24)
        .frame(width: 335, alignment: .center)
        .background(Color.BlackWhiteWhite)
        .cornerRadius(16)
        .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
    }
    
    private var SelectedContent: some View {
        VStack(alignment: .center, spacing: 40) {
            HStack {
                Spacer()
                Button(action: {
                    showalert.toggle()
                }) {
                    Image("close")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            Image(isDeleteUser ?? false ? "checkIcon-black" : "check icon")
            Text(selectMessage ?? "")
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.semibold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.GrayScale900)
            
            HStack(alignment: .center, spacing: 8) {
                Button(action: {
                    isSelected = true
                    showalert = false
                }) {
                    Text("확인")
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .foregroundColor(.white)
                .frame(minWidth: 200, maxWidth: 200, alignment: .center)
                .background(isDeleteUser ?? false ? Color.GrayScale800 : Color.PrimaryOrange300)
                .cornerRadius(300)
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 40)
        .frame(width: 335, alignment: .center)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
    }
}

struct ResetAlertView_Previews: PreviewProvider {
    static var test: Bool = true
    static var previews: some View {
        CustomAlertView(showalert: .constant(false), alertMessage: "테스트입니다.")
    }
}
