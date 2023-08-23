//
//  StoreKeywordView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/13.
//

import SwiftUI

struct StoreKeywordView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 4) {
                Text("이런점이 좋아요!")
                  .font(
                    Font.custom("Pretendard", size: 16)
                      .weight(.medium)
                  )
                  .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.13))
            }
            .padding(.leading, 16)
            .padding(.trailing, 0)
            .padding(.vertical, 0)
            VStack(alignment: .leading, spacing: 8) {
                // 키워드 갯수에 따라 반복 출력
                StoreKeywordElementView("인테리어가 이뻐요", 0.30, true, 100)
                StoreKeywordElementView("맛있어요", 0.20, false, 20)
                StoreKeywordElementView("친절해요", 0.02, false, 2)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 22)
            .background(Color.GrayScale50)
            .overlay(
              Rectangle()
                .inset(by: 0.5)
                .stroke(Color.GrayScale200, lineWidth: 1)
            )
        }
        .padding(0)
    }
}

struct StoreKeywordElementView: View {
    //차후에 state를 Binding으로 수정 필요
    var keywordName: String
    @State private var keywordPercent: Double
    @State private var keywordFlag: Bool
    var keywordNum: Int
    
    init(_ keywordName:String, _ keywordPercent: Double,_ keywordFlag: Bool, _ keywordNum: Int) {
        self.keywordName = keywordName
        self.keywordPercent = keywordPercent
        self.keywordFlag = keywordFlag
        self.keywordNum = keywordNum
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //텍스트
            Text(keywordName)
              .font(
                Font.custom("Pretendard", size: 14)
                  .weight(.medium)
              )
              .kerning(0.1)
              .foregroundColor(keywordFlag ? Color(red: 1, green: 0.3, blue: 0.15) : Color(red: 0.6, green: 0.6, blue: 0.62))
            //프로그래스 바 + 키워드 수
            HStack(alignment: .center, spacing: 16) {
                //프로그래스 바
                HStack(alignment: .center, spacing: 0) {
                    ProgressBar(value: $keywordPercent, flag: $keywordFlag)
                }
                .padding(.leading, 0)
                .padding(.vertical, 0)
                .frame(maxWidth: .infinity, minHeight: 8, maxHeight: 8, alignment: .leading)
                .background(Color.GrayScale200)
                .cornerRadius(300)
                
                //키워드 수
                Text(keywordNum >= 99 ? "99+" : "\(keywordNum)")
                  .font(
                    Font.custom("Pretendard", size: 14)
                      .weight(.medium)
                  )
                  .kerning(0.1)
                  .multilineTextAlignment(.center)
                  .foregroundColor(keywordFlag ? Color(red: 1, green: 0.3, blue: 0.15) : Color(red: 0.6, green: 0.6, blue: 0.62))
                  .frame(width: 27, alignment: .top)
            }
            .padding(0)
            .frame(width: .infinity, alignment: .leading)
        }
        .padding(0)
    }
}

struct ProgressBar: View {
    @Binding var value: Double
    @Binding var flag: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(Color(white: 0.9))
                    .cornerRadius(45)
                
                Rectangle()
                    .frame(width: CGFloat(self.value) * geometry.size.width, height: geometry.size.height)
                    .foregroundColor(flag ? Color.PrimaryOrange300 : Color.GrayScale500)
                    .cornerRadius(45)
                    .animation(.linear(duration: 0.5))
            }
        }
    }
}

struct StoreKeywordView_Previews: PreviewProvider {
    static var previews: some View {
        StoreKeywordView()
    }
}
