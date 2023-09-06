//
//  CustomStoreSimpleCell.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/23.
//

import SwiftUI
import URLImage

struct CustomStoreSimpleCell: View {
    
    var store: RecommendStore
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // 이미지
            if let unwrappedUrl = store.imageURL, let url = URL(string: "http://\(unwrappedUrl)") {
                URLImage(url: url,
                         content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 62, height: 62)
                        .clipped()
                        .cornerRadius(6)
                })
            } else {
                Image("store-default")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 62, height: 62)
                    .clipped()
                    .cornerRadius(6)
            }
            // 가게 정보란
            VStack(alignment: .leading, spacing: 4) {
                // 메인 키워드
                Text(store.category)
                    .font(
                        Font.custom("Pretendard", size: 11)
                            .weight(.medium)
                    )
                    .kerning(0.25)
                    .foregroundColor(Color.GrayScale500)
                
                // 가게 이름
                Text(store.name)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.GrayScale900)
                
                HStack(alignment: .center, spacing: 6) {
                    // 가게 별점
                    HStack(alignment: .center, spacing: 2) {
                        Image("starfill")
                            .frame(width: 16, height: 16)
                        
                        Text(String(store.score))
                            .font(
                                Font.custom("Pretendard", size: 12)
                                    .weight(.medium)
                            )
                            .kerning(0.25)
                            .foregroundColor(Color.GrayScale700)
                        
                    }
                    .padding(0)
                    
                    Image("store-dot")
                        .frame(width: 2, height: 2)
                    
                    // 가게 리뷰 수
                    Text(store.reviewCount ?? 0 >= 200 ? "리뷰 200+" : "리뷰 \(store.reviewCount ?? 0)")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(Color.GrayScale700)
                    
                    Image("store-dot")
                        .frame(width: 2, height: 2)
                    
                    // 가게 거리 분류
                    // # 차후 case에 따라 구분 로직 추가
                    Text("걸어서 \(store.time)")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(Color.GrayScale700)
                }
                .padding(0)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            
        }
        .padding(0)
        .frame(width: .infinity, alignment: .leading)
    }
}

