//
//  CategoryDefultView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/09/07.
//

import SwiftUI

struct CategoryDefultView: View {
    var body: some View {
            VStack(alignment: .center, spacing: 20) {
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
                
                Text("주변에 해당 카테고리에 맞는 음식점이 없습니다..🥲")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.GrayScale900)

                Text("아쉽지만 카테고리는 어떠실까요?")
                    .font(Font.custom("Pretendard", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale500)
            }
            .padding(.leading, 64)
            .padding(.top, 200)
    
    }
}

struct CategoryDefultView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDefultView()
    }
}
