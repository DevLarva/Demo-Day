//
//  CapsuleButton.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/28.
//

import SwiftUI

struct CapsuleButton: View { //캡슐바 커스터
    var title: String
    var isSelected: Bool
    
    var body: some View {
        Text(title)
            .multilineTextAlignment(.center)
            .foregroundColor(isSelected ? .white : .GrayScale700)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Capsule().fill(isSelected ? Color.PrimaryOrange300 : .white))
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .inset(by: 0.5)
                    .stroke(Color.GrayScale200, lineWidth: 1)
            )
    }
}


