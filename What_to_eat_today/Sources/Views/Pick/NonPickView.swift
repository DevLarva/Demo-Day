//
//  NonPickView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/12.
//

import SwiftUI

struct NonPickView: View {
    
    var body: some View {
        ZStack {
            Color.GrayScale50
                .ignoresSafeArea(.all)
            VStack(alignment: .center, spacing: 24) {
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 60, height: 60)
                        .background(
                            Image("Fish Cake With Swirl")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipped()
                        )
                }
                .padding(0)
                .frame(width: 60, height: 60, alignment: .center)
                
                
                Text("찜해놓은\n맛집이 없습니다.")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale900)
                
                
                Text("우리학교 맛집을 찾아볼까요?")
                  .font(Font.custom("Pretendard", size: 16))
                  .multilineTextAlignment(.center)
                  .foregroundColor(.GrayScale500)
                
                Spacer().frame(height: 320)
                
                CustomNavLink(destination: RankingmainView()
                    .customNavigationTitle("")
                ) {
                    HStack(alignment: .top, spacing: 0) {
                        
                        Text("랭킹으로")
                            .font(
                                Font.custom("Pretendard", size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.BlackWhiteWhite)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 0)
                    .frame(width: 343, height: 56, alignment: .center)
                    .background(Color.PrimaryOrange300)
                    .cornerRadius(8)
                }
            }
        }
     
    }
}

//struct NonPickView_Previews: PreviewProvider {
//    static var previews: some View {
//        NonPickView()
//    }
//}
