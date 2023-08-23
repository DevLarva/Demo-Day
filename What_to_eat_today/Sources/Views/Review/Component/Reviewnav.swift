//
//  Reviewnav.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/04.
//

import SwiftUI

struct Reviewnav: View {
    var body: some View {
        ZStack {
            Image("Vector11")
            .resizable()
            .frame(width: 370.5, height: 128)
           
            HStack {
                VStack(alignment: .leading,spacing: 10) {
                    if let universityName = UserDefaults.standard.string(forKey: "universityName") {
                        Text("\(universityName) 학생들에게\n맛집 후기를 알려주세요")
                            .font(
                                Font.custom("Pretendard", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(.white)
                    }
                }
                Spacer().frame(width: 87)
                VStack {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 75, height: 75)
                      .background(
                        Image("sskoo")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 80, height: 80)
                          .clipped()
                      )
                      .padding(.top, 8)
                      .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
                }
            }
            
          
        }.frame(width: 343, height: 104)
            .background(Color(red: 1, green: 0.79, blue: 0.39))
            .cornerRadius(6)
            .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
            .padding()
        
    }
}

struct Reviewnav_Previews: PreviewProvider {
    static var previews: some View {
        Reviewnav()
    }
}
