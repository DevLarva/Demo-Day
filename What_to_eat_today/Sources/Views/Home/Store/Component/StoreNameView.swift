//
//  StoreNameView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/12.
//

import SwiftUI

struct StoreNameView:View {
    var storeName: String
    var category: String
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            // 이름
            HStack(alignment: .center, spacing: 4) {
                Text(storeName) // 가게
                  .font(
                    Font.custom("Pretendard", size: 18)
                      .weight(.medium)
                  )
                  .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.13))
                Text(category)
                  .font(
                    Font.custom("Pretendard", size: 12)
                      .weight(.medium)
                  )
                  .kerning(0.25)
                  .foregroundColor(Color(red: 0.71, green: 0.71, blue: 0.74))
            }
            .padding(0)
            Spacer()
            
            //별표
            HStack(alignment: .center, spacing: 2) {
                Image("store-star")
                  .frame(width: 20, height: 20)
                
                Text("5.0")
                  .font(
                    Font.custom("Pretendard", size: 14)
                      .weight(.medium)
                  )
                  .kerning(0.1)
                  .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.38))
            }
            .padding(0)
            
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(width: .infinity, alignment: .topLeading)
    }
}

//struct StoreNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreNameView()
//    }
//}
