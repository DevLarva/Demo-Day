//
//  MapSettingView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/29.
//

import SwiftUI

struct MapSettingView: View {
    @Binding var selectedDistance: String
     @Binding var selectedRanking: String
     @Binding var selectedCategory: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
            VStack(alignment: .center, spacing: 32) {
                
                MapSettingfirst(selectedDistance: $selectedDistance)
                
                MapSettingsecond(selectedRanking: $selectedRanking)
                
                MapSettingthird(selectedCategory: $selectedCategory)
                
                
                HStack(alignment: .center, spacing: 2) {
                    Button(action: {
                        print(selectedDistance)
                        print(selectedRanking)
                        print(selectedCategory)
                        dismiss()
                        
                    }) {
                        
                        Text("필터적용")
                            .font(.headline).bold()
                            .foregroundColor(.white)
                            .background(Color.PrimaryOrange300)
                            .cornerRadius(8)
                        
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 0)
                .frame(maxWidth: 343, minHeight: 56, maxHeight: 56, alignment: .center)
                .background(Color.PrimaryOrange300)
                .cornerRadius(8)
                
                
            }
        
    }
}


