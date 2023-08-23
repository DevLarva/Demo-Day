//
//  MainRanking.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/23.
//

import SwiftUI
import URLImage

struct MainRanking: View {
    var store: RankSample
    var defaultImage: String
//    let contents: [String] = ["인테리어 이뻐요", "존맛탱구리", "재방문의사있어요", "친절해요"]
//    var rank: Ranking
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                if let unwrappedUrl = store.imageURL, let url = URL(string: "http://\(unwrappedUrl)") {
                    URLImage(url: url,
                             content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 316, height: 420)
                            .cornerRadius(16)
                    })
                } else {
                    Image(defaultImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 316, height: 420)
                        .cornerRadius(16)
                }
            }
            .overlay(
                Image("gradient")
                    .resizable()
                    .frame(width: 316, height: 420)
            )

                
            Spacer().frame(height: 272)
            
            VStack(alignment: .leading, spacing: 4) {
                
                HStack(alignment: .center, spacing: 8) {
                    Text(store.name).font(.custom("Pretendard-SemiBold", size: 11)).foregroundColor(.white)
                        .kerning(0.25)
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(Color(red: 1, green: 0.3, blue: 0.15).opacity(0.78))
                .cornerRadius(2)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .center, spacing: 8) {
                            Text(store.name).font(.custom("Pretendard-SemiBold", size: 24)).foregroundColor(.white)
                                .font(.title3)
                            Spacer()
                            
                            
                        }
                        
                        
                        HStack(alignment: .center, spacing: 8) {
                            Image("star")
                                .frame(width: 20, height: 20)
                            
                            Text(String(format: "%.1f", store.score))
                                .font(Font.custom("Pretendard", size: 14)
                                    .weight(.medium))
                                .kerning(0.1)
                                .foregroundColor(.GrayScale300)
                            
                            Image("ellipse")
                            
                            Text("걸어서 \(store.time)")
                                .font(Font.custom("Pretendard", size: 14)
                                    .weight(.medium))
                                .kerning(0.1)
                                .foregroundColor(.GrayScale300)
                            
                        }
                        
                        
                    }
                    HStack(alignment: .center) {
                        if(store.isWishlist) {
                            Image("heartfill")
                                .frame(width: 32, height: 32)
                        } else {
                            Image("heart")
                                .frame(width: 32, height: 32)
                        }
                    }.padding()
                }
                
                ScrollView(.horizontal, showsIndicators: false) { //아래쪽 매장 카드 5등
                    HStack(spacing: 10) {
                        ForEach(store.tags, id: \.self) { content in
                            CapsuleDescription(content: content)
                                .font(Font.custom("Pretendard", size: 11))
                                .kerning(0.25)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.GrayScale300)
                        }.background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.2))
                            .cornerRadius(100)
                    }//.contrast(1.2) //대비 일부 조정
                    
                }.padding(.bottom,24)
            }
            .padding()
            
        }
        
        .frame(width: 316, height: 420)
        .cornerRadius(20)
        
      
        
    }
}


//struct MainRanking_Previews: PreviewProvider {
//    static var previews: some View {
//        MainRanking(rank: Ranking(id: "1", storename: "대박맛zip", storecategory: "한식", ranking: "1등", storedistance: "걸어서 10분", heart: true, storestatus: true, storeimage: "matzip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: false, cattag: "한식"))
//    }
//}


struct CapsuleDescription: View {
    var content: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(content)
                .padding(.horizontal, 10)
                .foregroundColor(.GrayScale300)
                .padding(.vertical, 5)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.2))
                .cornerRadius(100)
        }
    }
}
//수정을 하세요.
// 탑1 -> 대밧맛집 -> 리뷰가 있도록
