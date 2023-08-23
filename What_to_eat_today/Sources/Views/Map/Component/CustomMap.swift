//
//  CustomMap.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/08.
//

import SwiftUI
import MapKit

struct CustomMapView: UIViewRepresentable {
    @Binding var coordinateRegion: MKCoordinateRegion
    var annotations: [Location]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(coordinateRegion, animated: true)

        let currentAnnotations = uiView.annotations
        uiView.removeAnnotations(currentAnnotations)
        
        for annotation in annotations {
            let annotationPoint = MKPointAnnotation()
            annotationPoint.coordinate = annotation.coordinate
            annotationPoint.title = annotation.name
            uiView.addAnnotation(annotationPoint)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CustomMapView

        init(_ parent: CustomMapView) {
            self.parent = parent
        }

        func coordinatesAreEqual(_ coord1: CLLocationCoordinate2D, _ coord2: CLLocationCoordinate2D) -> Bool {
            let epsilon = 1e-5
            let latEqual = abs(coord1.latitude - coord2.latitude) < epsilon
            let lonEqual = abs(coord1.longitude - coord2.longitude) < epsilon
            return latEqual && lonEqual
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if !(annotation is MKPointAnnotation) { return nil }
            
            let reuseIdentifier = "custom"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            let matchingLocation = parent.annotations.first { coordinatesAreEqual($0.coordinate, annotation.coordinate) }

            
            if let customMapMarker =
                matchingLocation.map({ CustomMapMarker(location: $0, selectedLocation: .constant(nil)) }) {
                annotationView?.image = UIImage(systemName: "mappin")
                annotationView?.detailCalloutAccessoryView = UIHostingController(rootView: customMapMarker).view
            }
            
            return annotationView
        }
    }
}
