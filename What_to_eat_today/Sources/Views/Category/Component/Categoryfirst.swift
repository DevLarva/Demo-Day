//
//  Categoryfirst.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/28.
//

import SwiftUI

struct Categoryfirst: View {
    var store: Restaurant
    @StateObject private var storeVM = StoreVM()
    @State var isWishlist: Bool = true
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(store.name)
                    .font(
                        Font.custom("Pretendard", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(.GrayScale900)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                
                Text(store.category)
                    .font(
                        Font.custom("Pretendard", size: 11)
                            .weight(.medium)
                    )
                    .kerning(0.25)
                    .foregroundColor(.GrayScale500)
                
                
            }.frame(width: 225, height: 26, alignment: .leading)
           
            
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
                
                Spacer().frame(width: 52)
                
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {
                        isWishlist.toggle()
                    }) {
                        HStack(alignment: .center, spacing: 8) {
                            Image(isWishlist ? "heartfill" : "heart")
                                .frame(width: 32, height: 32)
                        }.padding(.trailing)
                            .frame(width: 32, height: 32, alignment: .center)
                        
                    }
                }.padding(.trailing)
                
                .onAppear {
                    if let isWish = store.isWishlist {
                        isWishlist = isWish
                    }
                }
                .onChange(of: isWishlist){ _ in
                    storeVM.toggleWishList(storeId: store.storeId, isLike: isWishlist)
                }
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
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .cornerRadius(2)
            
        }
        
    }
}

struct Categoryfirst_Previews: PreviewProvider {
    static var previews: some View {
        Categoryfirst(store: Restaurant(storeId: "1", name: "대박맛zip", category: "양식", rank: [Rank(tag: "맛있어요", rank: 3)], score: 3.4, status: true, reviewCount: 120, time: "걸어서 10분", imageUrl: "https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80", reviewImage: nil, reviewContent: "좋아요", isWishlist: true))
    }
}
