//
//  MapSettingthird.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/30.
//

import SwiftUI

struct MapSettingthird: View {
    let Categorytitle: [String] = ["한식", "중식", "양식", "일식", "카페", "술집", "분식", "아시아", "패스트푸드", "레스토랑", "선택안함"]
    @Binding var selectedCategory: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("메뉴 카테고리")
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color.GrayScale900)
            
            HStack {
                ForEach(Categorytitle.prefix(4), id: \.self) { title in
                    
                    CapsuleButton(title: title, isSelected: title == selectedCategory)
                        .onTapGesture {
                            selectedCategory = title
                        }
                }.padding(.horizontal, 2)
            }
            HStack {
                ForEach(Categorytitle.dropFirst(4).prefix(4), id: \.self) { title in
                    CapsuleButton(title: title, isSelected: title == selectedCategory)
                        .onTapGesture {
                            selectedCategory = title
                        }
                }.padding(.horizontal, 2)
            }
            
            HStack {
                ForEach(Categorytitle.dropFirst(8).prefix(3), id: \.self) { title in
                    
                    CapsuleButton(title: title, isSelected: title == selectedCategory)
                        .onTapGesture {
                            selectedCategory = title
                        }
                }.padding(.horizontal, 2)
            }
        }.padding(.horizontal, 16)
            .padding(.vertical, 0)
        
    }
}
