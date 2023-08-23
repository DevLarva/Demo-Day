
//
//  Ask.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/04.
//

import Foundation

struct Ask: Codable, Identifiable {
    let id: UUID
    let date: String
    let title: String
    let content: String
    let answerState: Bool
}

struct AskAnswer: Codable, Identifiable {
    let id: UUID
    let date: String
    let content: String
}

extension Ask {
    static let askList: [Ask] = [
        Ask(id: UUID(), date: "23.07.03", title: "이메일 인증이 안됩니다. 이메일 인증이 안됩니다.이메일 인증이 안됩니다.", content: "본문 텍스트 예시입니다. 최대 두줄로 진행되며 더 길어질 시 요약하게됩니다. 본문 텍스트 예시입니다. 최대 두줄로 진행되며 더 길어질 시 요약하게됩니다.", answerState: true),
        Ask(id: UUID(), date: "23.07.03", title: "이메일 인증이 안됩니다.", content: "이메일 인증이 안되는데본문 텍스트 예시입니다. 최대 두줄로 진행되며 더 길어질 시 요약하게됩니다.", answerState: false),
        Ask(id: UUID(), date: "23.07.02", title: "Question 3", content: "Content for question 3", answerState: true),
        Ask(id: UUID(), date: "23.07.03", title: "Question 4", content: "Content for question 4", answerState: true),
        Ask(id: UUID(), date: "23.07.21", title: "Question 5", content: "Content for question 5", answerState: false),
        Ask(id: UUID(), date: "23.07.03", title: "Question 6", content: "Content for question 6", answerState: false),
        Ask(id: UUID(), date: "23.07.01", title: "Question 7", content: "Content for question 7", answerState: true),
        Ask(id: UUID(), date: "23.07.03", title: "Question 8", content: "Content for question 8", answerState: true),
        Ask(id: UUID(), date: "23.07.03", title: "Question 9", content: "Content for question 9", answerState: true),
        Ask(id: UUID(), date: "23.07.03", title: "Question 10", content: "Content for question 10", answerState: false)
    ]
}

extension AskAnswer {
    static let askAnswer: [AskAnswer] = [
        AskAnswer(id: UUID(), date: "23.07.05", content: "안녕하세요 문의 내용 잘 읽어보았습니다.문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. 문의 답변에 대한 예시 텍스트입니다. ")
    ]
}
