//
//  RankingZipView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/04.
//

import SwiftUI

struct RankingZipView: View {
    let titles: [String] = ["밥약", "가성비", "혼밥", "단체", "술약속"] //캡슐안에 들어갈 내용
    
    @State private var selectedTitle: String = "밥약" // 기본값을 "밥약"으로 설정
    @State var defaultImage: String = ""
    
    var rankingZip: RankSampleResponse
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("랭킹zip")
                    .font(
                        Font.custom("Pretendard", size: 12)
                            .weight(.medium)
                    )
                    .kerning(0.25)
                    .foregroundColor(.GrayScale500)
                HStack(alignment: .center, spacing: 0) {
                    Text("다양한 랭킹은 여기서 🔥").font(
                        Font.custom("Pretendard", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    Spacer()
                    CustomNavLink(destination: RankingmainView()
                        .customNavigationTitle("홈")
                    ) {
                        HStack(alignment: .center, spacing: 2) {
                            Text("전체랭킹")
                                .font(
                                    Font.custom("Pretendard", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(.GrayScale500)
                            Image("Homechevron-forward")
                                .frame(width: 20, height: 20)
                        }.padding(.horizontal)
                        
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(titles, id: \.self) { title in
                                CapsuleButton(title: title, isSelected: title == selectedTitle)
                                    .onTapGesture {
                                        selectedTitle = title
                                    }.onAppear {
                                        if selectedTitle.isEmpty && title == "밥약" {
                                            selectedTitle = title
                                        }
                                    }
                            }
                        }
                    }
                    .frame(height: 50)
                }
            }
            
            // 아래쪽에 있는 이미지에 따라 변경되는 부분
            VStack(alignment: .center, spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        let rankSamples = getSelectedRankSamples(title: selectedTitle)
                        
                        if rankSamples.isEmpty {
                            NonRankingView()
                                .frame(width: 415, height: 401, alignment: .center)
                        } else {
                            ForEach(rankSamples.indices, id: \.self) { index in
                                CustomNavLink(destination:
                                    StoreView(storeId:
                                        rankSamples[index].id)
                                        .customNavigationTitle(rankSamples[index].name)
                                ) { MainRanking(store:
                                    rankSamples[index], defaultImage:
                                    defaultImage)
                                }
                            }
                            .onAppear{
                                switch selectedTitle{
                                case "밥약":
                                    defaultImage = "babyak-default"
                                case "가성비":
                                    defaultImage = "cost-default"
                                case "혼밥":
                                    defaultImage = "solo-default"
                                case "단체":
                                    defaultImage = "group-default"
                                default :
                                     defaultImage = "alcohol-default"
                               }
                            }
                            .onChange(of:selectedTitle) { value in
                                 switch value {
                                 case "밥약":
                                     defaultImage = "babyak-default"
                                 case "가성비":
                                     defaultImage = "cost-default"
                                 case "혼밥":
                                     defaultImage = "solo-default"
                                 case "단체":
                                     defaultImage = "group-default"
                                 default :
                                      defaultImage = "alcohol-default"
                                          
                                      }
                             }
                         }//.ignoresSafeArea(.all)
                     }
                 }.padding(.leading,-25)

            }

            
        }
    }
    
    func getSelectedRankSamples(title: String) -> [RankSample] {
        switch title {
        case "밥약":
            return rankingZip.밥약
        case "가성비":
            return rankingZip.가성비
        case "혼밥":
            return rankingZip.혼밥
        case "단체":
            return rankingZip.단체
        case "술약속":
            return rankingZip.술약속
        default:
            return []
        }
    }
}


//struct RankingZipView_Previews: PreviewProvider {
//    static var previews: some View {
//        RankingZipView()
//    }
//}
