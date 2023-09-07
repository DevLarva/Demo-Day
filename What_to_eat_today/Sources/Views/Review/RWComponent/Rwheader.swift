//
//  Rwheader.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/10.
//

import SwiftUI

struct Rwheader: View {
    @StateObject private var storeVM = StoreVM()
    @Binding var isSearchViewActive: Bool
    @Binding var storeId: String
    @Binding var storeName: String
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("매장 이름")
                        .font(
                            Font.custom("Pretendard", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(.GrayScale600)
                    Text("*")
                        .font(
                            Font.custom("Pretendard", size: 12)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.StateError)
                }
                Button(action: {
                    isSearchViewActive = true
                }) {
                    HStack(alignment: .center, spacing: 6) {
                        Text(storeName)
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.24, green: 0.25, blue: 0.26))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Image("myprofile-arrow")
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                    .padding(.vertical, 12)
                    .frame(width: 343, alignment: .leading)
                    .background(Color.BlackWhiteWhite)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .inset(by: 0.5)
                            .stroke(Color.GrayScale300, lineWidth: 1)
                    )
                }
            }
        }.padding(.leading)
    }
}


//struct Rwheader_Previews: PreviewProvider {
//    static var previews: some View {
//        Rwheader()
//    }
//}
