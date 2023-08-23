    //
    //  Rankingsecond.swift
    //  What_to_eat_today
    //
    //  Created by 백대홍 on 2023/07/28.
    //

    import SwiftUI

    struct Rankingsecond: View {
        var rankData: RankStore
        var body: some View {
            HStack(alignment: .center, spacing: 4) {
                if (rankData.reviewCount ?? 0) > 0 {
                    Text(rankData.reviewContent ?? "0")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.GrayScale700)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                } else {
                    HStack {
                        Image("alert-circle")
                            .frame(width: 16, height: 16)
                        Text("리뷰를 준비중입니다. 첫 리뷰를 남겨주세요:)")
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(.GrayScale700)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    
                }
            }
            .padding(.horizontal, 11)
            .padding(.vertical, 8)
            .frame(width: 265, height: 56, alignment: .leading)
            .background(Color.GrayScale100)
            .cornerRadius(4)
        }
    }

    //struct Rankingsecond_Previews: PreviewProvider {
    //    static var previews: some View {
    //        Rankingsecond(rank: Ranking(id: "1", storename: "대박맛zip", storecategory: "한식", ranking: "1등", storedistance: "걸어서 10분", heart: true, storestatus: true, storeimage: "matzip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: true, cattag: "한식"))
    //    }
    //}
    // 이미지 ! 넣기
