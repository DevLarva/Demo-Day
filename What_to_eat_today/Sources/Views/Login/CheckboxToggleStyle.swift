//
//  CheckboxToggleStyle.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/03.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {

            RoundedRectangle(cornerRadius: 20, style: .circular)
                .fill(.white)
                .frame(width: 25, height: 25)
               
                .overlay {
                    Image(configuration.isOn ? "checkmarkOrange" : "checkmarkGray")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }

            configuration.label

        }
    }
}



struct AllCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {

            RoundedRectangle(cornerRadius: 20, style: .circular)
                .fill(Color.GrayScale600)
                .frame(width: 25, height: 25)
                
                .overlay {
                    Image(configuration.isOn ? "checkmarkOrange" : "checkmarkGray")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }

            configuration.label

        }
    }
}
