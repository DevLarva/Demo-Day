//
//  MapView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/13.
//

import SwiftUI
import MapKit
import CoreLocation
import Foundation



struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let isheart: Bool
}


struct CustomMapMarker: View {
    var location: Location
    @Binding var selectedLocation: Location?
    
    var body: some View {
        Button(action: {
            selectedLocation = location
        }, label: {
            ZStack(alignment: .center) {
                
                
                if location.isheart {
                    
                    Image("Pin")
                        .frame(width: 39.98141, height: 45.6038)
                    
                    Image("heartmap")
                        .frame(width: 20, height: 20)
                        .padding(.bottom, 8)
                } else {
                    
                    Image("Pin icon")
                        .frame(width: 39.98141, height: 45.6038)
                    
                    Image("storefront")
                        .frame(width: 20, height: 20)
                        .padding(.bottom, 8)
                }
                
            }.frame(width: 40, height: 46)
        })
    }
}

struct MapViewSE: View {
    @StateObject private var storeVM = StoreVM()
    
    @State private var selectedDistance: String = "7분 · 500m"
    @State private var selectedCategory: String = "선택안함"
    @State private var selectedRanking: String = "선택안함"
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.15379771232859, longitude: 128.1071434872781), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @State private var selectedLocation: Location?
    @State private var showingHalfSheet = false
    @State private var showingStoreView = false
    
    @State var locations: [Location] = []
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                VStack {
                    MapViewTitle(selectedDistance: $selectedDistance, selectedCategory: $selectedCategory, selectedRanking: $selectedRanking)
                }.onChange(of: selectedDistance) { newValue in
                    updateMapList()
                }
                .onChange(of: selectedCategory) { newValue in
                    updateMapList()
                }
                .onChange(of: selectedRanking) { newValue in
                    updateMapList()
                }
                .zIndex(1)
                
                VStack {
                    //NaverMap()
                    Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            CustomMapMarker(location: location, selectedLocation: $selectedLocation)
                        }
                        
                    }
                    .sheet(item: $selectedLocation) { location in
                        if let index = locations.firstIndex(where: { $0.id == location.id }) {
                            CustomButton(storeId: location.name, showingStoreView: $showingStoreView)
                                .sheet(isPresented: $showingStoreView) {
                                    NavigationView{
                                        StoreView(storeId: location.name
                                        )
                                    }
                                }
                                .presentationDetents([.height(350)])
                                .presentationDragIndicator(.visible)
                        }
                    }
                }
            }
        }
        .onAppear {
            updateMapList()
            Coordinator.shared.checkIfLocationServiceIsEnabled()
            storeVM.taskSuccess
                .sink { _ in
                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(storeVM.mapListData.campers.y), longitude: CLLocationDegrees(storeVM.mapListData.campers.x)), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
                    var tempLocations = [Location]()
                    for store in storeVM.mapListData.stores {
                        let location = Location(name: store.id, coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(store.y), longitude: CLLocationDegrees(store.x)), isheart: store.isWishlist)
                        tempLocations.append(location)
                    }
                    
                    DispatchQueue.main.async {
                        locations = tempLocations
                    }
                }
                .store(in: &storeVM.subscription)
            Coordinator.shared.checkIfLocationServiceIsEnabled()
        }
    }
    func updateMapList() {
        let distanceInMeters: Int

        switch selectedDistance {
            case "10분+ · 1.3km":
                distanceInMeters = 1300
            case "10분 · 700m":
                distanceInMeters = 700
            case "7분 · 500m":
                distanceInMeters = 500
            case "5분 · 300m":
                 distanceInMeters = 300
        case "2분 · 100m":
             distanceInMeters = 100
             default:
                 // 선택된 거리가 위의 경우들이 아닌 경우에는 그대로 받아옵니다.
                 if let meterValue = Int(selectedDistance) {
                     distanceInMeters = meterValue
                  } else {
                      // 만약 변환할 수 없는 값이라면 기본값으로 설정합니다.
                      distanceInMeters = 0
                   }
         }
        print("distanceInMeters :", distanceInMeters)
        let ranking: [String]? = selectedRanking == "선택안함" ? nil : [selectedRanking]
        let categories: [String]? = selectedCategory == "선택안함" ? nil : [selectedCategory]
        storeVM.mapList(distance: distanceInMeters, keyword: ranking, category: categories)
    }






}

struct CustomButton: View {
    let storeId: String
    @Binding var showingStoreView: Bool
    
    var body: some View {
        Button(action: {
            showingStoreView = true
        }) {
            MapStoreMainView(storeId: storeId)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapViewSE()
    }
}
