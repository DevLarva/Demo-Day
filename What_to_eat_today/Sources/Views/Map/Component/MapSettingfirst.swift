//
//  MapSettingfirst.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/30.
//

import SwiftUI

struct MapSettingfirst: View {
    @Binding var selectedDistance: String
    let Distancetitle: [String] =  ["2분 · 100m", "5분· 300m", "7분 · 500m", "10분 · 700m", "10분+ · 1.3km"]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("거리")
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.GrayScale900)
            
            HStack {
                ForEach(Distancetitle.prefix(2), id: \.self) { title in
                    CapsuleButton(title: title, isSelected: title == selectedDistance)
                        .onTapGesture {
                            selectedDistance = title
                        }
                }.padding(.horizontal, 2)
            }
            
            HStack {
                ForEach(Distancetitle.dropFirst(2).prefix(2), id: \.self) { title in
                    CapsuleButton(title: title, isSelected: title == selectedDistance)
                        .onTapGesture {
                            selectedDistance = title
                        }
                }.padding(.horizontal, 2)
            }
            HStack {
                ForEach(Distancetitle.dropFirst(4).prefix(1), id: \.self) { title in
                    CapsuleButton(title: title, isSelected: title == selectedDistance)
                        .onTapGesture {
                            selectedDistance = title
                        }
                }.padding(.horizontal, 2)
            }
                HStack(alignment: .center, spacing: 4) {
                    
                    Image("alert-circle")
                        .frame(width: 16, height: 16)
                    
                    Text("개인의 위치에따라 약간의 시간차가 발생 할 수 있습니다. 100m~1.3km로 구성되어있습니다.")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(.GrayScale700)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }.padding(12)
                .frame(width: 343, alignment: .leading)
                .background(Color.GrayScale100)
                .cornerRadius(4)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 0)
    }
}

//struct MapSettingfirst_Previews: PreviewProvider {
//    static var previews: some View {
//        MapSettingfirst()
//    }
//}
