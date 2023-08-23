//
//  PrivacyPolicyView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/02.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            // 타이틀
            Text("개인정보 처리방침")
                .font(
                    Font.custom("Pretendard", size: 17)
                        .weight(.semibold)
                )
                .padding(.bottom, 30)
                .padding(.top, 35)
            
            Section(header:  HStack {
               
            }) {
                HStack(alignment: .center) {
                CustomNavLink(destination: WebConnecter(urlToLoad: "https://m.youtube.com/@tvhesuinbada4267")) {
                        
                        Text("개인정보 처리 방침")
                    }
                }
            }
            // 소제목
           
            
            Spacer()
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
