//
//  Rankingfirst.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/28.
//

import SwiftUI

struct Rankingfirst: View {
    var rankData: RankStore
    @StateObject private var storeVM = StoreVM()
    var rank: Int //등수
    @State var isWishlist: Bool = true
    var body: some View {
        
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center) {
                    Text("\(rank)등")
                        .font(
                            Font.custom("Pretendard", size: 11)
                                .weight(.semibold)
                        )
                        .kerning(0.25)
                        .foregroundColor(.PrimaryOrange300)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .cornerRadius(2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .inset(by: 0.5)
                                .stroke(Color.PrimaryOrange300, lineWidth: 1)
                        )
                    
                    
                    Text(rankData.name)
                        .font(
                            Font.custom("Pretendard", size: 18)
                                .weight(.medium)
                        )
                        .lineLimit(1) // 길어지면 ...으로 처리
                        .foregroundColor(.GrayScale900)
                        
                    
                    Text(rankData.category)
                        .font(
                            Font.custom("Pretendard", size: 11)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(.GrayScale500)
                    Spacer() // 추가된 코드
                    
                }.padding(0)
                
                
                HStack(alignment: .center, spacing: 6) {
                    
                    Image("starfill")
                        .frame(width: 16, height: 16)
                    Text(String(format: "%.1f", rankData.score))
                        .font(
                            Font.custom("Pretendard", size: 12)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(.GrayScale700)
                    
                    Image("ellipse")
                        .frame(width: 2, height: 2)
                        .background(Color.GrayScale300)
                    
                    let roundedNumber = ((rankData.reviewCount ?? 0) / 100) * 100
                    HStack(alignment: .center, spacing: 4) {
                        // 리뷰 카운트
                        Text("리뷰 " + reviewDisplayText(for: rankData))
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(.GrayScale700)
                    }
                    Image("ellipse")
                        .frame(width: 2, height: 2)
                        .background(Color.GrayScale300)
                    Text(rankData.time)
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.GrayScale700)
                    
                    
                }.padding(0)
                    
            }
            .frame(width: 225, height: 50)
            
            Spacer().frame(width: 5)
            
            VStack {
                    HStack(alignment:.center ,spacing :0){
                        Button(action:{
                            storeVM.toggleWishList(storeId : rankData.id)
                        }) {
                            Image(storeVM.wishListStatus[rankData.id] ?? false ? "heartfill" : "heart")
                                .frame(width :32 , height :32)
                        }
                    }
                }
            .onAppear {
                      storeVM.getWishlist()  // getWishlist 함수 호출하여 wishListStatus 갱신
                  }
        }
        .padding(0)
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
    }
    func reviewDisplayText(for rankData: RankStore) -> String {
        // 리뷰 카운트 로직
        if let reviewCount = rankData.reviewCount {
            let roundedNumber = (reviewCount / 100) * 100
            return reviewCount > roundedNumber ? "\(roundedNumber)+" : String(reviewCount)
        } else {
            return "0" // 또는 원하는 기본값 사용
        }
    }
    
}

//struct Rankingfirst_Previews: PreviewProvider {
//    static var previews: some View {
//        Rankingfirst(rank: Ranking(id: "1", storename: "대박맛zip", storecategory: "한식", ranking: "1등", storedistance: "걸어서 10분", heart: true, storestatus: true, storeimage: "matzip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: false, cattag: "한식"))
//    }
//}
