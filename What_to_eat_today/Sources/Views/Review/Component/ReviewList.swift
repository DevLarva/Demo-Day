//
//  ReviewList.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/04.
//

import SwiftUI
import URLImage

struct ReviewList: View {
    @State var reviewStore: ReviewedStore
    @State var store: Restaurant = .init(storeId: "", name: "", category: "", rank: [], score: 0.0, status: nil, reviewCount: 0, time: "", imageUrl: "", reviewImage: nil, reviewContent: nil, isWishlist: nil)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if let unwrappedUrl = reviewStore.imageUrl, let url = URL(string: "http://\(unwrappedUrl)") {
                    URLImage(url: url,
                             content: { image in
                                 image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipped()
                                    })
                } else {
                    Image("store-default")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipped()
                        .cornerRadius(4)
                }
                Categoryfirst(store: store)
            }
            Categorysecond(store: store)
        }
        .onAppear {
            store = .init(storeId: reviewStore.storeId, name: reviewStore.name, category: "", rank: reviewStore.rank, score: reviewStore.score, status: reviewStore.status, reviewCount: reviewStore.reviewCount, time: reviewStore.time, imageUrl: reviewStore.imageUrl, reviewImage: nil, reviewContent: reviewStore.reviewContent, isWishlist: reviewStore.isWishlist)
        }
    }
}
//struct ReviewList_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewList(rank: Ranking(id: "1", storename: "matzip", storecategory: "한식", ranking: "1등", storedistance: "걸어서 10분", heart: true, storestatus: true, storeimage: "대박맛zip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: false, cattag: "한식"))
//    }
//}
