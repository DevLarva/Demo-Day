//
//  PickView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/04.
//

import SwiftUI

struct PickView: View {
    @StateObject private var storeVM = StoreVM()
    
    @State var pickCnt: Int = 0
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            if pickCnt > 0 {
                pickHeader
                pickContents
            } else {
                NonPickView()
            }
        }
        .onAppear {
            storeVM.getWishlist()
            storeVM.taskSuccess .sink {
                pickCnt = storeVM.wishlistData.count
            }
            .store(in: &storeVM.subscription)
        }
    }
}

extension PickView {
    private var pickHeader: some View {
        VStack {
            HStack(alignment: .top) {
                // Space Between
                if let universityName = UserDefaults.standard.string(forKey: "universityName") {
                    Text(universityName)
                        .font(
                            Font.custom("Pretendard", size: 20)
                                .weight(.semibold)
                        )
                }
                Spacer()
                // Alternative Views and Spacers
                Image("notifications")
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 17)
            .frame(width: .infinity, height: 58, alignment: .top)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center) {
                    Text("총 \(pickCnt)개")
                        .font(
                            Font.custom("Pretendard", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(Color.GrayScale800)
                }
                .padding(0)
                .frame(width: 52, alignment: .center)
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color.GrayScale300)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(width: .infinity, alignment: .topLeading)
        }
    }
    
    private var pickContents: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(0..<pickCnt, id: \.self) { idx in
                    CategoryDetailView(store: storeVM.wishlistData[idx])
                    if (idx != pickCnt - 1) {
                        Rectangle()
                            .frame(width: .infinity, height: 1)
                            .foregroundColor(Color.GrayScale200)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        }
        .refreshable {
            await refresh()
        }
    }
    
    @MainActor func refresh() async {
        storeVM.getWishlist()
    }
}

//struct PickView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickView()
//    }
//}


//위쪽 디바이더 부분 끝까지
//디바이더 아래쪽 스크롤 할때 없애주세요.
