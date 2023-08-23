//
//  ReviewWrite.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/10.
//

import SwiftUI

struct ReviewWrite: View {
    let totalStars = 5
    
    @State private var selectedStars = 0
    let Rankingkeyword: [String] = ["밥약", "가성비", "혼밥", "단체", "술약속"]
    let evaluationkeyword: [String] = ["인테리어가 이뻐요", "맛있어요", "깔끔해요", "조용해요", "친절해요"]
    @State private var isSheetActive = false
    @State var showalert = false
    @State private var shouldNavigate = false
    @State private var navigateToNextView = false
    @State private var isSearchViewActive = false
    @State private var showReviewcompleteView = false
    @Binding var showReviewWriteView: Bool
    var body: some View {
        
        VStack {
            if !showReviewcompleteView {
                HStack {
                    Button(action: {
                        self.showReviewWriteView = false
                    }) {
                        HStack {
                            Image("navi-back")
                                .frame(width: 38, height: 38)
                            Text("리뷰 쓰기")
                                .font(
                                    Font.custom("Pretendard", size: 17)
                                        .weight(.semibold)
                                )
                                .foregroundColor(.black)
                        }
                        
                    }
                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 19)
                .frame(width: 375, height: 58, alignment: .leading)
                .background(Color.BlackWhiteWhite)
            }
            
            ZStack {
                
                
                if showReviewcompleteView {
                    ReviewCompleteView()
                } else {
                    
                    
                    ScrollView() {
                        //            Spacer().frame(height: 24)
                        VStack(alignment: .leading, spacing: 32) {
//                            Rwheader()
//
//                            RWstar()
//
//                            RWbody()
//
//                            RWfooter()
                            
                            VStack(alignment: .center, spacing: 0) {
                                Button(action: {
                                    showReviewcompleteView.toggle()
                                }) {
                                    ReviewCompleteBtn()
                                }
                                
                            }.padding(.leading, 24)
                            
                        }
                        .padding(.horizontal)
                        
                        
                    }
                    
                    
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .padding(.leading)
        }
    }
}

struct StoreReviewWrite: View {
    @StateObject private var storeVM = StoreVM()
    var storeId: String
    let totalStars = 5
    
    @State var starNum: Int = 1
    @State var selectedRanking: String? = "밥약"
    @State var selectedeval: String? = "맛있어요"
    @State var ReviewText = ""
    @State var image: UIImage?
    
    let Rankingkeyword: [String] = ["밥약", "가성비", "혼밥", "단체", "술약속"]
    let evaluationkeyword: [String] = ["인테리어가 이뻐요", "맛있어요", "깔끔해요", "조용해요", "친절해요"]
    @State private var isSheetActive = false
    @State var showalert = false
    @State private var shouldNavigate = false
    @State private var navigateToNextView = false
    @State private var isSearchViewActive = false
    @State private var showReviewcompleteView = false
    @State var showReviewWriteView: Bool = true
    
    var body: some View {
        VStack {
//            if !showReviewcompleteView {
//                HStack {
//                    Button(action: {
//                        self.showReviewWriteView = false
//                    }) {
//                        HStack {
//                            Image("navi-back")
//                                .frame(width: 38, height: 38)
//                            Text("리뷰 쓰기")
//                                .font(
//                                    Font.custom("Pretendard", size: 17)
//                                        .weight(.semibold)
//                                )
//                                .foregroundColor(.black)
//                        }
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 14)
//                .padding(.vertical, 19)
//                .frame(width: 375, height: 58, alignment: .leading)
//                .background(Color.BlackWhiteWhite)
//            }
            ZStack {
                if showReviewcompleteView {
                    ReviewCompleteView()
                } else {
                    ScrollView() {
                        VStack(alignment: .leading, spacing: 32) {
                            RWstar(selectedStars: $starNum)
                            RWbody(selectedRanking: $selectedRanking, selectedeval: $selectedeval)
                            RWfooter(ReviewText: $ReviewText, image: $image)
                            VStack(alignment: .center, spacing: 0) {
                                Button(action: {
                                    if let selectedRankingUnwrapped = selectedRanking, let selectedevalUnwrapped = selectedeval {
                                        storeVM.createReview(dto: CreateReviewRequest.init(content: ReviewText, storeId: storeId, score: Float(starNum), tags: [selectedevalUnwrapped], keywords: [selectedRankingUnwrapped]), images: image)
                                        storeVM.taskSuccess.sink {
                                            showReviewcompleteView.toggle()
                                        }.store(in: &storeVM.subscription)
                                    }
                                }) {
                                    ReviewCompleteBtn()
                                }

                            }.padding(.leading, 24)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .padding(.leading)
        }
    }
}

//struct ReviewWrite_Previews: PreviewProvider {
//    @State static var test: Bool = false
//    static var previews: some View {
//        StoreReviewWrite(storeId: "", showReviewWriteView: $test)
//    }
//}
//
//
