//
//  StoreNonReviewView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/12.
//

import SwiftUI

struct StoreNonReviewView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 8) {
            
            Text("작성된 리뷰가 없어요.")
              .font(
                Font.custom("Pretendard", size: 18)
                  .weight(.medium)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.GrayScale900)
              .frame(maxWidth: .infinity, alignment: .top)
            
            Text("아직 작성한 리뷰가 없어요ㅜㅜ\n솔직한 리뷰를 적어주세요")
              .font(Font.custom("Pretendard", size: 14))
              .multilineTextAlignment(.center)
              .foregroundColor(.GrayScale500)
              .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(.horizontal, 87)
        .padding(.vertical, 60)
        
        .background(Color.GrayScale50)
    }
}

struct StoreNonReviewView_Previews: PreviewProvider {
    static var previews: some View {
        StoreNonReviewView()
    }
}
