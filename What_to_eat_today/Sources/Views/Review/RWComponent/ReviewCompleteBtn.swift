//
//  ReviewCompleteBtn.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/13.
//

import SwiftUI

struct ReviewCompleteBtn: View {
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Text("작성완료")
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.BlackWhiteWhite)
        }
        .padding(.leading)
        .padding(.horizontal, 24)
        .padding(.vertical, 0)
        .frame(width: 343, height: 56, alignment: .center)
        .background(Color.PrimaryOrange300)
        .cornerRadius(8)
 
    }
}

struct ReviewCompleteBtn_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCompleteBtn()
    }
}
