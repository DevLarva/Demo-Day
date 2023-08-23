//
//  CustomTextField.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/14.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var firstDigit: String
    @Binding var secondDigit: String
    @Binding var thirdDigit: String
    @Binding var fourthDigit: String
    
    @FocusState private var isFocused1: Bool
    @FocusState private var isFocused2: Bool
    @FocusState private var isFocused3: Bool
    @FocusState private var isFocused4: Bool
    

    var body: some View {
        
 
        HStack(alignment: .center, spacing: 8) {
                TextField("", text: $firstDigit)
                    .focused($isFocused1)
                    .onChange(of: firstDigit) { newValue in
                        if newValue.count == 1 {
                            isFocused2 = true
                        }
                    }
                    .makeBorderTextField()
                    .keyboardType(.numberPad)
                    
                    
                TextField("", text: $secondDigit)
                    .focused($isFocused2)
                    .onChange(of: secondDigit) { newValue in
                        if newValue.count == 1 {
                            isFocused3 = true
                        }
                    }
                    .makeBorderTextField()
                    .keyboardType(.numberPad)

                TextField("", text: $thirdDigit)
                    .focused($isFocused3)
                    .onChange(of: thirdDigit) { newValue in
                        if newValue.count == 1 {
                            isFocused4 = true
                        }
                    }
                    .makeBorderTextField()
                    .keyboardType(.numberPad)
            
                TextField("", text: $fourthDigit)
                    .focused($isFocused4)
                    .makeBorderTextField()
                    .keyboardType(.numberPad)
            }

        
    }
}

extension View {
    func makeBorderTextField() -> some View {
        self
            .keyboardType(.numberPad)
            .font(.system(size: 20, weight: .semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(width: 48, height: 48, alignment: .center)
            .overlay(GeometryReader { geometry in
                 Path { path in
                     path.move(to: CGPoint(x: 0, y: geometry.size.height))
                     path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                 }.stroke(Color.PrimaryOrange300,lineWidth: 2)
            })
            .frame(maxWidth: 40)
            .padding(8)
    }
}

//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField()
//    }
//}
