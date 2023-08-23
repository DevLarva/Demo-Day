//
//  CustomAdCell.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/07.
//

import SwiftUI

struct CustomAdCell: View {
    var adImage: Image
    @State private var showWebConnecter: Bool = false
    var body: some View {
        CustomNavLink(destination: WebConnecter(urlToLoad: "https://www.notion.so/533be1a1dec84d2f8c5e0f63f1ca422e")
        // 링크 변경 하기
        ){
            VStack(alignment: .center){
                adImage
                    .resizable()
                    .frame(width: 343, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 4)
            }
            .toolbar(.hidden, for: .tabBar)
            .padding(.top, 10)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 16)
        }
    }
}
