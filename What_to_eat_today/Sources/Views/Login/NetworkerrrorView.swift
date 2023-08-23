//
//  404View.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/12.
//

import SwiftUI

struct NetworkerrrorView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Spacer().frame(height: 138)
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 60, height: 60)
                    .background(
                        Image("Hammer And Pick")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipped()
                    )
            }
            VStack {
                
                Text("잠시만요!\n오류가 난 것 같아요:(")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale900)
                
                
                Text("네트워크 환경을 체크 해주세요.")
                    .font(Font.custom("Pretendard", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.GrayScale500)
            }
            Spacer().frame(height: 320)
            HStack(alignment: .center, spacing: 2) {
                
                Text("뒤로가기")
                  .font(
                    Font.custom("Pretendard", size: 16)
                      .weight(.medium)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.BlackWhiteWhite)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 0)
            .frame(width: 343, height: 56, alignment: .center)
            .background(Color.PrimaryOrange300)
            .cornerRadius(8)
            
        }
    }
}

struct NetworkerrrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkerrrorView()
    }
}
