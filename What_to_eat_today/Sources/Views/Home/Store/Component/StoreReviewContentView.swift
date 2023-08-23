//
//  StoreReviewContentView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/14.
//

import SwiftUI
import URLImage

struct StoreReviewContentView: View {
    @StateObject private var storeVM = StoreVM()
    
    var review: Review
    @State private var reviewImages: [String] = []
    @State private var isFilterFlag: Bool = false
//    @State private var selectFilter: SearchFilter = SearchFilter(title: "거리순")// default 값
    @State private var reviewRcmndClick: Bool = false
    @State private var showContextMenu = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            // 리뷰 헤더(프로필 이미지 + 닉네임 + 별점 + 설정?)
            HStack(alignment: .center, spacing: 8) {
                // 프로필 이미지
                if let unwrappedUrl = review.userImage, let url = URL(string: "http://\(unwrappedUrl)") {
                    URLImage(url: url,
                             content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28, height: 28)
                            .cornerRadius(100)
                            .clipped()
                    })
                } else {
                    Image("profile-default")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .cornerRadius(100)
                        .clipped()
                }
                
                // 닉네임
                Text(review.nickname)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.13))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                // 별점 (ForEach 문으로 별점 설정)
                HStack(alignment: .center, spacing: 4) {
                    
                    // ViewBuilder 때문에 ForEach 사용
                    ForEach(0..<Int(review.score), id: \.self) { _ in
                        Image("store-star")
                            .frame(width: 16, height: 16)
                    }
                }
                .padding(0)
                
                // 메뉴 리뷰 # 수정 필요
                // uid와 현재 uid가 동일한 경우 (자기 리뷰)
                // uid가 현재 uid와 다른 경우 (다른사람 리뷰)
                ZStack {
                    Button(action: {
                        isFilterFlag.toggle()
                    }) {
                        HStack(alignment: .center, spacing: 3) {
                            Image("store-threedot")
                                .frame(width: 19, height: 19)
                        }
                        .padding(0)
                    }
                    .buttonStyle(PlainButtonStyle()) // Add this line
                    .overlay(alignment: .topTrailing) {
                        VStack {
                            if isFilterFlag {
                                if let nickname = UserDefaults.standard.string(forKey: "userNickname") {
                                    if (review.nickname == nickname) {
                                        MyReviewMenuList { filter in
                                            isFilterFlag = false
                                            if(filter.title == "삭제") {
                                                storeVM.deleteReview(reviewid: review.id)
                                                print("삭제")
                                            } else {
                                                print("수정은 미구현")
                                            }
                                        }
                                    } else {
                                        OtherReviewMenuList { filter in
                                            isFilterFlag = false
                                            /// 신고완료 Alert
                                        }
                                    }
                                }
                            }
                        }.zIndex(1)
                    }
                    .background(Color.white) // 이 부분을 추가해주세요
                    .opacity(1) // 이 부분을 추가해주세요. 투명도를 조절할 수 있습니다. (0.0 에서 1.0 사이)
                }
                .padding(0)
            }
            .padding(0)
            .frame(width: .infinity, alignment: .leading)
            
// 이미지 스크롤 방식에서 리뷰 사진을 하나만 사용할거기 때문에 스크롤은 없이 한장의 사진만 크게 출력.
            if (!reviewImages.isEmpty) {
                let url = URL(string: reviewImages[0])
                URLImage(url: url!,
                             content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 375, height: 200)
                            .clipped()
                            .cornerRadius(8)
                    })
            }
            
            // 텍스트 + 태그
            VStack(alignment: .leading, spacing: 8) {
                // 텍스트 영역
                Text(review.content)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale800)
                    .frame(width: .infinity, alignment: .topLeading)
                
                //리뷰 키워드 태그
                HStack(alignment: .top, spacing: 8) {
                    ForEach(0..<min(review.tags.count, 3), id: \.self) { index in
                        HStack(alignment: .top, spacing: 8) {
                            Text(review.tags[index])
                                .font(Font.custom("Pretendard", size: 11))
                                .kerning(0.25)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.GrayScale700)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.GrayScale100)
                        .cornerRadius(100)
                    }
                    if review.tags.count > 3 {
                        Text("+\(review.tags.count - 3)")
                            .font(Font.custom("Pretendard", size: 11))
                            .kerning(0.25)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.GrayScale700)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.GrayScale100)
                            .cornerRadius(100)
                    }
                    Spacer()
                }
            }
            .padding(0)
            
            // Footer(날짜 + 추천 수)
            HStack(alignment: .center) {
                // 날짜
                Text(review.createdDate)
                    .font(
                        Font.custom("Pretendard", size: 12)
                            .weight(.medium)
                    )
                    .kerning(0.25)
                    .foregroundColor(Color.GrayScale400)
                Spacer()
                // 추천 수
                Button(action: {
                    // 버튼을 클릭 시 백엔드에 POST 및 reviewRcmndCnt + 1, 색깔 변화
                    reviewRcmndClick.toggle()
                }) {
                    HStack(alignment: .center, spacing: 6) {
                        if(reviewRcmndClick){
                            Image("store-recommend-on")
                                .frame(width: 16, height: 16)
                            // 텍스트
                            Text("추천해요 \(review.likeCount + 1)")
                              .font(
                                Font.custom("Pretendard", size: 12)
                                  .weight(.medium)
                              )
                              .kerning(0.25)
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color.GrayScale700)
                        }
                        else {
                            Image("store-recommend-off")
                                .frame(width: 16, height: 16)
                            // 텍스트
                            Text("추천해요 \(review.likeCount)")
                              .font(
                                Font.custom("Pretendard", size: 12)
                                  .weight(.medium)
                              )
                              .kerning(0.25)
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color.GrayScale700)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .inset(by: 0.5)
                            .stroke(Color.GrayScale200, lineWidth: 1)
                    )
                }
            }
            .padding(0)
            .frame(width: .infinity, alignment: .center)
        }
        .onAppear {
            storeVM.getImages(id: review.reviewId)
            storeVM.taskSuccess .sink {
                reviewImages = storeVM.getImagesData
            }.store(in: &storeVM.subscription)
        }
        .padding(0)
    }
}

//struct StoreReviewContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreReviewContentView()
//    }
//}
