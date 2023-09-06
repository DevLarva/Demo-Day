//
//
//  StoreSearchView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/23.
//

import SwiftUI

struct StoreSearchView: View {
    @StateObject private var storeVM = StoreVM()
    
    @State var isSearch = false   /// 검색 여부 T F
    @State var isResult = false   /// 검색 결과 T F
    
    @State var searchText: String = ""  /// 검색어
    @State var SearchResultCnt: Int = 0 /// 검색된 갯수

    @State var selectFilter: SearchFilter = SearchFilter(title: "거리순")// default 값
    
    @State var completedText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar
            // 1. 검색 O 검색 결과 O
            if (isResult) {
                CustomStoreSearchContentBarCell(selectFilter: $selectFilter, SearchResultCnt: $SearchResultCnt)
                    .zIndex(1) //우선 순위 올리기
                    .padding(.horizontal, 16)
            }
            ScrollView {
                // 1. 검색 O 검색 결과 O
                if (isResult) {
                    ForEach(storeVM.searchStoreData.indices, id: \.self) { index in
                        let store = storeVM.searchStoreData[index]
                        CustomNavLink(
                            destination: StoreView(storeId: store.id)
                                .customNavigationTitle(store.name)
                        ) {
                            CustomStoreSimpleCell(store: store)
                        }
                        if index < SearchResultCnt - 1 {
                            Divider().padding(.trailing)
                        }
                    }
                } else { // 2. 검색 O 검색 결과 X
                    if (isSearch) {
                        CustomStoreSearchNothingCell(searchText: completedText)
                            .listRowInsets(EdgeInsets()) //cell 패딩 제거
                    }
                }
                
                // 3. 검색 X
                VStack(alignment: .leading, spacing: 8) {
                    Text("다른 맛집은 어떠세요?")
                        .font(
                            Font.custom("Pretendard", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Color.GrayScale800)
                    ForEach(storeVM.recommendData.indices, id: \.self) { index in
                        let store = storeVM.recommendData[index]
                        CustomNavLink(
                            destination: StoreView(storeId: store.id)
                                .customNavigationTitle(store.name)
                        ) {
                            CustomStoreSimpleCell(store: store)
                        }
                        
                        if index < 4 {
                            Divider().padding(.trailing)
                        }
                    }
                }
                .padding(.top, 16)
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            storeVM.recommendStore()
            storeVM.taskSuccess .sink {
                SearchResultCnt = storeVM.searchStoreData.count
                
                isSearch = true
                if SearchResultCnt != 0 {
                    isResult = true
                }
            }.store(in: &storeVM.subscription)
        }
        .onChange(of: selectFilter) { _ in
            isResult = false
            switch selectFilter.title {
            case "거리순":
                storeVM.searchStore(keyword: searchText, orderby: "distance")
            case "별점순":
                storeVM.searchStore(keyword: searchText, orderby: "score")
            case "리뷰순":
                storeVM.searchStore(keyword: searchText, orderby: "reviewCount")
            default:
                break;
            }
        }
    }
}

/// 추가 뷰
extension StoreSearchView {
    private var SearchBar: some View  {
        VStack {
            RoundedRectangle(cornerRadius: 6, style: .circular)
                .frame(width: UIScreen.main.bounds.width, height: 40)
                .overlay {
                    HStack {
                        Image("search")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.GrayScale700)
                        
                        TextField("오늘의 맛집을 찾아보세요", text: $searchText).font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(.GrayScale500)
                        .onSubmit {
                            completedText = searchText
                            
                            isSearch = false
                            isResult = false
                            switch selectFilter.title {
                            case "거리순":
                                storeVM.searchStore(keyword: searchText, orderby: "distance")
                            case "점수순":
                                storeVM.searchStore(keyword: searchText, orderby: "score")
                            case "리뷰순":
                                storeVM.searchStore(keyword: searchText, orderby: "reviewCount")
                            default:
                                break;
                            }
                        }
                        Spacer()
                        
                    }.padding()
                }.foregroundColor(.GrayScale100)
        }.padding()
    }
}

///
extension StoreSearchView {
    
}

struct StoreSearchView_Previews: PreviewProvider {
    static var previews: some View {
        StoreSearchView(SearchResultCnt: 4)
    }
}
