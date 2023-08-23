//
//  ProfileView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/03.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    @Binding var isLogged: Bool?
    
    @State var name = ""
    @State var nickname = ""
    @State var showingSheet = false
    @State private var showCamera = false
    @State private var image: UIImage?
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    
    /// 버튼 유효성 검사
    @State var isActive: Bool = false
    
    /// 닉네임 유효성 검사
    @State var isAvailable: Bool = false
    @State var isOverlap: Bool = false
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("프로필을 \n입력해 주세요").font(.title2).bold()
                        .foregroundColor(Color.GrayScale900)
                    
                    if(isAvailable) {
                        Text("사용 가능한 닉네임입니다")
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(Color(red: 0.94, green: 0.17, blue: 0.16))
                    } else if (isOverlap){
                        Text("중복된 닉네임입니다")
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(Color(red: 0.94, green: 0.17, blue: 0.16))
                    }
                }
                
                Button(action: {
                    self.showingSheet = true
                }) {
                    if let displayImage = image {
                        Image(uiImage: displayImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipped()
                            .clipShape(Circle())
                        HStack(alignment: .center, spacing: 0) {
                            Image("pencil")
                                .frame(width: 18, height: 18)
                        }
                        
                        .padding(7)
                        .frame(width: 32, height: 32, alignment: .center)
                        .background(Color.PrimaryOrange300)
                        .cornerRadius(36)
                        .overlay(
                            RoundedRectangle(cornerRadius: 36)
                                .inset(by: 1)
                                .stroke(.white, lineWidth: 2)
                        )
                        .offset(x: -30,y: 30)
                    } else {
                        ProfileButton()
                    }
                }
                .confirmationDialog("타이틀", isPresented: $showingSheet) {
                    Button("사진 촬영", role: .none) {
                        showCamera = true
                    }
                    Button("앨범", role: .none) {
                        showImagePicker.toggle()
                    }
                    
                    Button("취소", role: .cancel) {}
                }.sheet(isPresented: $showCamera) {
                    CameraView(image: $image)
                }
                .sheet(isPresented: $showImagePicker) {
                                        ImagePicker(image: $image)
                }
                
                Text("이름")
                    .foregroundColor(.GrayScale500)
                CustomTextFieldWithBottomLine($name, placeholder: "이름입력", placeholderimage: "close-circle")
                
                Text("닉네임")
                    .foregroundColor(.GrayScale500)
                CustomTextFieldWithBottomLine($nickname , placeholder: "8글자 내로 입력")
                
                Spacer().frame(height: 168)
                CustomNavLink(destination: TermsView(registerData: $registerData, selectedUIImage: $selectedUIImage, isLogged: $isLogged)
                    .customNavigationTitle("")
                    ,isActive: $isActive
                ) {
                    Button(action: {
                        authVM.nickNameValidate(nickname: nickname)
                        authVM.ValidateError.sink { errMsg in /// 오류 시
                            if (errMsg.contains("400")){
                                isOverlap = true
                            }
                        }
                        .store(in: &authVM.subscription)
                        authVM.ValidateSuccess.sink { /// 성공 시
                            registerData.name = name
                            registerData.nickname = nickname
                            
                            isOverlap = false
                            isAvailable = true
                            isActive = true
                        }
                        .store(in: &authVM.subscription)
                    }) {
                        Text("완료")
                            .font(.headline).bold()
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundColor((isAvailable && (!name.isEmpty && !nickname.isEmpty)) ? Color.white : Color.GrayScale600)
                            .background((isAvailable && (!name.isEmpty && !nickname.isEmpty)) ? Color.PrimaryOrange300 : Color.GrayScale200)
                            .cornerRadius(10)
                    }
                }
                
            }.padding(.all)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var isLoggedTest: Bool? = false
    
    static var previews: some View {
        ProfileView(registerData: $test, isLogged: $isLoggedTest)
    }
}

// 텍스트 필드 수정
// 체크박스 입력 다하면 색상 변경 + (선택) 광고 ~~~ ali맞추기
// 버튼 위치 아래 인디케이터랑 8px
// 본인명의를 이용해 ~~ 추가
