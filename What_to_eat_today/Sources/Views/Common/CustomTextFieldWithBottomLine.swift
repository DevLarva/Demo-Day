//
//  CustomTextFieldWithBottomLine.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/11.
//

import SwiftUI

struct CustomTextFieldWithBottomLine: View {
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    
    var placeholder: String
    var placeholderimage: String?
    
    init(_ text: Binding<String>, placeholder: String, placeholderimage: String? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderimage = placeholderimage
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
            
                .font(Font.custom("Pretendard", size: 18))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.leading, 0)
                .padding(.trailing, 8)
                .padding(.vertical, 12)
                .frame(width: 335, height: 26, alignment: .leading)
                .background(Color.BlackWhiteWhite)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isFocused ? Color.PrimaryOrange300 : Color.GrayScale300, lineWidth: 1)
                        .frame(height: 0.5)
                        .offset(y: 18)
                ).frame(width: 335)
            //                .foregroundColor(.PrimaryOrange300)
            
            if let placeholderImage = placeholderimage, !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(placeholderImage)
                        .frame(width: 24, height: 24)
                }.offset(x: -30)
            }
        }
        .accentColor(.PrimaryOrange300)
    }
}


struct CustomTextFieldTest: View {
    @State private var text: String = ""
    @FocusState private var isFocused: Bool

    var placeholder: String
    var placeholderimage: String?
    
    init(placeholder: String, placeholderimage: String? = nil) {
         self.placeholder = placeholder
         self.placeholderimage = placeholderimage
     }
   
    var body: some View {
        
        HStack(alignment: .center, spacing: 6) {
            
            TextField(placeholder, text: $text)
              .font(Font.custom("Pretendard", size: 14))
              .foregroundColor(.GrayScale500)
              
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)
        .frame(width: 343, height: 46, alignment: .leading)
        .background(Color.BlackWhiteWhite)
        .overlay(
            Rectangle()
            .inset(by: 0.5)
            .offset(y: 18)
            .stroke(Color.PrimaryOrange300, lineWidth: 1)
            .frame(height: 1)
        )
            
        
        .accentColor(.PrimaryOrange300)
    }
}


struct CustomTextFieldTest_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldTest(placeholder: "이메일을 입력하세요")
    }
}

struct BaseOnlyRectangleView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height / 2) // Adjust the height as needed
                    .foregroundColor(Color.blue) // Color of the base

                Rectangle() // Transparent mask to hide the upper part
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(Color.clear)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
        }
    }
}
struct BaseOnlyRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        BaseOnlyRectangleView()
    }
}
