//
//  EndingLoginView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/03.
//

import SwiftUI

struct EndingLoginView: View {
    @StateObject private var authVM = AuthVM()
    @StateObject private var userVM = UserVM()
    
    @Binding var registerData: RegisterRequest
    @Binding var selectedUIImage: UIImage?
    @Binding var isLogged: Bool?
    
//    @State private var isshowHomeView = false
    var body: some View {
//        if isshowHomeView {
//            ContentView()
//        } else {
            VStack(alignment: .center, spacing: 20) {
                Spacer().frame(height: 60)
                Image("firework")
                    .resizable()
                    .frame(width: 80, height: 80)
                
                Spacer().frame(height: 20)
                Text("\(registerData.nickname)님 환영합니다!").font(.title).bold()
                
                Text("오늘 뭐먹지는 즐거운 맛집탐방을 위해 \n 대학생의 생생한 후기를 알려드려요!").foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 10)
                
                VStack {
                    ZStack {
                       VStack(alignment: .leading, spacing: 16) {
                            
                            Image("Ending")
                                .resizable()
                                .frame(width: 232,height: 385.96362)
                        }
                        
                        Button(action: {
                            authVM.register(dto: registerData, image: selectedUIImage)
                            authVM.registerError.sink { errMsg in /// 오류 시
                            }
                            .store(in: &authVM.subscription)
                            authVM.registerSuccess.sink { /// 성공 시
                                userVM.userInfo()
                                userVM.infoSuccess .sink{ _ in
                                    UserDefaults.standard.set(userVM.userInfoData.campers?.university.name, forKey: UniversityName.universityName.rawValue)
                                    UserDefaults.standard.set(userVM.userInfoData.nickname, forKey: UserNickname.userNickname.rawValue)
                                }
                                isLogged = true
//                                isshowHomeView = true
                            }
                            .store(in: &authVM.subscription)
                        }) {
                            Text("시작하기")
                                .font(.headline).bold()
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .foregroundColor(.white)
                                .background(Color.PrimaryOrange300)
                                .cornerRadius(10)
                            
                        }.offset(y: 120)
                            .padding(.top, 15)
                    }
                }
            }.padding(.all)
                .navigationBarBackButtonHidden()

//        }
        
        
    }
}

struct EndingLoginView_Previews: PreviewProvider {
    @State static var test = RegisterRequest.init()
    @State static var testImage: UIImage? = nil
    @State static var isLoggedTest: Bool? = false
    static var previews: some View {
        EndingLoginView(registerData: $test, selectedUIImage: $testImage, isLogged: $isLoggedTest)
    }
}


