//
//  RWstar.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/11.
//

import SwiftUI

struct RWstar: View {
    let totalStars = 5
    @Binding var selectedStars: Int
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            HStack(alignment: .center){
                Text("서비스에 만족 하셨나요?")
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.GrayScale700)
                
                
                Text("*")
                    .font(
                        Font.custom("Pretendard", size: 12)
                            .weight(.medium)
                    )
                    .kerning(0.25)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.StateError)
            }
            HStack(alignment: .center, spacing: 8) {
                ForEach(1...totalStars, id: \.self) { index in
                    Button(action: {
                        selectedStars = index
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(index <= selectedStars ? .PrimaryOrange300 : .GrayScale200)
                    }
                }
                
                Text("(\(selectedStars) / \(totalStars))")
                    .font(Font.custom("Pretendard", size: 16))
                    .foregroundColor(.GrayScale700)
                
                
            }
            .frame(width: 310)
            
        }.padding(.horizontal, 46)
            .padding(.vertical, 32)
            .frame(width: .infinity, alignment: .top)
            .background(Color.GrayScale50)
    }
}

//struct RWstar_Previews: PreviewProvider {
//    static var previews: some View {
//        RWstar()
//    }
//}
