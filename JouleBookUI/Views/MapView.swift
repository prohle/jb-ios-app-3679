//
//  MapView.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        //let coordinate = CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}
/*
struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: dealDatas[0].locationCoordinate)
    }
}*/
