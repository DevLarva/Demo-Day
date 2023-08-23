//
//  AskContentView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/04.
//

import SwiftUI

struct AskContentView: View {
    let content: Ask
    
    var body: some View {
        VStack {
            CustomNavLink(
                destination: AskDetailView(content: content, answerContent: (content.answerState ? AskAnswer.askAnswer[0]: nil))
                    .customNavigationTitle("가게")
                    .customNavigationBarBackButtonHidden(false)
            ) {
                AskContent
            }
        }
    }
}

extension AskContentView {
    private var AskContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                // 아이콘
                Image(content.answerState ? "ask-answer-done" : "ask-answer-none")
                //타이틀
                Text(content.title)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .lineLimit(1)
                    .foregroundColor(Color.GrayScale900)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                //날짜
                Text("\(content.date)")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.GrayScale400)
            }
            .frame(width: .infinity, alignment: .center)
            
            // 컨텐츠
            Text(content.content)
                .lineLimit(2)
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(Color.GrayScale900)
                .frame(width: .infinity, alignment: .topLeading)
        }
        .frame(width: .infinity, alignment: .topLeading)

    }
}

struct AskContentView_Previews: PreviewProvider {
    static var previews: some View {
        AskContentView(content: Ask.askList[0])
    }
}
