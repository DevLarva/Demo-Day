//
//  Notice.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/02.
//

import SwiftUI

struct Notice: Identifiable {
    let id: Int
    let title: String
    let content: String
}

let sampleNotices: [Notice] = [
    Notice(id: 1, title: "8월 23일 데모데이 공지사항입니다.", content: "저희는 2시에 시작하여 오후 7시에 마감할 예정입니다."),
    Notice(id: 2, title: "8월 점검 안내", content: "임시 점검"),
    Notice(id: 3, title: "7월 점검 안내", content: "긴급 점검")
]

struct NoticesView: View {
    @State private var selectedNotice: Notice?
    @State private var showingDetail = false
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(sampleNotices) { notice in
                    Button(action: {
                        selectedNotice = notice
                        showingDetail = true
                    }) {
                        NoticeCell(noticeTitle: notice.title, noticeContent: notice.content).multilineTextAlignment(.leading)
                    }
                    .background(Color.white)
                    Divider()
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 0)
            .background(
                CustomNavLink(
                    destination: NoticeDetailView(notice: $selectedNotice, showingDetail: $showingDetail)
                        .customNavigationTitle("공지사항")
                        .customNavigationBarBackButtonHidden(false)
                    ,isActive: $showingDetail
                ) { }
                    .opacity(0)
            )
            
        }.toolbar(.hidden, for: .tabBar)
    }
    
}

struct NoticeDetailView: View {
    @Binding var notice: Notice?
    @Binding var showingDetail: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 6){
                Text("23.07.03")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.GrayScale400)
                
                Text(notice?.title ?? "")
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.GrayScale900)
                    .frame(width: .infinity, alignment: .topLeading)
            }
            .padding(16)
            
            VStack(alignment: .center, spacing: 8) {
                Text(notice?.content ?? "")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale800)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .frame(width: .infinity, alignment: .top)
            .background(Color.GrayScale100)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 49) {
                HStack(alignment: .center, spacing: 4) {
                    
                }
                .padding(0)
                Button("이전글") {
                    if let currentIndex = sampleNotices.firstIndex(where: { $0.id == notice?.id }),
                       currentIndex > 0 {
                        notice = sampleNotices[currentIndex - 1]
                    }
                }
                .disabled(notice?.id == sampleNotices.first?.id)
                
                Spacer()
                
                Button("목록") {
                    showingDetail = false
                }
                
                Spacer()
                
                Button("다음글") {
                    if let currentIndex = sampleNotices.firstIndex(where: { $0.id == notice?.id }),
                       currentIndex < sampleNotices.count - 1 {
                        notice = sampleNotices[currentIndex + 1]
                    }
                }
                .disabled(notice?.id == sampleNotices.last?.id)
            }
            .padding(.bottom, 48)
            .padding(.trailing, 17)
            .padding(.leading, 17)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Notice_Previews: PreviewProvider {
    static var previews: some View {
        NoticesView()
    }
}
