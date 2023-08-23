//
//  StoreMapView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/13.
//

// MARK: - 수정

import SwiftUI
import MapKit
import CoreLocation

struct StoreMapView: View {
    @StateObject private var viewModel = ContentViewModel() // 차후 카카오 지도로 대체 필요
    
    var body: some View{
        ZStack(alignment:.bottomTrailing) {
            Map(coordinateRegion: $viewModel.region,showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            
            HStack(alignment: .center, spacing: 0) {
                Image("map")
                .frame(width: 24, height: 24)
            }
            .padding(7)
            .frame(width: 38, height: 38, alignment: .center)
            .background(Color.BlackWhiteWhite)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.11), radius: 4, x: 0, y: 4)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .frame(width: 343, height: 181) // 차후 비율로 조정 필요
        .cornerRadius(8)
        
    }
}


struct StoreMapView_Previews: PreviewProvider {
    static var previews: some View {
        StoreMapView()
    }
}
