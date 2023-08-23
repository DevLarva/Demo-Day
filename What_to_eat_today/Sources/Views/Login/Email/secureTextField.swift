//
//  secureTextField.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/09.
//

import SwiftUI

struct secureTextField: View {
    var body: some View {
        Group {
            SecureField ( "Enter Text" , text: $text )
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable) // 이렇게 하면 키보드의 제안 표시줄이 표시되지 않습니다.
                .autocorrectionDisabled( true )
                .padding(.bottom, 7 )
                .overlay(
                    Rectangle ().frame(width: nil , height: 1 , alignment: .bottom)
                        .foregroundColor( Color .gray),
                    정렬: .bottom
                )
                .focused( $focusedField , 같음: .hidePasswordField)
                .opacity(hidePasswordFieldOpacity.rawValue)
            
            TextField ( "텍스트 입력" , 텍스트: $text )
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled( true )
                .padding(.bottom, 7 )
                .overlay(
                    Rectangle ().frame(너비: nil , 높이: 1 , 정렬: .bottom)
                        .foregroundColor( 색상 .gray),
                    정렬: .bottom
                )
                .focused( $focusedField , 같음: .showPasswordField)
                .opacity(showPasswordFieldOpacity.rawValue)
        }
        .padding(.trailing, 32 )
    }
}
    }
}

struct secureTextField_Previews: PreviewProvider {
    static var previews: some View {
        secureTextField()
    }
}
