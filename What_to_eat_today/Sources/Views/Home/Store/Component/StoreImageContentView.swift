//
//  StoreImageContentView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/30.
//

import SwiftUI
import URLImage

struct StoreImageContentView: View {
    var imageUrl: String?
    
    var imageCount: Int
    var body: some View {
        ZStack {
            if let unwrappedUrl = imageUrl, let url =  URL(string: "http://\(unwrappedUrl)") {
                URLImage(url: url,
                         content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: .infinity, height: 271)
                        .clipped()
                        .overlay(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 1, green: 0.31, blue: 0.16).opacity(0.4), location: 0.00),
                                    Gradient.Stop(color: Color(red: 1, green: 0.33, blue: 0.18).opacity(0), location: 0.42),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                })
            } else {
                Image("Default img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: .infinity, height: 271)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 1, green: 0.31, blue: 0.16).opacity(0.4), location: 0.00),
                                Gradient.Stop(color: Color(red: 1, green: 0.33, blue: 0.18).opacity(0), location: 0.42),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
            }
            
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(Color.white)
                .frame(width: .infinity, height: 16)
                .offset(y: 135)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    CustomNavLink(
                        destination: StoreImageView()
                            .customNavigationTitle("울산대 공차")
                            .customNavigationBarBackButtonHidden(false)
                    ) {
                        HStack(alignment: .center, spacing: 6) {
                            //아이콘
                            Image("store-images")
                                .frame(width: 16, height: 16)
                            // 사진 갯수
                            Text(imageCount < 99 ? "\(imageCount)" : "99+")
                                .font(
                                    Font.custom("Pretendard", size: 14)
                                        .weight(.medium)
                                )
                                .kerning(0.1)
                                .foregroundColor(Color.BlackWhiteWhite)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.black.opacity(0.4))
                        .cornerRadius(32)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                    }
                }
            }
        }
        .frame(width: .infinity, height: 271)
    }
}


//
//struct StoreImageContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreImageContentView()
//    }
//}
