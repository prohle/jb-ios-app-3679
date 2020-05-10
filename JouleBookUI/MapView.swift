//
//  MapView.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/11/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
//import MapKit
import UIKit
import GoogleMaps
class MapViewDelegate:NSObject, GMSMapViewDelegate{
    @Binding var crrCameraPosition: GMSCameraPosition
    /*init(crrCameraPosition: Binding<GMSCameraPosition>) {
        _crrCameraPosition = crrCameraPosition
    }*/
    var parent: MapView
    
    init(_ parent: MapView,crrCameraPosition: Binding<GMSCameraPosition>) {
        self.parent = parent
        _crrCameraPosition = crrCameraPosition
    }
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
      
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        crrCameraPosition = position
    }
}
struct MapView: UIViewRepresentable {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var locationUpdate: LocationUpdate
    var northeast: CLLocationCoordinate2D {return AppUtils().locationWithBearing(bearing: 45,distanceMeters: 500000,origin: CLLocationCoordinate2D(latitude: locationUpdate.location?.latitude ?? 0, longitude: locationUpdate.location?.longitude ?? 0))}
    var southwest: CLLocationCoordinate2D {return AppUtils().locationWithBearing(bearing: 225,distanceMeters: 500000,origin: CLLocationCoordinate2D(latitude: locationUpdate.location?.latitude ?? 0, longitude: locationUpdate.location?.longitude ?? 0))}
    var latitude: Double  { return locationUpdate.location?.latitude ?? 0 }
    var longitude: Double { return locationUpdate.location?.longitude ?? 0 }
    @State var crrCameraPosition: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 20.9430053, longitude: 106.6516233, zoom: 8)
    let marker : GMSMarker = GMSMarker()
    var tabedMarker : GMSMarker = GMSMarker()
    //let landmarks: [LandmarkAnnotation]
    @ObservedObject var observed = DealsObserver()
    /*func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }*/
    
    func makeCoordinator() -> MapViewDelegate {
        return MapViewDelegate(self, crrCameraPosition: $crrCameraPosition)
    }
    /**
     - Description - Replace the body with a make UIView(context:) method that creates and return an empty MKMapView
     */
    func makeUIView(context: Context) -> GMSMapView{
        //MKMapView(frame: .zero)
        let camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: 8)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.setMinZoom(8, maxZoom: 20)
        //mapView.isMyLocationEnabled = true
        //mapView.settings.compassButton = true
        //mapView.settings.myLocationButton = true
        mapView.delegate = context.coordinator
        observed.getDeals()
        //latitude: self.latitude, longitude: self.longitude
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context){
        //If you changing the Map Annotation then you have to remove old Annotations
        //mapView.removeAnnotations(mapView.annotations)
        /*let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let center = CLLocationCoordinate2D(latitude: locationUpdate.location!.latitude, longitude: locationUpdate.location!.longitude)
        let region = MKCoordinateRegion(center: center, span: span)
        view.setRegion(region, animated: true)
        view.delegate = context.coordinator
        if(observed.deals.count > 0){
            view.addAnnotations(converDealToLandmark(observed.deals))
         }*/
        /*let northeast = AppUtils().locationWithBearing(bearing: 45,distanceMeters: 500000,origin: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))
        debugPrint("TOADO")
        debugPrint(northeast)
        let southwest = AppUtils().locationWithBearing(bearing: 225,distanceMeters: 500000,origin: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))
        debugPrint(southwest)*/
            //CLLocationCoordinate2D(latitude: 33.61809349758017, longitude: 122.76468485578222)
        //let southwest = CLLocationCoordinate2D(latitude: 7.005277881679082,longitude: 93.18649873520805)
        //let bounds = GMSCoordinateBounds(coordinate: northeast, coordinate: southwest)
        //let cameraA = mapView.camera(for: bounds, insets: UIEdgeInsets())!
        //mapView.camera = cameraA
        let leftLong = self.southwest.longitude;
        let rightLong =  self.northeast.longitude;
        let bottomLat  =  self.southwest.latitude;
        let topLat  =  self.northeast.latitude;
        if(observed.deals.count > 0 ){
            for deal in observed.deals {
                if let dLat = Double(deal.latitude), let dLon = Double(deal.longitude){
                    marker.position = CLLocationCoordinate2D(latitude: dLat, longitude: dLon)
                    marker.title = deal.name
                    marker.snippet = deal.description
                    marker.map = mapView
                }
            }
        }
        
        /*
        let topLeft: CLLocationCoordinate2D     = CLLocationCoordinate2DMake(topLat, leftLong);
        let topRight: CLLocationCoordinate2D    = CLLocationCoordinate2DMake(topLat, rightLong);
        let bottomLeft: CLLocationCoordinate2D  = CLLocationCoordinate2DMake(bottomLat, leftLong);
        let bottomRight: CLLocationCoordinate2D = CLLocationCoordinate2DMake(bottomLat, rightLong);
        let path: GMSMutablePath = GMSMutablePath()
        path.add(topLeft)
        path.add(topRight)
        path.add(bottomRight)
        path.add(bottomLeft)
        path.add(topLeft)
        let polyLine: GMSPolyline = GMSPolyline(path: path)
        polyLine.strokeWidth = 10.0
        polyLine.strokeColor = Color.main.uiColor()
        polyLine.map = mapView*/
        
        //let currentPos: GMSCameraPosition = context.coordinator.mapView(mapView: mapView, didChangeCameraPosition: mapView.camera)
        
        if(crrCameraPosition.target.latitude > topLat){//// If you scroll past upper latitude
            // Create new campera position AT upper latitude and current longitude (and zoom)
            let backCamera = GMSCameraPosition.camera(withLatitude: topLat, longitude: crrCameraPosition.target.longitude, zoom: crrCameraPosition.zoom)
            mapView.animate(to: backCamera)
            
            //debugPrint("latitude > topLat")
            //debugPrint(crrCameraPosition.target.latitude)
        }
        if (crrCameraPosition.target.latitude < bottomLat) {
            //debugPrint("latitude < bottomLat")
            //debugPrint(crrCameraPosition.target.latitude)
            let backCamera = GMSCameraPosition.camera(withLatitude: bottomLat, longitude: crrCameraPosition.target.longitude, zoom: crrCameraPosition.zoom)
            mapView.animate(to: backCamera)
        }
        if (crrCameraPosition.target.longitude > rightLong) {
            //debugPrint("longitude > rightLong")
            //debugPrint(crrCameraPosition.target.longitude)
            let backCamera = GMSCameraPosition.camera(withLatitude: crrCameraPosition.target.latitude, longitude:rightLong, zoom: crrCameraPosition.zoom)
            mapView.animate(to: backCamera)
        }
        if (crrCameraPosition.target.longitude < leftLong) {
            //debugPrint("longitude < leftLong")
            //debugPrint(crrCameraPosition.target.longitude)
            let backCamera = GMSCameraPosition.camera(withLatitude: crrCameraPosition.target.latitude, longitude:leftLong, zoom: crrCameraPosition.zoom)
            mapView.animate(to: backCamera)
        }
    }
    func converDealToLandmark(_ deals: [Deal]) -> [LandmarkAnnotation]{
        var landmarks: [LandmarkAnnotation] = [LandmarkAnnotation]()
        if(deals.count > 0){
            for deal in deals {
                let landmark = LandmarkAnnotation(title: deal.name,subtitle: deal.description,coordinate: CLLocationCoordinate2D(latitude: (deal.latitude as NSString).doubleValue,longitude: (deal.longitude as NSString).doubleValue))
                landmarks.append(landmark)
            }
        }
        return landmarks
    }
}
/*
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}*/
