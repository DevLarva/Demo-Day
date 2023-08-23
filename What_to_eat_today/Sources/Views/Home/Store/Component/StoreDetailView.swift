//
//  StoreDetailView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/13.
//

import SwiftUI

struct StoreDetailView: View {
    var phoneNumber: String?
    var address: String
    var time: String
    var body: some View{
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(alignment: .center, spacing: 8) {
                //이미지
                Image("store-call")
                
                //전화번호
                if let phoneNumber = phoneNumber { // 전화번호가 있는 경우
                    Text(phoneNumber)
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                } else { // 전화번호가 없는 경우
                    Text("전화번호가 없습니다 ㅜㅜ")
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                }
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            Image("line")
                .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 0)
                .overlay(
                    Rectangle()
                        .stroke(Color.GrayScale100, lineWidth: 1)
                )
            // # 가게주소 + 걸리는 시간
            HStack(alignment: .center, spacing: 8) {
                HStack(alignment: .center, spacing: 6) {
                    //이미지
                    Image("store-location")
                    
                    //주소
                    Text(address)
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                //걸리는 시간
                HStack(alignment: .top, spacing: 8) {
                    Text("걸어서 \(time)")
                        .font(
                            Font.custom("Pretendard", size: 11)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.38))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.GrayScale100)
                .cornerRadius(16)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .padding(0)
        .frame(width: 343, alignment: .topLeading)
        .cornerRadius(8)
    }
}

//struct StoreDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreDetailView()
//    }
//}
