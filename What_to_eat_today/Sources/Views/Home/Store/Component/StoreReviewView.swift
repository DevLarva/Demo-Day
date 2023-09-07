//
//  StoreReviewView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/14.
//

import SwiftUI

struct StoreReviewView: View {
    @StateObject private var storeVM = StoreVM()
    var storeId: String
    
    @State var reviews: [Review] = []
    @State var buttonTabbed: Bool = false
    @State var reviewTab: String = "추천순"
    @State var reviewPage: Int = 1
    @State var reviewlimit: Int = 100
    @State var reviewsCount: Int = 0
    @State var myReview: MyReview = .init(id: "", nickname: "", score: 0.0, content: "", tags: [], images: [], likeCount: 0, createdDate: "", userImage: nil)
    
    var body: some View {
        VStack {
            StoreReviewBarView(buttonTabbed: $buttonTabbed, reviewTab: $reviewTab, reviewCnt: reviews.count)
            if reviewsCount > 0 {
                ForEach(reviews) { review in
                    StoreReviewContentView(reviewsCount: $reviewsCount, review: review)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
//                ForEach(0..<myReviewCnt, id: \.self) { idx in
            } else {
                StoreNonReviewView()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 24)
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            if (reviewTab == "추천순") {
                storeVM.getReviews(id: storeId, orderby: "liked", page: reviewPage, limit: reviewlimit)
            } else {
                storeVM.getReviews(id: storeId, orderby: "latest", page: reviewPage, limit: reviewlimit)
            }
            storeVM.taskSuccess .sink {
                reviews = storeVM.getReviewData
                reviewsCount = reviews.count
            }.store(in: &storeVM.subscription)
        }
        .onChange(of: buttonTabbed) { _ in
            if (reviewTab == "추천순") {
                storeVM.getReviews(id: storeId, orderby: "liked", page: reviewPage, limit: reviewlimit)
            } else {
                storeVM.getReviews(id: storeId, orderby: "latest", page: reviewPage, limit: reviewlimit)
            }
            storeVM.taskSuccess .sink {
                reviews = storeVM.getReviewData
                reviewsCount = reviews.count
            }.store(in: &storeVM.subscription)
        }
    }
}



struct StoreReviewBarView: View {
    @Binding var buttonTabbed: Bool
    @Binding var reviewTab: String
    var reviewCnt: Int
    
    var body: some View{
        HStack(alignment: .center) {
            
            //추천순, 최신순
            HStack(alignment: .top, spacing: 0) {
                //추천순
                Button(action: {
                    reviewTab = "추천순"
                    buttonTabbed = false
                }){
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("추천순")
                                .font(
                                    Font.custom("Pretendard", size: 16)
                                        .weight(.medium)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(buttonTabbed ? Color.GrayScale700 : Color.PrimaryOrange300)
                            
                            Divider()
                                .frame(width: 41, height: 2)
                                .background(buttonTabbed ? Color.white : Color.PrimaryOrange300)
                        }
                        .padding(0)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(0)
                .frame(width: 72, height: 44, alignment: .bottom)
                
                //최신순
                Button(action: {
                    reviewTab = "최신순"
                    buttonTabbed = true
                }) {
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("최신순")
                                .font(Font.custom("Pretendard", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(buttonTabbed ? Color.PrimaryOrange300 : Color.GrayScale700)
                            
                            Divider()
                                .frame(width: 41, height: 2)
                                .background(buttonTabbed ? Color.PrimaryOrange300 : Color.white)
                        }
                        .padding(0)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(0)
                .frame(width: 72, height: 44, alignment: .bottom)
            }
            .padding(0)
            Spacer()
            
            //리뷰
            HStack(alignment: .top, spacing: 4) {
                Text("리뷰")
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.GrayScale900)
                
                Text(String(reviewCnt))
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.PrimaryOrange300)
            }
            .padding(0)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 0)
        .frame(width: .infinity, alignment: .center)
        .background(Color.BlackWhiteWhite)
    }
}




//struct StoreReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreReviewBarView(reviewCnt: $reviewCnt)
//    }
//}
