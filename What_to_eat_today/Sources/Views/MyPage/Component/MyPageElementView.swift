//
//  MyPageElementView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/02.
//

import SwiftUI


struct MyPageElementView<Content: View>: View {
    let content: Content
    let menuTitle: String
    let menuImage: Image
    
    init(menuTitle: String, menuImage: Image, @ViewBuilder content: () -> Content) {
        self.menuTitle = menuTitle
        self.menuImage = menuImage
        self.content = content()
    }
    
    var body: some View {
        CustomNavLink( // 화면 전환
            destination: content
                .customNavigationTitle(menuTitle)
                .customNavigationBarBackButtonHidden(false)
        ) {
            // 화면 구성
            HStack(alignment: .center, spacing: 8) {
                Text(menuTitle) // 타이틀
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.13))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                menuImage // 버튼 이미지
                    .frame(width: 20, height: 20)
//                    .rotationEffect(.degrees(180)) // 임시
            }
            .padding(16)
            .frame(width: .infinity, height: 56, alignment: .leading)
            .background(Color.BlackWhiteWhite)
        }
    }
}
struct MyPageProfileView<Content: View>: View {
    let content: Content
    let menuTitle: String = "내 정보"
    let menuImage: Image = Image("mypage-element-arrow(임시)")
    let unauthKeyword: String = "학교인증 필요"
    let authKeyword: String = "인증 완료"
    
    private var isCertified: Bool// 인증 여부
    
    init(isCertified: Bool, @ViewBuilder content: () -> Content) {
        self.isCertified = isCertified
        self.content = content()
    }
    
    var body: some View {
        CustomNavLink(
            destination: content
                .customNavigationTitle("내 정보")
                .customNavigationBarBackButtonHidden(false)
        ) {
            HStack(alignment: .center, spacing: 8) {
                Text(menuTitle)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.13))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                // 텍스트
                HStack(alignment: .top, spacing: 8) {
                    Text(isCertified ? authKeyword : unauthKeyword)
                        .font(
                            Font.custom("Pretendard", size: 11)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(isCertified ? Color.StateSuccess : Color.GrayScale700)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(isCertified ? Color(red: 0.07, green: 0.81, blue: 0.37).opacity(0.08) : Color.GrayScale100)
                .cornerRadius(16)
                
                menuImage
                    .frame(width: 20, height: 20)
                    .rotationEffect(.degrees(180))
            }
            .padding(16)
            .frame(width: .infinity, height: 56, alignment: .leading)
            .background(Color.BlackWhiteWhite)
        }
    }
}

//struct MyPageProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPageElementView(menuTitle: "내가 쓴 리뷰", menuImage: Image("mypage-forward")) {
//            StoreView()
//        }
//    }
//}

//struct MyPageProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPageProfileView(isCertified: true) {
//            StoreView()
//        }
//    }
//}
