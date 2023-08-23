//
//
//  StoreSearchView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/23.
//

import SwiftUI

struct StoreSearchView: View {
    
    let stores = Stores() // 서버로부터 받아올 모델 데이터들
    var isSearch = true   // 검색 여부 T F
    var isResult = true   // 검색 결과 T F
    @State var SearchResultCnt: Int = 5 // 서버로부터 받아오는 값
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            SearchBar()
            // 1. 검색 O 검색 결과 O
            if (isResult) {
                CustomStoreSearchContentBarCell(SearchResultCnt: $SearchResultCnt)
                    .zIndex(1) //우선 순위 올리기
                    .padding(.horizontal, 16)
            }
            ScrollView {
                // 1. 검색 O 검색 결과 O
//                if (isResult) {
//                    ForEach(0..<stores.stores.count, id: \.self) { idx in
//                        CustomNavLink(
//                            destination: StoreView()
//                                .customNavigationTitle("가게")
//                                .customNavigationBarBackButtonHidden(false)
//                        ) {
//                            CustomStoreSimpleCell(store: stores.stores[idx])
//
//                        }
//
//                    }
//
//                } else {
                    // 2. 검색 O 검색 결과 X
//                    if (isSearch) {
//                        CustomStoreSearchNothingCell()
//                            .listRowInsets(EdgeInsets()) //cell 패딩 제거
//                    }
                    // 3. 검색 X
                    VStack(alignment: .leading, spacing: 8) {
                        Text("다른 맛집은 어떠세요?")
                            .font(
                                Font.custom("Pretendard", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color.GrayScale800)
                        
//                        ForEach(0...4, id: \.self) { idx in
//                            CustomNavLink(
//                                destination: StoreView()
//                                    .customNavigationTitle("랜덤가게")
//                                    .customNavigationBarBackButtonHidden(false)
//                            ) {
//                                CustomStoreSimpleCell(store: stores.stores[idx])
//
//
//                            }
//
//
//                            if idx < 4 {
//                                Divider().padding(.trailing)
//                            }
                            
                            
                            
                        }
                    }
                }
            } //.padding(.leading)
        }
//        .listStyle(PlainListStyle())
//    }
//}

struct StoreSearchView_Previews: PreviewProvider {
    static var previews: some View {
        StoreSearchView(SearchResultCnt: 4)
    }
}


// 김밫에 대한 ~~~ 박스 마진 없게 끝까지 + 텍스트 가운데 정렬로 수정하셍
//
