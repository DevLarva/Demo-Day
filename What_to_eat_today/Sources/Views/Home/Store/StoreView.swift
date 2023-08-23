//
//  StoreView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/13.
//

import SwiftUI

struct StoreView:View {
    @StateObject private var storeVM = StoreVM()
    var storeId: String
    
    @State var storeinfo: StoreDetailResponse = .init(storeName: "", category: "", imageUrl: nil, keywords: [], tags: [:], status: nil, phoneNumber: nil, address: "", time: "", imageCount: 0, x: 0.0, y: 0.0)
   
    @State var convertedRankingData: [StoreRankingData] = []
    @State var isActive = false
    //json 가져와서 걔를 풀고 store
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    StoreImageContentView(imageCount: storeinfo.imageCount)
                    StoreNameView(storeName: storeinfo.storeName, category: storeinfo.category)
                    StoreRankingView(rankingData: convertedRankingData)
                    VStack(alignment: .center, spacing: 24) {
                        StoreDetailView(address: storeinfo.address, time: storeinfo.time)
                        StoreMapView()
                        Rectangle() // 구분선
                            .foregroundColor(.clear)
                            .frame(width: .infinity, height: 8)
                            .background(Color.GrayScale100)
                        if (true) { // 차후 리뷰가 있을 경우 없을 경우 따지기
                            StoreKeywordView()
                        }
                        StoreReviewView(storeId: storeId)
                    }
                    
                    .padding(.horizontal, 0)
                    .padding(.top, 16)
                    .padding(.bottom, 0)
                }
                
            }
            .toolbar(.hidden, for: .tabBar)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, 80)
            VStack(alignment: .center, spacing: 8) {
                HStack(alignment: .top, spacing: 8) {
                    //하트
                    Button(action: {
                        
                    }) {
                        HStack(alignment: .center, spacing: 0) {
                            Image("heart")
                                .frame(width: 32, height: 32)
                        }
                        .padding(0)
                        .frame(width: 56, height: 56, alignment: .center)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale200, lineWidth: 1)
                        )
                    }
                    //리뷰 쓰기 버튼
                    CustomNavLink(destination: StoreReviewWrite(storeId: storeId)
                        .customNavigationTitle("리뷰 쓰기")
                        , isActive: $isActive
                    ){
                        Button(action: {
                            isActive = true
                        }) {
                            HStack(alignment: .center, spacing: 2) {
                                // Title/Title S | 16px
                                Text("리뷰적기")
                                    .font(
                                        Font.custom("Pretendard", size: 16)
                                            .weight(.medium)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.BlackWhiteWhite)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 0)
                            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                            .background(Color.PrimaryOrange300)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .frame(width: UIScreen.main.bounds.width, height: 56, alignment: .topLeading)
            }
            .padding(.horizontal, 0)
            .padding(.top, 12)
            .padding(.bottom, 0)
            .background(Color.BlackWhiteWhite)
            .shadow(color: .black.opacity(0.06), radius: 7.5, x: 0, y: 0)
        }
        .onAppear {
            storeVM.storeDetail(id: storeId)
            storeVM.storeInfoSuccess .sink { _ in
                storeinfo = storeVM.storeDetailData
                convertedRankingData = {
                    storeinfo.keywords.map { keyword -> StoreRankingData in
                        let imageName = StoreRankingElementView.imageName(from: keyword.tag)
                        return StoreRankingData(imageName, keyword.tag, keyword.rank)
                    }
                }()
            }
            .store(in: &storeVM.subscription)
        }
    }
}

//struct StoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreView()
//    }
//}



