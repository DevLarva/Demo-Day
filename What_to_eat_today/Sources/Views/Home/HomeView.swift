//
//  HomeView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var storeVM = StoreVM()
    
    @State private var isSearchViewActive = false
    @State private var searchText: String = ""
    var rows: [GridItem] = Array(repeating: .init(.fixed(70)), count: 2)
    
    @State private var selectedCategory: String?
    @State private var selectCategory: String?

    struct CategoryItem {
        let image: String
        let text: String
        let destination: (_ selectCategory: Binding<String?>) -> AnyView
    }
    
    let categoryItems: [CategoryItem] = [
           CategoryItem(image: "korea", text: "한식", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "china", text: "중식", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "spageti", text: "양식", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "japan", text: "일식", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "boonsik", text: "분식", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "asia", text: "아시아", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "fastfood", text: "패스트푸드", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "restuarnt", text: "레스토랑", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "cafe", text: "카페", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
           CategoryItem(image: "sul", text: "술집", destination: { AnyView(CategoryMainView(selectCategory: $0))}),
       ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: -5) {
                if let universityName = UserDefaults.standard.string(forKey: "universityName") {
                    CustomNavBarViewsec(title: universityName)
                }
                CustomNavLink(
                    destination: StoreSearchView()
                        .customNavigationTitle("홈")
                        .customNavigationBarBackButtonHidden(false)
                    ,isActive: $isSearchViewActive
                ) {
                    SearchBar(isNavItemActive: $isSearchViewActive)
                }
                
                CustomNavLink(destination: RankingmainView()
                    .customNavigationTitle("홈")
                ) {
                    RankingNavView()
                }
            }
            .padding(.leading)
            
            VStack(alignment: .leading, spacing: 30) {
                LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
                    ForEach(categoryItems, id: \.text) { item in
                        CustomNavCatLink(destination: { item.destination($selectCategory) },
                                         tag: item.text,
                                         selection: $selectCategory
                        ) {
                            VStack(alignment: .center, spacing: 6) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 45, height: 45)
                                .background(
                                    Image(item.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 49.074073791503906)
                                        .clipped()
                                )
                            
                            Text(item.text)
                                .font(
                                    Font.custom("Pretendard", size: 12)
                                        .weight(.medium)
                                )
                                .foregroundColor(.black)
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: -5))
                            
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 14)
                }
            }.padding(.horizontal)
            
            Spacer().frame(height: 20)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 400, height: 8)
                .background(Color.GrayScale100)
            
            VStack {
                RankingZipView(rankingZip: storeVM.rankSampleData)
                    .padding(.leading, 16)
                
            }.padding(.top)
                .padding(.leading, 16)
            
            
                .navigationBarBackButtonHidden(true)
        }
        .toolbar(.visible, for: .tabBar)
        .onAppear {
            storeVM.rankSample()
            storeVM.taskSuccess .sink { _ in
                print(storeVM.rankData)
            }
            .store(in: &storeVM.subscription)
        }
    }
}


//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}


// 랭킹zip 부분 양옆 마진 16으로 위와 동일하게(완)
// 양옆에 하얀 부분 없애기(완)
// 카드에서 하트 위치가 가게 이름이랑 별점 사이에 있게끔 (완)
// 전체랭킹 텍스트 부분 > 부분 이미지로 대체해라(완)

//카드 위아래로 움직이게 하지 마세요. (완)
//카드랑 캡슐이랑 좀 더 여백을 주세요.(완)
//카드끼리의 여백 추가(완)
