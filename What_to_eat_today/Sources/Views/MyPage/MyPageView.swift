//
//  MyProfileView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/14.
//

import SwiftUI
import URLImage

struct MyPageView: View {
    @StateObject private var userVM = UserVM()
    @Binding var isLogged: Bool?
    
    @State private var profileImage: AnyView = AnyView(Image("person"))
    
    var body: some View {
        ScrollView {
            VStack(alignment: .trailing) {
                VStack(alignment: .leading, spacing: 0) {
                    CustomProfileCell(profileImage: profileImage, profileName: userVM.userInfoData.nickname, profileStatus: (userVM.userInfoData.campers != nil) ? "\(userVM.userInfoData.campers!.university.name) / 일반회원" : "미인증 / 일반회원")
                    CustomAdCell(adImage: Image("ad"))
                   
                    Rectangle()
                        .frame(width: .infinity, height: 8)
                        .foregroundColor(Color.GrayScale100)
                    Group {
                        MyPageProfileView(isCertified: (userVM.userInfoData.isEmailAuth == 1 ? true : false)) {
                            MyProfileView(isLogged: $isLogged)
                        }
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
                        MyPageElementView(menuTitle: "내가 쓴 리뷰", menuImage: Image("mypage-forward")) {
                            MyReviewsView()
                        }
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
                        MyPageElementView(menuTitle: "공지사항", menuImage: Image("mypage-forward")) {
                            NoticesView()
                        }.overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
                        MyPageElementView(menuTitle: "FAQ", menuImage: Image("mypage-forward")) {
                            FAQView()
                        }
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
//                        MyPageElementView(menuTitle: "1:1 문의", menuImage: Image("mypage-forward")) {
//                            AskView()
//                        }
                    }
                    Rectangle()
                        .frame(width: .infinity, height: 8)
                        .foregroundColor(Color.GrayScale100)
                    Group {
                        MyPageElementView(menuTitle: "서비스 이용약관", menuImage: Image("mypage-forward")) {
                            WebConnecter(urlToLoad: "https://shade-diploma-0bf.notion.site/86e29d424db74a21805cd6f2dc545b42")
                        }
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
                        
                        MyPageElementView(menuTitle: "리뷰운영정책", menuImage: Image("mypage-forward")) {
                            WebConnecter(urlToLoad: "https://shade-diploma-0bf.notion.site/20aa03178d6f4b3cb875566b7dacae12")
                        }
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
                        MyPageElementView(menuTitle: "개인정보 처리방침", menuImage: Image("mypage-forward")) {
                            WebConnecter(urlToLoad: "https://shade-diploma-0bf.notion.site/fc2a5fdca3644e899c2163707161b86e")
                        }
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale50, lineWidth: 1)
                        )
                    }
                    
                }
                VStack(alignment: .trailing) {
                    
                    Text("앱 버전 v.1.0")
                        .font(
                            Font.custom("Pretendard", size: 12)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(.GrayScale400)
                }.padding(.horizontal)
            }
        }.toolbar(.visible, for: .tabBar)
            .onAppear() {
                userVM.userInfo()
                if let imageURLString = userVM.userInfoData.imageURL, let imageURL = URL(string: imageURLString) {
                    profileImage = AnyView(URLImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                } else {
                    profileImage = AnyView(Image("person"))
                }
            }

    }
}


//struct MyPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPageView()
//    }
//}

