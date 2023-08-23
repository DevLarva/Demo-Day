//
//  MyReviewsView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/03.
//

import SwiftUI

struct MyReviewsView: View {
    @StateObject private var storeVM = StoreVM()
    
    @State var myReviews: [MyReview] = []
    @State var myReviewCnt: Int = 0
    
    var body: some View {
        ZStack {
            if (myReviews.count != 0) {
                myReviewContents
            } else {
                noneMyReview
            }
            writeReviewLink
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            storeVM.myReviews()
            storeVM.taskSuccess .sink {
                myReviews = storeVM.myReviewsData
                myReviewCnt = myReviews.count
                print(myReviews)
            }.store(in: &storeVM.subscription)
        }
    }
}




extension MyReviewsView {
    // 작성한 리뷰가 있을 경우
    private var myReviewContents: some View {
        VStack(spacing: 0) {
            // 총 갯수
            HStack(alignment: .top, spacing: 8) {
                Text("총 \(myReviewCnt)개")
                    .font(
                        Font.custom("Pretendard", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.GrayScale800)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            // 구분선
            Rectangle()
                .frame(width: .infinity, height: 1)
                .foregroundColor(Color.GrayScale200)
            
            // 컨텐츠
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(0..<myReviewCnt, id: \.self) { idx in
                        StoreReviewContentView(review: Review.init(reviewId: myReviews[idx].id, nickname: myReviews[idx].nickname, score: Int(myReviews[idx].score), tags: myReviews[idx].tags, createdDate: myReviews[idx].createdDate, likeCount: myReviews[idx].likeCount, content: myReviews[idx].content, userImage: myReviews[idx].userImage))
                        if (idx != myReviewCnt - 1) {
                            Rectangle()
                                .frame(width: .infinity, height: 1)
                                .foregroundColor(Color.GrayScale200)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            }
            
        }
    }
    
    // 내가 작성한 리뷰가 없을 경우
    private var noneMyReview: some View {
        VStack(alignment: .center, spacing: 16) {
            // 아이콘
            HStack(alignment: .center, spacing: 0) {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 60, height: 60)
                  .background(
                    Image("myreview-none")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 60, height: 60)
                      .clipped()
                  )
            }
            .padding(.bottom, 8)
            .frame(width: 60, height: 60, alignment: .center)
            
            // 타이틀
            Text("내가 찾은 숨은맛집\n슬적 알려줄까요?")
                .font(
                    Font.custom("Pretendard", size: 24)
                        .weight(.semibold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color.GrayScale900)
            
            // 컨텐츠
            Text("나만 알기 아까운 맛집을 알려주세요!\n대학생 찐 리뷰를 담기하여 대학생 인증 후\n후기 작성이 가능합니다.")
                .font(Font.custom("Pretendard", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.GrayScale500)
        }
    }
    
    // 리뷰 쓰기
    private var writeReviewLink: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 16) {
//                Button(action: {
//                    // 리뷰 버튼 액션
//                    //
//                }) {
//                    HStack(alignment: .center, spacing: 2) {
//                        Text("리뷰쓰기")
//                            .font(
//                                Font.custom("Pretendard", size: 16)
//                                    .weight(.medium)
//                            )
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(Color.BlackWhiteWhite)
//                    }
//                    .padding(.horizontal, 24)
//                    .frame(maxWidth:.infinity)
//                    .frame(height: 56, alignment: .center)
//                    .background(Color.PrimaryOrange300)
//                    .cornerRadius(8)
//                }
//                .padding(.bottom, 8)
            }
            .frame(maxWidth:.infinity)
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .background(Color.BlackWhiteWhite)
        }
    }
}

struct MyReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewsView()
    }
}
