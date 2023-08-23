//
//  MyProfileView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/04.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject private var authVM = AuthVM()
    @StateObject private var userVM = UserVM()
    @StateObject private var nicknameManager = TextBindingManager(text: "")
    private var nicknameTerm: String {
        nicknameManager.text
    }
    @Binding var isLogged: Bool?
    
    
    @State var showingSheet = false
    @State private var showCamera = false
    @State private var image: UIImage?
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    //    @State private var nickname: String = ""
    @State private var isNicknameChanged: Bool = false
    @State var isSocial = true  //소셜 로그인 여부
    
    @State var showNicknameOverlap = false
    @State var showNicknameChanged = false
    @State var showLogoutAlert = false
    @State var showWithdrawalAlert = false
    @State var isLogout = false // 로그아웃 확인버튼 클릭 여부
    @State var isDelete = false // 회원탈퇴 확인버튼 클릭 여부
    @State var CheckMarketing: String = ""
    
    @State static var test = RegisterRequest.init()
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                myProfileImage
                myProfileContent
            }
            if showNicknameOverlap {
                CustomAlertView(showalert: $showNicknameOverlap, alertMessage: "중복된 닉네임입니다.")
            }
            if showNicknameChanged {
                CustomAlertView(showalert: $showNicknameChanged, alertMessage: "닉네임이 변경되었습니다.")
            }
            if showLogoutAlert {
                CustomSelectAlertView(showalert: $showLogoutAlert, isSelected: $isLogout, alertMessage: "로그아웃 하시겠습니까?", isSelectAlert: true, selectMessage: "성공적으로 로그아웃 되었습니다.")
            }
            if showWithdrawalAlert {
                CustomSelectAlertView(showalert: $showWithdrawalAlert, isSelected:$isDelete ,alertMessage: "회원 탈퇴 하시겠습니까?", isSelectAlert: true, selectMessage: "탈퇴가 완료되었습니다.\n이용해주셔서 감사합니다.", isDeleteUser: true)
            }
        }
        .onChange(of: isLogout) { value in
            if value {
                /// 로그아웃 API
                UserDefaultsManager.shared.clearAll()
                authVM.logout()
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                            UserDefaults.standard.removeObject(forKey: key.description)
                        }
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                   print("\(key) = \(value) \n")
                 }
                isLogged = false
            }
        }
        .onChange(of: isDelete) { value in
            if value {
                /// 회원탈퇴 API
                authVM.deleteUser()
            }
        }
        .onAppear {
            isSocial = UserDefaults.standard.bool(forKey: "social")
            userVM.userDetail()
            //            self.nicknameManager.nickname = userVM.userDetailInfoData.nickname
            authVM.taskError .sink { errMsg in
            }
            .store(in: &authVM.subscription)
            authVM.taskSuccess .sink {
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                            UserDefaults.standard.removeObject(forKey: key.description)
                        }
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                   print("\(key) = \(value) \n")
                 }
                isLogged = false
            }
            .store(in: &authVM.subscription)
        }
    }
}

extension MyProfileView {
    
