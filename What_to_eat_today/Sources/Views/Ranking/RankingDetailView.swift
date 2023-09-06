//
//  RankingDetailView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/23.
//

import SwiftUI

struct RankingDetailView: View {
    var rankData: RankStore
    var rankIndex: Int
    var body: some View {
        HStack(alignment: .top) {
            Image(rankData.imageURL ?? "store-default")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 108)
                .cornerRadius(4)
                .clipped()


            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Rankingfirst(rankData: rankData, rank : rankIndex)
                }.frame()


                HStack {
                    Rankingsecond(rankData: rankData)
                }
            }
            
        }
        
    }
}


//struct RankingDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RankingDetailView(rank: Ranking(id: "1", storename: "대박맛zip", storecategory: "한식", ranking: "1등", storedistance: "걸어서 10분", heart: true, storestatus: true, storeimage: "matzip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: false, cattag: "한식"))
//    }
//}


