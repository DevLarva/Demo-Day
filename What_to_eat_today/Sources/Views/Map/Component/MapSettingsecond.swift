//
//  MapSettingsecond.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/30.
//

import SwiftUI

struct MapSettingsecond: View {
    
    let Rankingtitle: [String] = ["밥약", "가성비", "혼밥", "단체", "술약속", "선택안함"]
    @Binding var selectedRanking: String
    var body: some View {
        VStack(alignment:.leading, spacing: 12) {
            Text("랭킹 카테고리")
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color.GrayScale900)
            
            HStack {
                ForEach(Rankingtitle.prefix(4), id: \.self) { title in
                    
                    CapsuleButton(title: title, isSelected: title == selectedRanking)
                        .onTapGesture {
                            selectedRanking = title
                        }
                }.padding(.horizontal, 2)
            }
            HStack {
                ForEach(Rankingtitle.dropFirst(4).prefix(2), id: \.self) { title in
                    CapsuleButton(title: title, isSelected: title == selectedRanking)
                        .onTapGesture {
                            selectedRanking = title
                        }
                }.padding(.horizontal, 2)
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 0)
    }
}
//
//struct MapSettingsecond_Previews: PreviewProvider {
//    static var previews: some View {
//        MapSettingsecond()
//    }
//}
