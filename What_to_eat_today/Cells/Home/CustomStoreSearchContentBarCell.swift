//
//  CustomStoreSearchContentBarCell.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/25.
//

import SwiftUI

struct CustomStoreSearchContentBarCell: View {
    @Binding var SearchResultCnt: Int
    
    @State private var isFilterFlag: Bool = false
    @State private var selectFilter: SearchFilter = SearchFilter(title: "거리순")// default 값
    
    var body: some View {
        HStack(alignment: .center) {
            // 텍스트
            Text("총 \(SearchResultCnt)개")
                .font(
                    Font.custom("Pretendard", size: 18)
                        .weight(.medium)
                )
                .foregroundColor(Color.GrayScale800)
            
            Spacer()
            
            // 필터
            ZStack {
                Button(action: {
                    isFilterFlag.toggle()
                }) {
                    HStack(alignment: .center, spacing: 3) {
                        Text("필터")
                            .font(Font.custom("Pretendard", size: 12))
                            .foregroundColor(Color.GrayScale800)
                        Image(isFilterFlag ? "store-filter-on" : "store-filter-off")
                            .frame(width: 19, height: 19)
                    }
                    .padding(0)
                }
                .buttonStyle(PlainButtonStyle()) // Add this line
                .overlay(alignment: .topTrailing) {
                    VStack {
                        if isFilterFlag {
                            Spacer(minLength: 20)
                            SearchFilterMenuList(selectFilter: $selectFilter) { filter in
                                isFilterFlag = false
                                
                            }
                        }
                    }
                }
            }
            .padding(0)
            
        }
        .padding(0)
        .frame(width: .infinity, alignment: .center)
    }
}


// 버튼 리스트
struct SearchFilterMenuList: View {
    @Binding var selectFilter: SearchFilter
    
    let list = SearchFilter.searchfilterList
    let sendAction: (_ filter: SearchFilter) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(list) { filter in
                ZStack {
                    Button(action: {
                        print("Button tapped: \(filter.title)")
                        selectFilter = filter
                        self.sendAction(filter)
                    }) {
                        if(selectFilter.title == filter.title){
                            Text(filter.title)
                                .font(Font.custom("Pretendard", size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.PrimaryOrange300)
                        } else {
                            Text(filter.title)
                                .font(Font.custom("Pretendard", size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.GrayScale800)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .padding(.leading, 22)
                .padding(.trailing, 21)
                .padding(.vertical, 9)
                .frame(width: 80, height: 42, alignment: .center)
                .background(Color.BlackWhiteWhite)
                .overlay(
                    Rectangle()
                        .inset(by: 0.5)
                        .stroke(Color.GrayScale200, lineWidth: 1)
                )
            }
        }
        .padding(0)
        .cornerRadius(6)
        .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(Color.GrayScale200, lineWidth: 1)
        )
    }
}


struct MyReviewMenuList: View {
    let list = ReviewFilter.myreviewFilter
    let sendAction: (_ filter: ReviewFilter) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(list) { filter in
                ZStack {
                    Button(action: {
                        self.sendAction(filter)
                    }) {
                        Text(filter.title)
                            .font(Font.custom("Pretendard", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.GrayScale800)
                    }
                    .contentShape(Rectangle())
                }
                .zIndex(1)
                .padding(.leading, 22)
                .padding(.trailing, 21)
                .padding(.vertical, 9)
                .frame(width: 80, height: 42, alignment: .center)
                .background(Color.BlackWhiteWhite)
                .overlay(
                    Rectangle()
                        .inset(by: 0.5)
                        .stroke(Color.GrayScale200, lineWidth: 1)
                )
            }.zIndex(1)
        }.zIndex(1)
        .padding(0)
        .cornerRadius(6)
        .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(Color.GrayScale200, lineWidth: 1)
        )
    }
}

struct OtherReviewMenuList: View {
    let list = ReviewFilter.otherReviewsFilter
    let sendAction: (_ filter: ReviewFilter) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(list) { filter in
                ZStack {
                    Button(action: {
                        self.sendAction(filter)
                    }) {
                        Text(filter.title)
                            .font(Font.custom("Pretendard", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.GrayScale800)
                    }
                    .contentShape(Rectangle())
                }
                .padding(.leading, 22)
                .padding(.trailing, 21)
                .padding(.vertical, 9)
                .frame(width: 80, height: 42, alignment: .center)
                .background(Color.BlackWhiteWhite)
                .overlay(
                    Rectangle()
                        .inset(by: 0.5)
                        .stroke(Color.GrayScale200, lineWidth: 1)
                )
            }
        }
        .zIndex(1)
        .padding(0)
        .cornerRadius(6)
        .shadow(color: Color(red: 0.22, green: 0.11, blue: 0.09).opacity(0.09), radius: 3, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(Color.GrayScale200, lineWidth: 1)
        )
    }
}

struct CustomStoreSearchContentBarCell_Previews: PreviewProvider {
    @State static var testResultCnt: Int = 4
    
    
    static var previews: some View {
        CustomStoreSearchContentBarCell(SearchResultCnt: $testResultCnt)
    }
}
