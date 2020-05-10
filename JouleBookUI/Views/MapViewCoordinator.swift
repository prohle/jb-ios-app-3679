//
//  MapViewCoordinator.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/11/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import Foundation
import UIKit
import MapKit

/*
  Coordinator for using UIKit inside SwiftUI.
 */
class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewController: MapView
    
    init(_ control: MapView) {
        self.mapViewController = control
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
         //Custom View for Annotation
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "dealplacemark")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        //Your custom image icon
        annotationView.image = UIImage(named: "locationPin")
        return annotationView
    }
    
}
