//
//  ReviewPolicyView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/02.
//

import SwiftUI

struct ReviewPolicyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            // 타이틀
            Text("리뷰 운영 정책")
                .font(
                    Font.custom("Pretendard", size: 17)
                        .weight(.semibold)
                )
                .padding(.bottom, 30)
                .padding(.top, 35)
            
            
            // 소제목
            Text("제 1조 (목적)")
                .font(
                    Font.custom("Pretendard", size: 18)
                        .weight(.medium)
                )
            
            Text("이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.")
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(Color.GrayScale700)
                .frame(width: 343, alignment: .topLeading)
                .padding(.bottom, 30)
            
            Text("제 2조 (이용약관의 효력 및 변경)")
                .font(
                    Font.custom("Pretendard", size: 18)
                        .weight(.medium)
                )
            Text("이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.")
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(Color.GrayScale700)
                .frame(width: 343, alignment: .topLeading)
                .padding(.bottom, 30)
            
            Spacer()
        }
    }
}

struct ReviewPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPolicyView()
    }
}
