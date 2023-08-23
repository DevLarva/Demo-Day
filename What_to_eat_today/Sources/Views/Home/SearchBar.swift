//
//  SearchBar.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/04.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 6, style: .circular)
                .frame(width: .infinity, height: 40)
                .overlay {
                    HStack {
                        
                        Image("search")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.GrayScale700)
                        
                        TextField("오늘의 맛집을 찾아보세요", text: $searchText).font(
                            Font.custom("Pretendard", size: 14)
                                .weight(.medium)
                        )
                        .kerning(0.1)
                        .foregroundColor(.GrayScale500)
                        
                        
                        Spacer()
                        
                    }.padding()
                }.foregroundColor(.GrayScale100)
            
            
            
            
        }.padding()
    }
}

struct SearchBarButton: View {
    @Binding var isNavItemActive: Bool

    var body: some View {
        Button(action: {
            self.isNavItemActive = true
        }) {
            VStack {
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .frame(width: .infinity, height: 40)
                    .overlay {
                        HStack {
                            Image("search")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.GrayScale700)

                            Text("오늘의 맛집을 찾아보세요")
                                .font(
                                    Font.custom("Pretendard", size: 14)
                                        .weight(.medium)
                                )
                                .kerning(0.1)
                                .foregroundColor(Color.GrayScale500)

                            Spacer()
                        }.padding()
                    }.foregroundColor(.GrayScale100)
            }.padding()
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
