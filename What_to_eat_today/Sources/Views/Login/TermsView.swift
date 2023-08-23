//
//  TermsView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/03.
//

import SwiftUI

struct TermsView: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    @Binding var selectedUIImage: UIImage?
    @Binding var isLogged: Bool?
    
    @State private var ischeckPrivacy = false  /// 개인정보처리방침[필수]
    @State private var ischeckUsage = false    /// 이용약관[필수]
    @State private var ischeckAccount = false  /// 본의명의[필수]
    @State private var ischeckMarketing = false/// 마케팅 [선택]
    @State private var ischeckAll = false
    
    @State private var canNavigate = false
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("이용약관에 \n동의 해주세요").font(.title).bold()
                    .frame(width: 343, alignment: .topLeading)
                Spacer().frame(height: 100)
                
                
                HStack {
                    Toggle(isOn: $ischeckPrivacy) {
                        Text("[필수] 개인정보처리 방침")
                            .font(Font.custom("Pretendard", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                        
                        Text("*").foregroundColor(.StateError)
                        //여기에 보기 버튼 둬야함
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    Spacer()
                    
                    CustomNavLink(destination: PrivacyPolicyView()
                        .customNavigationTitle("")
                                  
                    ) {
                        Text("보기")
                            .font(.headline).bold()
                            .foregroundColor(.GrayScale400)
                    }
                }
                
                
                HStack {
                    Toggle(isOn: $ischeckUsage) {
                        Text("[필수] 이용약관")
                            .font(Font.custom("Pretendard", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                        
                        Text("*").foregroundColor(Color.StateError)
                        //여기에 보기 버튼 둬야함
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    
                    Spacer()
                    CustomNavLink(destination: TermsOfServiceView()
                        .customNavigationTitle("")
                                  
                    ) {
                        Text("보기")
                            .font(.headline).bold()
                            .foregroundColor(.GrayScale400)
                    }
                }
                
                
                HStack {
                    Toggle(isOn: $ischeckAccount) {
                        Text("[필수] 본인명의를 이용하여 가입하겠습니다.")
                            .font(Font.custom("Pretendard", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                        Text("*").foregroundColor(.StateError)
                        //여기에 보기 버튼 둬야함
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    Spacer()
                    
                    CustomNavLink(destination: PrivacyPolicyView()
                        .customNavigationTitle("")
                                  
                    ) {
                        Text("보기")
                            .font(.headline).bold()
                            .foregroundColor(.GrayScale400)
                    }
                }
                
                HStack {
                    Toggle(isOn: $ischeckMarketing) {
                        Text("[선택] 마케팅 수신 동의").font(Font.custom("Pretendard", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                        //여기에 보기 버튼 둬야함
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    
                    Spacer()
                    CustomNavLink(destination: ReviewPolicyView()
                        .customNavigationTitle("")
                                  
                    ) {
                        Text("보기")
                            .font(.headline).bold()
                            .foregroundColor(.GrayScale400)
                    }
                }
                Divider()
                
                
                Toggle(isOn: $ischeckAll) {
                    Text("전체 약관동의")
                        .font(
                    Font.custom("Pretendard", size: 14)
                    .weight(.bold)
                    )
                    .kerning(0.1)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale800)
                }
                .toggleStyle(CheckboxToggleStyle())
                .onChange(of: ischeckAll) { value in
                    if value {
                        ischeckPrivacy = true
                        ischeckUsage = true
                        ischeckAccount = true
                        ischeckMarketing = true
                        
                    } else {
                        ischeckPrivacy = false
                        ischeckUsage = false
                        ischeckAccount = false
                        ischeckMarketing = false
                        
                    }
                }
               
                Text("(선택) 광고 수신동의를 포함하여 모두 동의합니다.").font(Font.custom("Pretendard", size: 10))
                    .kerning(0.25)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale500)
                    .padding(.top, -5)
                    .padding(.leading, 36)
                Spacer().frame(height: 50)
             
                
                
            }.padding(.all)
            CustomNavLink(destination: EndingLoginView(registerData: $registerData, selectedUIImage: $selectedUIImage, isLogged: $isLogged)
                .customNavigationBarBackButtonHidden(true)
                ,isActive: $isActive
            ) {
                Button(action: {
//                    print("전송하는 데이터 : \(registerData)")
//                    print(selectedUIImage)
                    if(ischeckMarketing){
                        registerData.agreement = "true"
                    }
                    isActive = true
                }) {
                    Text("완료")
                        .font(.headline).bold()
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor((ischeckPrivacy && ischeckUsage && ischeckAccount) ? Color.white : Color.GrayScale600)
                        .background((ischeckPrivacy && ischeckUsage && ischeckAccount) ? Color .PrimaryOrange300 : Color.GrayScale200)
                        .cornerRadius(10)
                }
            }.padding(.all)
        }
    }
    
}
//}

struct TermsView_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var testImage: UIImage? = nil
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        TermsView(registerData: $test, selectedUIImage: $testImage, isLogged: $isLoggedTest)
    }
}
