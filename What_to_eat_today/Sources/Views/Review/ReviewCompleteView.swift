//
//  ReviewCompleteView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/11.
//
import SwiftUI

struct ReviewCompleteView: View {
    @Binding var showReviewcompleteView: Bool
    @Binding var showReviewWriteView: Bool
    
    @State private var isshowReviewmain = false
    var body: some View {
        ZStack {
            if isshowReviewmain {
//                ReviewMain()
//                showReviewcompleteView = false
            } else {
                VStack(alignment: .center, spacing: 16) {
                    HStack(alignment: .center, spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 60, height: 60)
                            .background(
                                Image("magicwand")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                            )
                    }
                    .padding(.bottom, 8)
                    .frame(width: 60, height: 60, alignment: .center)

                    Text("리뷰작성이\n완료되었습니다!")
                        .font(
                            Font.custom("Pretendard", size: 24)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.GrayScale900)

                    Text("리뷰는 학생 친구들과 매장 사장님께\n큰 도움이 됩니다 :)")
                        .font(Font.custom("Pretendard", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.GrayScale500)

                    Spacer().frame(height: 292)

                    Button(action: {
                        isshowReviewmain.toggle()
                        showReviewcompleteView = false
                        showReviewWriteView = false
                    }) {
                        ReviewCompleteBtn()
                    }
                }.ignoresSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

//struct ReviewCompleteView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewCompleteView()
//    }
//}
