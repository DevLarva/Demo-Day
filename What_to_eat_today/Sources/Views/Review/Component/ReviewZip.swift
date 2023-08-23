//
//  ReviewZip.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/04.
//

import SwiftUI

struct ReviewZip: View {
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            Text("리뷰 작성한 매장")
              .font(
                Font.custom("Pretendard", size: 12)
                  .weight(.medium)
              )
              .kerning(0.25)
              .foregroundColor(Color.GrayScale500)
            
            HStack {
                Text("나의 리뷰가 적혀있어요 🔥")
                    .font(
                        Font.custom("Pretendard", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                
                Spacer().frame(width: 69)
                HStack {
                    CustomNavLink(destination: MyReviewsView()
                        .customNavigationTitle("리뷰")
                                  
                    ) {
                        
                        Text("내가 쓴 리뷰")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.medium)
                            )
                            .kerning(0.1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.GrayScale500)
                        
                        Image("Homechevron-forward")
                            .frame(width: 20, height: 20)
                    }
                }
            }
            Spacer().frame(height: 8)
            VStack {
                Image("line")
                    .frame(width: 343, height: 0)
                    .overlay(
                        Rectangle()
                            .stroke(Color.GrayScale100, lineWidth: 1)
                    )
            }
        }.padding()
    }
}

struct ReviewZip_Previews: PreviewProvider {
    static var previews: some View {
        ReviewZip()
    }
}
