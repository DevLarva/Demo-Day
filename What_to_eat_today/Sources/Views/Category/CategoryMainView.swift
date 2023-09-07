//
//  CategoryMainView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/24.
//
import SwiftUI


struct CategoryMainView: View {
    @StateObject private var storeVM = StoreVM()
    //    var store: Restaurant
    let titles: [String] = ["한식", "중식", "양식", "일식", "카페", "술집", "분식", "아시아", "패스트푸드", "레스토랑"]
    var ranks : [Ranking] = rankingData // 데이터 불러옴
    @State private var showMore: Bool = false
    @Binding var selectCategory: String?
    @State private var isFilterFlag: Bool = false
    @State private var selectFilter: SearchFilter = SearchFilter(title: "거리순")// default 값
    //    @State private var selectFilter: SearchFilter = SearchFilter(title: "거리순")// default 값
    //    @Binding var SearchResultCnt: Int
    private var selectedCategory: String? {
        get { selectCategory }
        set { selectCategory = newValue }
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment:.firstTextBaseline ,spacing: 0) {
                
                ForEach(titles.prefix(4), id: \.self) { title in
                    CapsuleButton(title: title, isSelected: title == selectedCategory)
                        .onTapGesture {
                            selectCategory = title
                        }
                }.padding(.horizontal, 2)
                
                
                Button(action: {
                    showMore.toggle()
                }) {
                    HStack {
                        Image(showMore ? "up" : "down")
                            .frame(width: 24, height: 24)
                    }
                    .offset(x: 5, y: 5)
                }
            }.padding()
            if showMore {
                HStack(alignment:.firstTextBaseline ,spacing: 0) {
                    ForEach(titles.dropFirst(4).prefix(4), id: \.self) { title in
                        CapsuleButton(title: title, isSelected: title == selectedCategory)
                            .onTapGesture {
                                selectCategory = title
                            }
                    }.padding(.leading)
                }
                
                
                
                
                
                HStack(alignment:.firstTextBaseline ,spacing: 8) {
                    ForEach(titles.dropFirst(8), id: \.self) { title in
                        CapsuleButton(title: title, isSelected: title == selectedCategory)
                            .onTapGesture {
                                selectCategory = title
                            }
                    }.padding(.leading)
                }
                
            }
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: .infinity, height: 1)
                .background(Color.GrayScale100)
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {  //이후에 필터 컴포넌트 추가X
                        VStack(alignment: .leading, spacing: 5) {
                            Text("우리 학교 ")
                                .font(Font.custom("Pretendard", size: 18))
                                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                            + Text("\(selectedCategory ?? "")").foregroundColor(.PrimaryOrange300)
                                .font(Font.custom("Pretendard", size: 18))
                            + Text(" 카테고리")
                                .font(Font.custom("Pretendard", size: 18))
                                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                            Text("내 취향으로 모아보기 🔥")
                                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                        }
                        .padding()
                        // MARK: - 필터
                        Spacer()
                        
                        ZStack {
                            Button(action: {
                                isFilterFlag.toggle()
                            }) {
                                HStack(alignment: .center, spacing: 3) {
                                    Text("필터")
                                        .font(Font.custom("Pretendard", size: 12))
                                        .foregroundColor(Color.GrayScale800)
                                    Image(isFilterFlag ? "store-filter-on" : "store-filter-off")
                                        .frame(width: 19, height: 19)
                                }.zIndex(1)
                                    .padding(0)
                            }
                            .buttonStyle(PlainButtonStyle()) // Add this line
                            .overlay(alignment: .topTrailing) {
                                VStack {
                                    if isFilterFlag {
                                        Spacer(minLength: 20)
                                        SearchFilterMenuList(selectFilter: $selectFilter) { filter in
                                            isFilterFlag = false
                                            
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.trailing, 16)
                    }.zIndex(1)
                    VStack(alignment: .leading, spacing: 0) {
                        if isCategoryDataEmpty() {
                            CategoryDefultView()
                        } else {
                            ForEach(storeVM.categorys.filter {selectedCategory == nil || $0.category == selectedCategory }) { restaurant in
                                CustomNavLink(destination: StoreView(storeId: restaurant.storeId)
                                    .customNavigationTitle("카테고리")
                                ) {
                                    CategoryDetailView(store: restaurant)
                                }
                                Divider().padding()
                            }
                            .padding(.leading)
                            
                               
                        }
                    }
                }.padding(.leading)
                
            }
        } .onAppear {
            
            storeVM.categorys(orderby: "distance")
            print(storeVM.categoryData)
        }
    }
    func isCategoryDataEmpty() -> Bool {    //카테고리 데이터 있는지 없는지 검사 함수
        return storeVM.categorys.filter {selectedCategory == nil || $0.category == selectedCategory }.isEmpty
    }
}





//struct CategoryMainView_Previews: PreviewProvider {
////    @State static var testResultCnt: Int = 4
//    static var previews: some View {
//        CategoryMainView(selectCategory: .constant("한식"))
//        ////SearchResultCnt: $testResultCnt
//    }
//}

//한식 중식 양식 일식 앞쪽 리딩 부분 마진 추가
//펼쳐보기 했을대 Divider 나오게끔 다시 수정, 화살표 위치 수정(완)
//양옆 마진을 16으로(다시)
