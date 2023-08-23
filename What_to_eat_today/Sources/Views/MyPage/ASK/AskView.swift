//
//  AskView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/04.
//

import SwiftUI

struct AskView: View {
    
    let askList = Ask.askList
    let askCnt = 10
    
    @State private var isAskedContentSelected: Bool = true
    @State private var isAnswerCompletedSelected: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                AskHeader
                AskContents
            }
            writeAskLink
        }
        .onAppear {
            // 탭바 비활성화
        }
        .onDisappear {
            // 탭바 활성화
        }
        
    }
}



extension AskView {
    private var AskHeader: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                isAskedContentSelected = true
                isAnswerCompletedSelected = false
            }) {
                VStack(alignment: .center, spacing: 11) {
                    Text("문의한 내용")
                        .font(
                            Font.custom("Pretendard", size: 16)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(isAskedContentSelected ? Color.PrimaryOrange300 : Color.GrayScale700)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: (isAskedContentSelected ? 2 : 1))
                        .foregroundColor(isAskedContentSelected ? Color.PrimaryOrange300 : Color.GrayScale200)
                }
                .padding(0)
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .bottom)
            }
            
            Button(action: {
                isAskedContentSelected = false
                isAnswerCompletedSelected = true
                
            }) {
                VStack(alignment: .center, spacing: 11) {
                    Text("답변 완료")
                        .font(
                            Font.custom("Pretendard", size: 16)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(isAnswerCompletedSelected ? Color.PrimaryOrange300 : Color.GrayScale700)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: (isAnswerCompletedSelected ? 2 : 1))
                        .foregroundColor(isAnswerCompletedSelected ? Color.PrimaryOrange300 : Color.GrayScale200)
                }
                .padding(0)
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .bottom)
            }
            
        }
        .frame(width: .infinity, alignment: .leading)
        .background(Color.BlackWhiteWhite)
    }
    
    // 컨텐츠들 스크롤 뷰
    private var AskContents: some View {
        VStack(alignment: .center, spacing: 16) {
            ScrollView {
                if (isAskedContentSelected) {
                    ForEach(0..<askCnt, id: \.self) { idx in
                        if(askList[idx].answerState == false) {
                            AskContentView(content: askList[idx])
                            if (idx != askCnt - 1) {
                                Rectangle()
                                    .frame(width: .infinity, height: 1)
                                    .foregroundColor(Color.GrayScale200)
                            }
                        }
                    }
                } else {
                    ForEach(0..<askCnt, id: \.self) { idx in
                        if(askList[idx].answerState == true) {
                            AskContentView(content: askList[idx])
                            if (idx != askCnt - 1) {
                                Rectangle()
                                    .frame(width: .infinity, height: 1)
                                    .foregroundColor(Color.GrayScale200)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 0)
    }
    
    private var writeAskLink: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 16) {
                CustomNavLink(destination: AskinquiryView()
                    .customNavigationTitle("문의하기")
                              
                ) {
                    HStack(alignment: .center, spacing: 2) {
                        Text("문의하기")
                            .font(
                                Font.custom("Pretendard", size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.BlackWhiteWhite)
                    }
                    .padding(.horizontal, 24)
                    .frame(maxWidth:.infinity)
                    .frame(height: 56, alignment: .center)
                    .background(Color.PrimaryOrange300)
                    .cornerRadius(8)
                    
                }
                 .padding(.bottom, 8)
            }
            .frame(maxWidth:.infinity)
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .background(Color.BlackWhiteWhite)
        }
    }
}


struct AskView_Previews: PreviewProvider {
    static var previews: some View {
        AskView()
    }
}
 
