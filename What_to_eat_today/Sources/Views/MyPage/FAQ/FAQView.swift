//
//  FAQView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/02.
//

import SwiftUI

struct FAQView: View {
    @State private var isExpanded: [Bool] = Array(repeating: false, count: sampleFAQs.count)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(sampleFAQs.indices) { index in
                    FAQRow(faq: sampleFAQs[index], isExpanded: $isExpanded[index])
                }
            }
        }
    }
}

struct FAQRow: View {
    let faq: FAQ
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { isExpanded.toggle() }) {
                HStack(alignment: .center, spacing: 8) {
                    Text(faq.question)
                        .font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(Color.GrayScale900)
                        .frame(maxWidth: .infinity, minHeight: 21, maxHeight: 21, alignment: .topLeading)
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .padding(16)
                .frame(width: .infinity, alignment: .leading)
                .background(Color.BlackWhiteWhite)
            }
            
            if (isExpanded) {
                VStack(alignment: .center, spacing: 8) {
                    Text(faq.answer)
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(Color.GrayScale800)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                        .transition(.slide)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .frame(width: .infinity, alignment: .top)
                .background(Color.GrayScale100)
            }
        }
    }
}

struct FAQ: Identifiable {
    let id: Int
    let question: String
    let answer: String
}

let sampleFAQs: [FAQ] = [
    FAQ(id: 1, question: "Q. 가게 리뷰쓰기는 어떻게 진행하나요?", answer: "가게 상세 페이지에 들어가셔서 하단에 리뷰쓰기를 작성하시면 됩니다."),
    FAQ(id: 2, question: "Q. 악의적인 리뷰가 담겨있는 경우 어떻게 신고하나요?", answer: "해당 리뷰 오른쪽 상단에 메뉴를 클릭하고 신고 버튼을 누르시면 저희가 검토 후 삭제조치합니다."),
    FAQ(id: 3, question: "Q. 대학 주변 가게는 최대 몇미터 까지 검색되나요?", answer: "저희 어플리케이션에서는 1300m까지 검색이 가능합니다.")]

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
