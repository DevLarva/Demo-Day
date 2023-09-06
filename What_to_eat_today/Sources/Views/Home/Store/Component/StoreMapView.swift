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

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $viewModel.region,
                annotationItems: mapViewModel.annotations) { annotation in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: annotation.position.y, longitude: annotation.position.x), tint: .red)
                }
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
                .onAppear {
                    mapViewModel.setAnnotation(for: storeDetail)
                    viewModel.setRegion(for: CLLocationCoordinate2D(latitude: storeDetail.y, longitude: storeDetail.x))
                }
        }
        .frame(width: 343, height: 181) // 차후비율로조정필요
        .cornerRadius(8)
    }
}

class StoreMapViewModel: ObservableObject {
    @Published var annotations: [CustomAnnotation] = []
    
    func setAnnotation(for storeDetail: StoreDetailResponse) {
        let annotation = CustomAnnotation(title: storeDetail.storeName, position: Position(x: storeDetail.y, y: storeDetail.x))
        annotations.append(annotation)
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

struct StoreDetailResponseExample {
    static let sampleData = StoreDetailResponse(storeName: "가게 예시", category: "식당", imageUrl: nil, keywords: [], tags: [:], status: true, phoneNumber: "010-1234-5678", address: "대한민국 어디엔가", time: "10:00 ~ 22:00", imageCount: 0, x: 128.1054441100458, y: 35.15615892617527)
}

struct StoreMapView_Previews: PreviewProvider {
    static var previews: some View {
        StoreMapView(storeDetail: StoreDetailResponseExample.sampleData)
    }
}

