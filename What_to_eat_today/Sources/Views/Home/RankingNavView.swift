//
//  Test.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/24.
//

import SwiftUI

struct RankingNavView: View {
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 14) {
                    
                    HStack {
                        if let universityName = UserDefaults.standard.string(forKey: "universityName") {
                            Text("\(universityName) 맛집\n랭킹을 확인해보세요 ")
                                .font(
                                    Font.custom("Pretendard", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    HStack(spacing: 2) {
                        Text("랭킹 보러가기")
                            .font(
                                Font.custom("Pretendard", size: 12)
                                    .weight(.medium)
                            )
                            .kerning(0.25)
                            .foregroundColor(.white)
                        
                        
                        Image("chevronforward")
                            .frame(width: 16, height: 16)
                    }
                }
                Spacer()
                
                HStack {
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 75.32037, height: 75.32037)
                    .background(
                    Image("medal")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 83.12055, height: 83.12055)
                    .clipped()
                    )
                    .shadow(color: .black.opacity(0.1), radius: 6.5, x: 0, y: 12)
                    .rotationEffect(Angle(degrees: 5.21))
                }
            }
        }.padding()
        .frame(width: 343, height: 104)
        .background(Color(red: 0.97, green: 0.53, blue: 0.44))
        .cornerRadius(6)
        .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
        .padding()
    }
}

struct RankingNavView_Previews: PreviewProvider {
    static var previews: some View {
        RankingNavView()
    }
}
