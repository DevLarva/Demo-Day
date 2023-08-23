//
//  CategoryDetailView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/24.
//

import URLImage
import SwiftUI

struct CategoryDetailView: View {
    var store: Restaurant
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if let unwrappedUrl = store.imageUrl, let url = URL(string: "http://\(unwrappedUrl)") {
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
                
                Categoryfirst(store: store) // 컴포넌트(카테고리첫번째)
            }
            Categorysecond(store: store)
            
        }
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(store: Restaurant(storeId: "1", name: "대박맛zip", category: "양식", rank: [Rank(tag: "맛있어요", rank: 3)], score: 3.4, status: true, reviewCount: 120, time: "걸어서 10분", imageUrl: "https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80", reviewImage: nil, reviewContent: "좋아요", isWishlist: true))
    }
}

