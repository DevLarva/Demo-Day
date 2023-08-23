//
//  RankingmainView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/23.
//

import SwiftUI

struct RankingmainView: View {
    @StateObject private var storeVM = StoreVM()
    
    @State var rankData: RankingResponse = .init(밥약: [], 가성비: [], 혼밥: [], 단체: [], 술약속: [])
    
    @State private var selectedTitle: String? = "밥약"
    @State private var showMore: Bool = false // 더보기 버튼
    let titles: [String] = ["밥약", "가성비", "혼밥", "단체", "술약속"] //캡슐안에 들어갈 내용
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment:.firstTextBaseline ,spacing: 0) {
                ForEach(titles.prefix(4), id: \.self) { title in
                    CapsuleButton(title: title, isSelected: title == selectedTitle)
                        .onTapGesture {
                            selectedTitle = title
                        }
                }.padding(.horizontal, 2)
                
                
                Button(action: { // 더보기 버튼 눌렸을때
                    showMore.toggle()
                }) {
                    HStack {
                        Image(showMore ? "up" : "down")
                            .frame(width: 24, height: 24)
                    }.offset(x: 10,y:5)
                }
                
            }.padding()
            
            
            if showMore {//더보기 버튼 누를때 보여질 뷰
                HStack {
                    ForEach(titles.dropFirst(4), id: \.self) { title in
                        CapsuleButton(title: title, isSelected: title == selectedTitle)
                            .onTapGesture {
                                selectedTitle = title
                            }
                    }.padding(.leading)
                } //.padding(.horizontal, 8)
                //.padding(.vertical, 0)
            }
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: .infinity, height: 1)
                .background(Color.GrayScale100)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 5) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("우리 학교 ")
                            .font(Font.custom("Pretendard", size: 18))
                            .foregroundColor(.StateError)
                        
                        + Text("\(selectedTitle ?? "")").foregroundColor(.PrimaryOrange300)
                            .font(Font.custom("Pretendard", size: 18))
                        Text("1등~20등까지 모아보기 🔥")
                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                        
                    }.padding()
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(filteredRankingData(), id: \.id) { rankingItem in
                            ScrollView {
                                CustomNavLink(destination: StoreView(storeId: rankingItem.id)
                                    .customNavigationTitle("랭킹")
                                ) {
                                    RankingDetailView(rankData: rankingItem)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            Divider()
                        }
                        .padding()
                    }
                    
                    
                }
            }
            
            
        }.padding(.leading)
            .onAppear {
                storeVM.rank()
                storeVM.taskSuccess .sink { _ in
                    rankData = storeVM.rankData
                }
                .store(in: &storeVM.subscription)
            }
    }
    
    func filteredRankingData() -> [RankStore] {
        guard let selectedTitle = selectedTitle else {
            return []
        }
        
        switch selectedTitle {
        case "밥약":
            return rankData.밥약
        case "가성비":
            return rankData.가성비
        case "혼밥":
            return rankData.혼밥
        case "단체":
            return rankData.단체
        case "술약속":
            return rankData.술약속
        default:
            return []
        }
    }
}



//struct RankingmainView_Previews: PreviewProvider {
//    static var previews: some View {
//        RankingmainView()
//    }
//}

