//
//  MapStoreMainView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/29.
//

import SwiftUI
import URLImage

struct MapStoreMainView: View {
    @StateObject private var storeVM = StoreVM()
    let storeId: String
    
    @State var store: Restaurant = .init(storeId: "", name: "", category: "", rank: [], score: 0.0, status: nil, reviewCount: 0,                                             time: "", imageUrl: "", reviewImage: nil, reviewContent: nil, isWishlist: nil)
    @State private var isNavigationLinkActive: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                Mapstorefirst(store: $store)
                
                if let unwrappedUrl = store.imageUrl, let url = URL(string: "http://\(unwrappedUrl)") {
                    URLImage(url: url,
                             content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 341, height: 132)
                            .clipped()
                            .cornerRadius(4)
                    })
                } else {
                    Image("map-storeinfo-default")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 341, height: 132)
                        .clipped()
                        .cornerRadius(4)
                }
                Mapstoresecond(store: $store)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(Color.white)
        }
        .onAppear {
            storeVM.mapStoreInfo(storeid: storeId)
            storeVM.taskSuccess
                .sink { _ in
                    store = storeVM.mapStoreInfoData
                }
                .store(in: &storeVM.subscription)
        }
    }
}

//struct MapStoreMainView_Previews: PreviewProvider {
//    @State static var test = Restaurant(storeId: "1", name: "대박맛zip", category: "양식", rank: [Rank(tag: "맛있어요", rank: 3)], score: 3.4, status: true, reviewCount: 120, time: "걸어서 10분", imageUrl: "https://avatars.githubusercontent.com/u/95111999?v=4", reviewImage: nil, reviewContent: "맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.맛이 정말 좋아요.", isWishlist: true)
//    static var previews: some View {
//        MapStoreMainView(store: $test, storeId: <#T##Binding<String>#>)
//    }
//}
