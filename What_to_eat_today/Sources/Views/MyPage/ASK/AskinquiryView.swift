//
//  AskinquiryView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/12.
//

import SwiftUI

struct AskinquiryView: View {
    
    @State var showalert = false
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 24) {
                
                Askheader()
                Askfooter()
                
                Button("등록") {
                    showalert = true
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 0)
                .frame(width: 343, height: 56, alignment: .center)
                .background(Color.PrimaryOrange300)
                .cornerRadius(8)
                
                
                
            }.padding()
                .background(Color.BlackWhiteWhite)
            if showalert {
                CustomAlertView(showalert: $showalert, alertMessage: "문의가\n완료되었습니다.")
            }
        }
        
        
    }
    
}

struct AskinquiryView_Previews: PreviewProvider {
    static var previews: some View {
        AskinquiryView()
    }
}
