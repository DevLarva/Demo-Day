//
//  Mapstorefirst.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/29.
//

import SwiftUI

struct Mapstorefirst: View {
    @StateObject private var storeVM = StoreVM()
    @Binding var store : Restaurant
    
    @State var isWishlist: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(store.name)
                        .font(
                            Font.custom("Pretendard", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(.GrayScale900)
                    Text(store.category)
                        .font(
                            Font.custom("Pretendard", size: 11)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(.GrayScale500)
                }
                
                HStack(alignment: .center, spacing: 6) {
                    Image("starfill")
                        .frame(width: 16, height: 16)
                    Text(String(format: "%.1f", store.score))
                        .font(
                            Font.custom("Pretendard", size: 12)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(.GrayScale700)
                    
                    Image("ellipse")
                        .frame(width: 2, height: 2)
                        .background(Color.GrayScale300)
                    
                    let roundedNumber = (store.reviewCount / 100) * 100
                    let displayText: String = store.reviewCount > roundedNumber ? "\(roundedNumber)+" : String(store.reviewCount)
                    //리뷰 카운트 -> 간단하게 보여주기 위한 로직
                    Text("리뷰 " + displayText)
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.GrayScale700)
                    
                    Image("ellipse")
                        .frame(width: 2, height: 2)
                        .background(Color.GrayScale300)
                    Text("걸어서 \(store.time)")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.GrayScale700)
                }.padding(0)
                
                HStack(alignment: .center, spacing: 8) {
                    if !store.rank.isEmpty {
                        ForEach(store.rank, id: \.self) { rank in
                            HStack {
                                Text("\(rank.tag) \(rank.rank)등")
                                    .font(
                                        Font.custom("Pretendard", size: 11)
                                            .weight(.semibold)
                                    )
                                    .kerning(0.25)
                                    .foregroundColor(rank.rank <= 3 ? .PrimaryOrange300 : .GrayScale700)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 6)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .inset(by: 0.5)
                                    .stroke(rank.rank <= 3 ? Color.PrimaryOrange300 : Color.GrayScale400, lineWidth: 1)
                            )
                        }
                    }
                }
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            Button(action: {
                isWishlist.toggle()
            }) {
                HStack(alignment: .center, spacing: 8) {
                    Image(isWishlist ? "heartfill" : "heart")
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32, alignment: .center)
            }
        }.padding(0)
        .frame(width: 343, alignment: .leading)
        .onAppear {
            if let isWish = store.isWishlist {
                isWishlist = isWish
            }
        }
        .onChange(of: isWishlist){ _ in
            storeVM.toggleWishList(storeId: store.storeId, isLike: isWishlist)
        }
    }
}

struct Mapstorefirst_Previews: PreviewProvider {
    @State static var test = Restaurant(storeId: "1", name: "대박맛zip", category: "양식", rank: [Rank(tag: "맛있어요", rank: 3)], score: 3.4, status: true, reviewCount: 120, time: "걸어서 10분", imageUrl: "https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80", reviewImage: nil, reviewContent: "좋아요", isWishlist: true)
    static var previews: some View {
        Mapstorefirst(store: $test)
    }
}


