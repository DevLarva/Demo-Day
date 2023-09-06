//
//  MapViewModel.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/14.
//

import MapKit
import CoreLocation

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 35.1798, longitude: 128.1076)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
}

final class ContentViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startingLocation,
        span: MapDetails.defaultSpan)
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            //locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self

        } else {
            print("위치 권한을 허용해주세요.")
        }
    }
    func setRegion(for location: CLLocationCoordinate2D) {
        let regionSpan = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        region = regionSpan
    }
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("당신의 위치 권한에 접근이 불가 합니다.")
        case .denied:
            print("당신의 위치 권한에 접근이 불가 합니다.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(
                center: locationManager.location!.coordinate,
                span: MapDetails.defaultSpan)

        @unknown default:
            break
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

