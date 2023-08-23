//
//  ReviewImageButton.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/11.
//

import SwiftUI

struct ReviewImageButton: View {
    

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
           
            Text("사진 업로드")
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.medium)
                )
                .foregroundColor(.GrayScale700)
            
            VStack(alignment: .center, spacing: 6) {
                Image("upload")
                    .frame(width: 34, height: 34)
                
                
                Text("사진을 등록하세요!")
                    .font(
                        Font.custom("Pretendard", size: 12)
                            .weight(.medium)
                    )
                    .kerning(0.25)
                    .foregroundColor(.GrayScale500)
            }
            .padding(.leading, 37)
            .padding(.trailing, 31)
            .padding(.top, 52)
            .padding(.bottom, 50)
            .background(Color.GrayScale100)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(Color.GrayScale300, lineWidth: 1)
            )
        }.padding(0)
            .frame(alignment: .topLeading)
    }
}


struct ReviewImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewImageButton()
    }
}





