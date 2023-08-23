//
//  ProfileButton.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/11.
//

import SwiftUI

struct ProfileButton: View {
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 0) {
                Image("profile-default")
                    .resizable()
                    .frame(width: 78.75, height: 78.75)
                    .zIndex(1)
            }
            .padding(.horizontal, 5.625)
            .padding(.top, 16.875)
            .padding(.bottom, 0)
            .frame(width: 90, alignment: .center)
            .background(Color.PrimaryOrange100)
            .cornerRadius(100)
            .overlay(
            RoundedRectangle(cornerRadius: 100)
            .inset(by: 0.5)
            .stroke(Color.PrimaryOrange100, lineWidth: 1)
            )
            
            
            HStack(alignment: .center, spacing: 0) {
                Image("pencil")
                    .frame(width: 18, height: 18)
            }
            
            .padding(7)
            .frame(width: 32, height: 32, alignment: .center)
            .background(Color.PrimaryOrange300)
            .cornerRadius(36)
            .overlay(
                RoundedRectangle(cornerRadius: 36)
                    .inset(by: 1)
                    .stroke(.white, lineWidth: 2)
            )
            .offset(x: 30,y: 30)
        }
    }
}

struct MypageProfile: View {  //마이 페이지 첫화면 프로필 화면
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 0) {
                Image("profile-default")
                    .resizable()
                    .frame(width: 42.75, height: 42.75)
                    .zIndex(1)
            }
            .padding(.horizontal, 5.625)
            .padding(.horizontal, 3.375)
            .padding(.top, 10.125)
            .padding(.bottom, 0)
            .frame(width: 54, alignment: .center)
            .background(Color.PrimaryOrange100)
            .cornerRadius(100)
        }
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton()
        MypageProfile()
    }
}
