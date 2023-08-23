//
//  Askheader.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/12.
//

import SwiftUI

struct Askheader: View {
    @State var Title = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("제목")
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(.GrayScale600)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            TextField("제목을 입력해 주세요", text: $Title)
                .font(
                    Font.custom("Pretendard", size: 14)
                        .weight(.medium)
                )
                .foregroundColor(.GrayScale500)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            Divider().padding(.bottom)
        }
    }
}

struct Askheader_Previews: PreviewProvider {
    static var previews: some View {
        Askheader()
    }
}
