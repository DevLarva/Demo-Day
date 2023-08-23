//
//  RWbody.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/10.
//

import SwiftUI

struct RWbody: View {
    
    let Rankingkeyword: [String] = ["밥약", "가성비", "혼밥", "단체", "술약속"]
    let evaluationkeyword: [String] = ["인테리어가 이뻐요", "맛있어요", "깔끔해요", "조용해요", "친절해요"]
    
    @Binding var selectedRanking: String?
    @Binding var selectedeval: String?
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        Text("랭킹 키워드")
                            .font(
                                Font.custom("Pretendard", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(.GrayScale700)
                        
                        
                        Text("*")
                            .font(
                                Font.custom("Pretendard", size: 12)
                                    .weight(.medium)
                            )
                            .kerning(0.25)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.StateError)
                    }
                    HStack(alignment:.center ,spacing: 0) {
                        ForEach(Rankingkeyword.prefix(4), id: \.self) { keyword in
                            CapsuleButton(title: keyword, isSelected: keyword == selectedRanking)
                                .onTapGesture {
                                    selectedRanking = keyword
                                }
                        }.padding(.horizontal, 2)
                    }
                    HStack(alignment:.center ,spacing: 0) {
                        ForEach(Rankingkeyword.dropFirst(4).prefix(1), id: \.self) { keyword in
                            CapsuleButton(title: keyword, isSelected: keyword == selectedRanking)
                                .onTapGesture {
                                    selectedRanking = keyword
                                }
                        }.padding(.horizontal, 2)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("평가 키워드")
                            .font(
                                Font.custom("Pretendard", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(.GrayScale700)
                        
                        
                        Text("*")
                            .font(
                                Font.custom("Pretendard", size: 12)
                                    .weight(.medium)
                            )
                            .kerning(0.25)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.StateError)
                    }
                    
                    HStack(alignment:.center ,spacing: 0) {
                        ForEach(evaluationkeyword.prefix(2), id: \.self) { keyword in
                            CapsuleButton(title: keyword, isSelected: keyword == selectedeval)
                                .onTapGesture {
                                    selectedeval = keyword
                                }
                        }.padding(.horizontal, 2)
                    }
                    HStack(alignment:.center ,spacing: 0) {
                        ForEach(evaluationkeyword.dropFirst(2).prefix(3), id: \.self) { keyword in
                            CapsuleButton(title: keyword, isSelected: keyword == selectedeval)
                                .onTapGesture {
                                    selectedeval = keyword
                                }
                        }.padding(.horizontal, 2)
                    }
                }
            }.padding(.leading)
        
    }
}

//struct RWbody_Previews: PreviewProvider {
//    static var previews: some View {
//        RWbody()
//    }
//}
