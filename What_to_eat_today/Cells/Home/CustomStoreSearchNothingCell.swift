//
//  CustomStoreSearchNothingCell.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/25.
//

import SwiftUI

struct CustomStoreSearchNothingCell:View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Text("‘김밪’")
                  .font(Font.custom("Pretendard", size: 16))
                  .foregroundColor(Color.PrimaryOrange300)
                Text("에 대한 검색 결과가 없습니다.")
                  .font(Font.custom("Pretendard", size: 16))
                  .foregroundColor(Color.GrayScale800)
            }
            
            Text("비슷한 다른 검색어를 입력해보세요.\n검색어의 철자가 정확한지 확인해주세요.")
              .font(Font.custom("Pretendard", size: 14))
              .multilineTextAlignment(.center)
              .foregroundColor(Color.GrayScale500)
        }
        .padding(.horizontal, 0)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.GrayScale50)
    }
}

struct CustomStoreSearchNothingCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomStoreSearchNothingCell()
    }
}
