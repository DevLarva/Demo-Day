//
//  CustomStoreSimpleCell.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/23.
//

import SwiftUI

struct CustomStoreSimpleCell: View {
    
    var store: Store
    var isOpen: Bool {
        let currentTime = Date()
        return (store.openTime...store.closeTime).contains(currentTime)
    }
    
    var body: some View {
        Button(action: {
            // StoreView()
        }) {
            HStack(alignment: .center, spacing: 8) {
                // 이미지
                Image(store.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 62, height: 62)
                    .clipped()
                    .cornerRadius(6)
                // 가게 정보란
                VStack(alignment: .leading, spacing: 4) {
                    // 메인 키워드
                    Text(store.mainKeyword)
                        .font(
                            Font.custom("Pretendard", size: 11)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(Color.GrayScale500)
                    
                    // 가게 이름
                    Text(store.name)
                        .font(
                            Font.custom("Pretendard", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Color.GrayScale900)
                    
                    HStack(alignment: .center, spacing: 6) {
                        // 가게 상태
                        Text(isOpen ? "영업중" : "영업 종료")
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(Color.GrayScale700)
                        
                        Image("store-dot")
                            .frame(width: 2, height: 2)
                        
                        // 가게 별점
                        HStack(alignment: .center, spacing: 2) {
                            Image("starfill")
                                .frame(width: 16, height: 16)
                            
                            Text(store.star.description)
                                .font(
                                    Font.custom("Pretendard", size: 12)
                                        .weight(.medium)
                                )
                                .kerning(0.25)
                                .foregroundColor(Color.GrayScale700)
                            
                        }
                        .padding(0)
                        
                        Image("store-dot")
                            .frame(width: 2, height: 2)
                        
                        // 가게 리뷰 수
                        Text(store.reviewCnt >= 200 ? "리뷰 200+" : "리뷰 \(store.reviewCnt)")
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(Color.GrayScale700)
                        
                        Image("store-dot")
                            .frame(width: 2, height: 2)
                        
                        // 가게 거리 분류
                        // # 차후 case에 따라 구분 로직 추가
                        Text("걸어서 \(store.distanceType)분")
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(Color.GrayScale700)
                        
                    }
                    .padding(0)
                    
                    
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                
            }
            .padding(0)
            .frame(width: .infinity, alignment: .leading)
        }
    }
}

struct CustomStoreSimpleCell_Previews: PreviewProvider {
    @State static var test = Store(id: "2",
                                   name: "가게2",
                                   address: "주소2",
                                   phoneNumber: "010-2222-2222",
                                   ranking: "1등",
                                   openTime: Store.specificTime(hour: 10, minute: 0),
                                   closeTime: Store.specificTime(hour: 20, minute: 0),
                                   star: 3.0,
                                   reviewCnt: 30,
                                   coordinateX: 37.54321,
                                   coordinateY: 126.12345,
                                   distanceType: 10,
                                   imageURL: "Store-image2",
                                   mainKeyword: "일식",
                                   storedistance: "걸어서 5분",
                                   heart: true,
                                   storestatus: true)
    static var previews: some View {
        CustomStoreSimpleCell(store: test)
    }
}

// 검색결과, 다른 맛집 어떠세요? 밑 구분선 ignore
// 가게 이미지 라운드 4 잡아야 함
//
