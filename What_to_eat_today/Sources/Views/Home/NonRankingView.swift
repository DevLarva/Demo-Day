//
//  NonRankingView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/12.
//

import SwiftUI

struct NonRankingView: View {
    var body: some View {
        ZStack {
            Color.GrayScale50.ignoresSafeArea(.all)
            VStack(alignment: .center, spacing: 20) {
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 60, height: 60)
                    .background(
                        Image("myreview-none")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipped()
                    )
                
                Text("랭킹이 준비중이에요,,")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.GrayScale900)
                
                
                
                Text("나만 알기 아까운 맛집을 알려주세요!\n대학생 찐 리뷰를 담기하여 대학생 인증 후\n후기 작성이 가능합니다.")
                    .font(Font.custom("Pretendard", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale500)
            }
            .padding(.horizontal, 0)
            .padding(.top, 80)
            .padding(.bottom, 40)
           
        }
        
    }
}

struct NonRankingView_Previews: PreviewProvider {
    static var previews: some View {
        NonRankingView()
    }
}
