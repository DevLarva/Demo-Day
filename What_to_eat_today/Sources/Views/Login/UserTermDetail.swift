//
//  UserTermDetail.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/11.
//

import SwiftUI

struct UserTermDetail: View {
    var body: some View {
        NavigationStack {
            
            ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                    Text("이용약관")
                    
                    Text("제 1조 (목적)")
                    
                    
                    Text("이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.")
                    
                    Divider()
                    Spacer().frame(height: 24)
                    
                    Text("제 2조 (이용약관의 효력 및 변경)")
                    
                    
                    Text("이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.")
                    
                    Text("이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.")
                    
                    Text("이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.")
                    
                    Text("이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.이용약관 예시 텍스트 입니다.")
                }
            }.padding()
                
        }
    }
}

struct UserTermDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserTermDetail()
    }
}