    private var myProfileImage: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
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
            }
        }
        .frame(width: 93, height: 92)
    }
    
    private var myProfileContent: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                myProfileName
                myProfileNickName
                myProfileEmail
                myProfileSchoolEmail
                if !isSocial { myProfilePassword }
                myProfileCheckBox
                
            }
            Spacer().frame(height: 40)
            
            getOutUserView
            
        }
        
        
    }
    private var myProfileName: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 8) {
                Text("이름")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale600)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 0)
            .frame(width: 343, alignment: .topLeading)
            
            HStack(alignment: .center, spacing: 6) {
                Text(userVM.userDetailInfoData.name)
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .foregroundColor(Color.GrayScale900)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.leading, 12)
            .padding(.trailing, 8)
            .padding(.vertical, 12)
            .frame(width: 343, alignment: .leading)
            .background(Color.BlackWhiteWhite)
            
            Rectangle()
                .frame(maxWidth: 343, maxHeight: 1)
                .foregroundColor(Color.GrayScale300)
            
        }
    }
    
    private var myProfileNickName: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 8) {
                Text("닉네임")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale600)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 0)
            .frame(width: 343, alignment: .topLeading)
            
            HStack(alignment: .center, spacing: 6) {
                TextField(userVM.userDetailInfoData.nickname, text: $nicknameManager.text)
                    .onChange(of: nicknameTerm) { _ in
                        isNicknameChanged = true
                    }
                //                TextField(userVM.userDetailInfoData.nickname, text: $nicknameManager.nickname, onEditingChanged: { _ in
                //                    isNicknameChanged = nicknameManager.nickname != userVM.userDetailInfoData.nickname
                //                    isNicknameChanged = true
                //                })
                    .font(Font.custom("Pretendard", size: 14).weight(.medium))
                    .kerning(0.1)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Button(action: {
                    userVM.nickNameChange(nickname: nicknameManager.text)
                    userVM.changeError .sink { errMsg in
                        if(errMsg.contains("405")) {
                            showNicknameOverlap = true
                        }
                    }
                    .store(in: &userVM.subscription)
                    userVM.changeSuccess .sink {
                        showNicknameChanged = true
                        isNicknameChanged = false
                        //                        userVM.userDetailInfoData.nickname = self.nickname
                    }
                    .store(in: &userVM.subscription)
                }) {
                    Text("수정")
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(isNicknameChanged ? Color.PrimaryOrange300 : Color.GrayScale300)
                }
            }
            .padding(.leading, 12)
            .padding(.trailing, 8)
            .padding(.vertical, 12)
            .frame(width: 343, alignment: .leading)
            .background(Color.BlackWhiteWhite)
            
            Rectangle()
                .frame(maxWidth: 343, maxHeight: 1)
                .foregroundColor(Color.GrayScale300)
        }
    }
    
    private var myProfileEmail: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 8) {
                Text("이메일")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale600)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 0)
            .frame(width: 343, alignment: .topLeading)
            
            
            //여기에 소셜로 로그인했을 경우와 아닌 경우 if else로 구별
            if(isSocial) {
                HStack(alignment: .center, spacing: 6) {
                    
                    Text(userVM.userDetailInfoData.email)
                        .font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(Color.GrayScale900)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(.leading, 12)
                .padding(.trailing, 8)
                .padding(.vertical, 12)
                .frame(width: 343, alignment: .leading)
                .background(Color.BlackWhiteWhite)
            } else {
                CustomNavLink(destination: EmailChageView()
                    .customNavigationTitle("이메일 변경")
                ) {
                    HStack(alignment: .center, spacing: 6) {
                        Text(userVM.userDetailInfoData.email)
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.medium)
                            )
                            .kerning(0.1)
                            .foregroundColor(Color.GrayScale900)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Image("myprofile-arrow")
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                    .padding(.vertical, 12)
                    .frame(width: 343, alignment: .leading)
                    .background(Color.BlackWhiteWhite)
                }
            }
            Rectangle()
                .frame(maxWidth: 343, maxHeight: 1)
                .foregroundColor(Color.GrayScale300)
        }
    }
    
    private var myProfileSchoolEmail: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 8) {
                Text("학교 이메일")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale600)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 0)
            .frame(width: 343, alignment: .topLeading)
            
            if (userVM.userDetailInfoData.universityEmail == nil) {
                CustomNavLink(destination: ReSchoolCertView(registerData: MyProfileView.$test)
                    .customNavigationTitle("학교 인증하기")
                ) {
                    HStack(alignment: .center, spacing: 6) {
                        Text("학교 인증하고 리뷰 작성하기")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.medium)
                            )
                            .kerning(0.1)
                            .foregroundColor(userVM.userDetailInfoData.universityEmail != nil ? Color.PrimaryOrange300 : Color.GrayScale900)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Image("SchoolEmailArrow")
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                    .padding(.vertical, 12)
                    .frame(width: 343, alignment: .leading)
                    .background(Color.BlackWhiteWhite)
                }
            } else {
                HStack(alignment: .center, spacing: 6) {
                    Text(userVM.userDetailInfoData.universityEmail!)
                        .font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(Color.GrayScale900)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
//                    Image(userVM.userDetailInfoData.universityEmail != nil ? "SchoolEmailArrow" : "myprofile-arrow")
//                        .frame(width: 24, height: 24)
                }
                .padding(.leading, 12)
                .padding(.trailing, 8)
                .padding(.vertical, 12)
                .frame(width: 343, alignment: .leading)
                .background(Color.BlackWhiteWhite)
            }
            Rectangle()
                .frame(maxWidth: 343, maxHeight: 1)
                .foregroundColor(Color.GrayScale300)
            
        }
    }
    
    private var myProfilePassword: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 8) {
                Text("비밀번호")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale600)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 0)
            .frame(width: 343, alignment: .topLeading)
            
            CustomNavLink(destination: PasswordView()
                .customNavigationTitle("비밀번호 변경")
                          
            ) {
                HStack(alignment: .center, spacing: 6) {
                    Text("변경하기")
                        .font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(Color.GrayScale900)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Image("myprofile-arrow")
                        .frame(width: 24, height: 24)
                }
                
                .padding(.leading, 12)
                .padding(.trailing, 8)
                .padding(.vertical, 12)
                .frame(width: 343, alignment: .leading)
                .background(Color.BlackWhiteWhite)
            }
            Rectangle()
                .frame(maxWidth: 343, maxHeight: 1)
                .foregroundColor(Color.GrayScale300)
        }
    }
    
    private var myProfileCheckBox: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                HStack(alignment: .center, spacing: 4) {
                    Button(action: {
                        if (userVM.userDetailInfoData.agreement == true){
                            CheckMarketing = "false"
                        } else {
                            CheckMarketing = "true"
                        }
                        userVM.marketing(isAgree: CheckMarketing)
                        userVM.taskError .sink { errMsg in
                        }
                        .store(in: &userVM.subscription)
                        userVM.taskSuccess .sink {
                            print("마케팅 수신동의 변경완료")
                            userVM.userDetailInfoData.agreement.toggle()
                        }
                        .store(in: &userVM.subscription)
                    }) {
                        Image(userVM.userDetailInfoData.agreement ? "mypage-checkbox-on" : "mypage-checkbox-off")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .clipped()
                    }
                    .frame(maxWidth: 24, maxHeight: 24)
                    
                    Text("[선택] 마케팅 수신 동의")
                        .font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.GrayScale900)
                }
                
                Spacer()
                CustomNavLink(destination: WebConnecter(urlToLoad: "https://shade-diploma-0bf.notion.site/fd8d0a3fc7e2442fb4dcd8c6afa758c4?pvs=4")){
                    Text("보기")
                        .font(
                            Font.custom("Pretendard", size: 12)
                                .weight(.medium)
                        )
                        .underline()
                        .foregroundColor(Color.GrayScale300)
                        .frame(width: 20.93895, alignment: .topLeading)
                }
            }
        }
        .padding(.leading, 0)
        .padding(.trailing, 16)
        .padding(.vertical, 0)
        .frame(width: 343, height: 48, alignment: .leading)
    }
    
    private var getOutUserView: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 16) {
                    
                    HStack {
                        Button("로그아웃") {
                            showLogoutAlert = true
                        }
                        .font(Font.custom("Pretendard", size: 13))
                        .foregroundColor(.GrayScale300)
                        
                        
                    }
                    
                    Image("Vector 292")
                        .frame(width: 0, height: 14)
                        .overlay(
                            Rectangle()
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
                    
                    Button("회원탈퇴") {
                        showWithdrawalAlert = true
                    }
                    .font(Font.custom("Pretendard", size: 13))
                    .foregroundColor(.GrayScale300)
                }
                .padding(0)
                
                
            }
        }
    }
}

//struct MyProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyProfileView()
//    }
//}

