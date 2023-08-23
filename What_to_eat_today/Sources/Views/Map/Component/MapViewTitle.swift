//
//  MapViewTitle.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/02.
//

import SwiftUI

struct MapViewTitle: View {
    @Binding var selectedDistance: String
    @Binding var selectedCategory: String
    @Binding var selectedRanking: String
    let titles: [String] = ["밥약", "가성비", "혼밥", "단체", "술약속"]
    @State private var selectedTitle: String? = "밥약"
    @State private var showingSheet = false
    var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    if let universityName = UserDefaults.standard.string(forKey: "universityName") {
                        CustomNavBarViewsec(title: "\(universityName)")
                    }
                    // 여기서 나중에 서버에서 받아온 학교 정보를 입력
                }
                .padding(5)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.00),
                            Gradient.Stop(color: .white.opacity(0.85), location: 0.53),
                            Gradient.Stop(color: .white.opacity(0), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(alignment: .center, spacing: 8) {
                              CapsuleButton(title: selectedDistance ?? "", isSelected: true)
                         
                                CapsuleButton(title: selectedRanking ?? "", isSelected: true)
                        CapsuleButton(title: selectedCategory ?? "", isSelected: true)
                          }.padding(.horizontal, 16)
                    
                }
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    HStack(alignment: .center, spacing: 0) {
                        Button(action: {
                            showingSheet = true
                        }) {
                            Image("options")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(12)
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(Color.GrayScale200, lineWidth: 1)
                        )
                    }
                    .frame(width: 44, height: 44, alignment: .center)
                    .padding(.horizontal, 17)
                    .padding(.vertical, 0)
                }
                .padding(.horizontal, 23)
                .padding(.vertical, 12)


            }.sheet(isPresented: $showingSheet) {
                MapSettingView(selectedDistance: $selectedDistance, selectedRanking: $selectedRanking, selectedCategory: $selectedCategory)
                    .presentationDragIndicator(.visible)
            }
         
        
    }
}


//struct MapViewTitle_Previews: PreviewProvider {
//    @State static var selectedDistance: String? = ""
//
//    @State static var selectedRanking: String? = ""
//    @State static var selectedCategory: String? = ""
//    static var previews: some View {
//        MapViewTitle(selectedDistance: $selectedDistance,
//                     selectedCategory: $selectedCategory, selectedRanking: $selectedRanking)
//    }
//}
