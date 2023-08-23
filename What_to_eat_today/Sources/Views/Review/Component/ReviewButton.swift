//
//  ReviewButton.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/04.
//

import SwiftUI

struct ReviewButton: View {
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Text("리뷰 작성하기")
              .font(
                Font.custom("Pretendard", size: 16)
                  .weight(.medium)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.PrimaryOrange300)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 0)
        .frame(width: 343, height: 56, alignment: .center)
        .background(.white)
        .cornerRadius(8)
        .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .inset(by: 0.5)
            .stroke(Color.PrimaryOrange300, lineWidth: 1)
        )
    }
}

struct ReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewButton()
    }
}
