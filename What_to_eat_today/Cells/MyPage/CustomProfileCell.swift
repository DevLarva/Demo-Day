//
//  CustomProfileCell.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/04.
//

import SwiftUI

struct CustomProfileCell: View {
    var profileImage: AnyView
    var profileName: String
    var profileStatus: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(alignment: .center, spacing: 0) {
                MypageProfile()
            }
            
            
            // 이름 및 회원 정보
            VStack(alignment: .leading, spacing: 2) {
                Text(profileName)
                    .font(
                        Font.custom("Pretendard", size: 20)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.13))
                Text(profileStatus)
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .foregroundColor(Color.GrayScale500)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .toolbar(.hidden, for: .tabBar)
//        .padding(.top, 24)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 16)
        .frame(width: .infinity, alignment: .leading)
    }
}

struct CustomProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomProfileCell(profileImage: AnyView(Image("person")), profileName: "푸드파이터김철수", profileStatus: "울산대 / 일반회원")
    }
}
