//
//  Mapstoresecond.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/29.
//

import SwiftUI

struct Mapstoresecond: View {
    @Binding var store: Restaurant
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            
            if (store.reviewCount != 0 && store.reviewContent != nil) {
                Text(store.reviewContent!)
                    .font(Font.custom("Pretendard", size: 12))
                    .foregroundColor(.GrayScale700)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            } else {
                HStack {
                    Image("alert-circle")
                        .frame(width: 16, height: 16)
                    Text("리뷰를 준비중입니다. 첫 리뷰를 남겨주세요")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.GrayScale700)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
        }.padding(12)
            .frame(width: 343, alignment: .leading)
            .background(Color.GrayScale100)
            .cornerRadius(4)
    }
}

struct Mapstoresecond_Previews: PreviewProvider {
    @State static var test = Restaurant(storeId: "1", name: "대박맛zip", category: "양식", rank: [Rank(tag: "맛있어요", rank: 3)], score: 3.4, status: true, reviewCount: 120, time: "걸어서 10분", imageUrl: "https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80", reviewImage: nil, reviewContent: "맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.", isWishlist: true)
    static var previews: some View {
        Mapstoresecond(store: $test)
    }
}
