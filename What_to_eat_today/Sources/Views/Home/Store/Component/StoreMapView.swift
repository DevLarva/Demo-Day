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
    var storeDetail: StoreDetailResponse // 가게 정보를 전달받음
    @StateObject private var mapViewModel = StoreMapViewModel()
    @StateObject private var viewModel = ContentViewModel()
    
    
    
    @ObservedObject var storeVM: StoreVM
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .bottomTrailing) {
                Map(coordinateRegion: $viewModel.region,
                    annotationItems: mapViewModel.annotations) { annotation in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: annotation.position.x, longitude: annotation.position.y), tint:.red)
                }
                    .ignoresSafeArea()
                    .accentColor(Color(.systemPink))
                    .onReceive(storeVM.$storeDetailData) { newStoreDetail in
                        mapViewModel.setAnnotation(for: newStoreDetail)
                        viewModel.setRegion(for: CLLocationCoordinate2D(latitude: newStoreDetail.y, longitude: newStoreDetail.x))
                    }
            }
        } .frame(width: 343, height: 181) // 차후비율로조정필요
            .cornerRadius(8)
    }
}
    class StoreMapViewModel: ObservableObject {
        @Published var annotations: [CustomAnnotation] = []
        
        func setAnnotation(for storeDetail: StoreDetailResponse) {
            let annotation = CustomAnnotation(title: storeDetail.storeName, position: Position(x: storeDetail.y, y: storeDetail.x ))
            annotations.append(annotation)
            print("x: \(storeDetail.x)")
            print("y: \(storeDetail.y)")
        }
    }
    
    struct CustomAnnotation: Identifiable {
        let id = UUID()
        let title: String?
        let position: Position
    }
    
    struct Position {
        let x: Double
        let y: Double
    }
    



    
