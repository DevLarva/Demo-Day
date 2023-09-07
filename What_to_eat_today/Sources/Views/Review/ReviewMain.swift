//
//  ReviewMain.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/04.
//

import SwiftUI

struct ReviewMain: View {
    @StateObject private var storeVM = StoreVM()
    
    @State private var searchText: String = ""
    @State private var showReviewWriteView = false
    var body: some View {
        ZStack {
            if showReviewWriteView {
                ReviewWrite(showReviewWriteView: $showReviewWriteView)
            } else {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: -5) {
                            if let universityName = UserDefaults.standard.string(forKey: "universityName") {
                                CustomNavBarViewsec(title: universityName)
                            }
                            Reviewnav()
                                .padding(.bottom)
                                .padding(.leading)
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 8)
                                .background(Color.GrayScale100)
                        }.padding()
                        ReviewZip()
                        VStack(alignment: .leading) {
                            ForEach(storeVM.reviewStoreData.indices, id: \.self) { index in
                                
                                


                                CustomNavLink(destination: StoreView(storeId: storeVM.reviewStoreData[index].id)
                                    .customNavigationTitle(storeVM.reviewStoreData[index].name)
                                ) {
                                    ReviewList(reviewStore: storeVM.reviewStoreData[index])
                                        .padding(.leading, 32)
                                }
                                

                                if index < storeVM.reviewStoreData.count - 1 {
                                    Divider()
                                        .padding(.top)
                                        .padding(.bottom)
                                        .padding(.horizontal)
                                }
                            }
                        }.padding()
                        
                    }
                    .refreshable {
                        await refresh()
                    }
                    Button(action: {
                        showReviewWriteView.toggle()
                    }) {
                        ReviewButton()
                            .padding(.bottom)
                    }
                }
            }
        }
        .onAppear {
            storeVM.reviewedStores()
            storeVM.taskSuccess .sink {
                print(storeVM.reviewStoreData)
            }
            .store(in: &storeVM.subscription)
        }
    }
    @MainActor func refresh() async {
        storeVM.getWishlist()
    }
}

struct ReviewMain_Previews: PreviewProvider {
    static var previews: some View {
        ReviewMain()
    }
}


//디바이더의 크기가 위에 있는 컴포넌트 사이즈랑 동일하게. (완)
//검색 + Nav + 디바이더 위치 마진 24로 통일 (완)

