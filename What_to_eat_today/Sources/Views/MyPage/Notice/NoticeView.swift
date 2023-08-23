//
//  NoticeView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/02.
//

import SwiftUI

struct NoticeView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 0)
    }
}

struct NoticeCell: View {
    let noticeTitle: String
    let noticeContent: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(noticeTitle)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .lineLimit(1)
                    .foregroundColor(Color.GrayScale900)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text("23.07.03")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.GrayScale400)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(noticeContent)
                .lineLimit(2)
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(Color.GrayScale900)
                .frame(width: .infinity, alignment: .leading)
                
        }
        .padding(0)
        .frame(width: .infinity, alignment: .topLeading)
    }
}

struct NoticeCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeCell(noticeTitle: "테스트 타이틀입니다.", noticeContent: "테스트 컨텐츠 입니다. 테스트 컨텐츠 입니다.테스트 컨텐츠 입니다.테스트 컨텐츠 입니다.테스트 컨텐츠 입니다.테스트 컨텐츠 입니다.테스트 컨텐츠 입니다.테스트 컨텐츠 입니다.")
    }
}
