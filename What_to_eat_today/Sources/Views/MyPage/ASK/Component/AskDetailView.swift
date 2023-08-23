//
//  AskDetailView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/04.
//
import SwiftUI

struct AskDetailView: View {
    let content: Ask
    let answerContent: AskAnswer?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                AskContent
                AnswerContent
            }
        }
    }
}

extension AskDetailView {
    private var AskContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Image("ask-answer-none")
                    Spacer()
                    Text(content.date)
                        .font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.GrayScale400)
                    
                }
                
                // 타이틀
                Text(content.title)
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.GrayScale900)
                    .frame(width: .infinity, alignment: .topLeading)
            }
            
            // 본문
            Text(content.content)
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(Color.GrayScale800)
                .frame(width: .infinity, alignment: .topLeading)
        }
        .padding(.top, 10)
        .padding(.horizontal, 16)
    }
    
    private var AnswerContent: some View {
        VStack {
            if let answer = answerContent {
                VStack(alignment: .center, spacing: 8) {
                    HStack(alignment: .top) {
                        // Space Between
                        Image("ask-answer-done")
                        Spacer()
                        Text(answer.date)
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.medium)
                            )
                            .kerning(0.1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.GrayScale400)
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    
                    //답변 내용
                    Text(answer.content)
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(Color.GrayScale800)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            } else {
                VStack(alignment: .center, spacing: 8) {
                    Text("아직 답변이 오지 않았습니다.\n빠른 시일내에 답변해 드리겠습니다.\n\n문의 이메일 example@gmail.com")
                      .font(Font.custom("Pretendard", size: 14))
                      .multilineTextAlignment(.center)
                      .foregroundColor(Color.GrayScale500)
                      .frame(maxWidth: .infinity, alignment: .top)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .frame(width: .infinity, height: 220, alignment: .center)
                .background(Color.GrayScale100)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .frame(width: .infinity, alignment: .top)
        .background(Color.GrayScale100)
    }
}


struct AskDetailView_Previews: PreviewProvider {
    static let test: Ask = Ask(id: UUID(), date: "23.07.03", title: "문의하기 타이틀 텍스트 예시입니다. 문의하기 타이틀 텍스트 예시입니다.", content: "공지사항 예시입니다. 공지사항 본문 예시입니다. 공지사항 예시입니다. 공지사항 본문 예시입니다. 공지사항 예시입니다. 공지사항 본문 예시입니다. 공지사항 예시입니다. 공지사항 본문 예시입니다. 공지사항 예시입니다. 공지사항 본문 예시입니다. 공지사항 예시입니다.", answerState: false)
    
    static let testAnswer: AskAnswer = AskAnswer(id: UUID(), date: "23.07.05", content: "안녕하세요 문의 내용 잘 읽어보았습니다.문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. ")
    static var previews: some View {
        AskDetailView(content: test, answerContent: testAnswer)
    }
}
