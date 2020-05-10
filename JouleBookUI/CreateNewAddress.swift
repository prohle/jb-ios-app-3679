//
//  CreateNewAddress.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Alamofire
import KeychainAccess
import Combine
import GooglePlaces
class PlaceCoordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {
    var parent: PlacePicker

    init(_ parent: PlacePicker) {
        self.parent = parent
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        DispatchQueue.main.async {
            let placesClient = GMSPlacesClient()
            let placeID = place.placeID
            if(placeID != nil ){
                placesClient.lookUpPlaceID(placeID! , callback: { (place, error) -> Void in
                    if let error = error {
                        print("lookup place id query error: \(error.localizedDescription)")
                        return
                    }

                    guard let place = place else {
                        print("No place details for \(String(describing: placeID))")
                        return
                    }
                    self.parent.latitude = place.coordinate.latitude
                    self.parent.longitude = place.coordinate.longitude
                    self.parent.address =  place.formattedAddress ?? ""
                    if(place.addressComponents != nil){
                        for addressComponent in place.addressComponents! {
                            for type in (addressComponent.types){
                                switch(type){
                                    case "state":
                                        //print("State \(String(describing: addressComponent.name))")
                                        self.parent.state = addressComponent.name
                                    case "city":
                                        self.parent.city = addressComponent.name
                                        //print("City \(String(describing: addressComponent.name))")
                                    case "postal_code":
                                        //print("Zipcode \(String(describing: addressComponent.name))")
                                        self.parent.zip_code = addressComponent.name
                                default:
                                    break
                                }
                            }
                        }
                    }
                    /*print("Place name \(String(describing: place.name))")
                    print("Place latlng \(String(describing: place.coordinate.latitude)) - \(String(describing: place.coordinate.longitude))")
                    
                    print("Place address \(String(describing: place.formattedAddress))")
                    print("Place placeID \(String(describing: place.placeID))")
                    print("Place attributions \(String(describing: place.attributions))")*/

                })
            }
            
            /*
            debugPrint("------GOOLEPLACE-------",place.coordinate.latitude,place.coordinate.longitude, place.addressComponents)
            if(place.addressComponents != nil){
                for addressComponent in place.addressComponents! {
                    for type in (addressComponent.types){
                        switch(type){
                            case "state":
                                self.parent.state = addressComponent.name
                            case "city":
                                self.parent.city = addressComponent.name
                            case "postal_code":
                                 self.parent.zip_code = addressComponent.name
                        default:
                            break
                        }
                    }
                }
            }*/
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        parent.presentationMode.wrappedValue.dismiss()
    }
}
struct PlacePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> PlaceCoordinator {
        PlaceCoordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var address: String
    @Binding var city: String
    @Binding var state: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    @Binding var zip_code: String
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePicker>) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
          UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "VN"
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePicker>) {
    }
}
struct CreateNewAddress: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var addressObservable = AddressObservable()
    @EnvironmentObject var locationUpdate: LocationUpdate
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    VStack{
                        //Text("\(String(locationUpdate.location?.latitude))")
                        HStack{
                            IconText(imageIconLeft: nil,text: "Name", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("Set Name", text: $addressObservable.address_name)
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: nil,text: "Phone Number", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("Set Phone Number", text: $addressObservable.phone_number)
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        HStack{
                            IconText(imageIconLeft: nil,text: "Address", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            //VStack{
                                //PlacePicker(address: self.$addressObservable.address)
                            //}.frame(width: 200,height: 180)
                            TextField("Set your full address", text: $addressObservable.address)
                            .onTapGesture {
                              self.showSheet.toggle()
                            }
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                            /**/
                        }
                        
                        HStack{
                            IconText(imageIconLeft: nil,text: "Building/Suite/ Apt Number", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("                  ", text: $addressObservable.address_line_2 ?? "")
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }
                        /*HStack{
                            IconText(imageIconLeft: nil,text: "Suite/ Apt Number", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            TextField("                  ", text: $addressObservable.suite_apt_number)
                            .font(Font.textbody)
                            .foregroundColor(Color.maintext)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .padding(2)
                        }*/
                        HStack{
                            IconText(imageIconLeft: "",text: "Address Type", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            VStack(alignment: .trailing){
                                RadioButton(text: "Residential", isOn: self.$addressObservable.address_type_1)
                                RadioButton(text: "Business/Commercial", isOn: self.$addressObservable.address_type_2)
                                RadioButton(text: "Public", isOn: self.$addressObservable.address_type_3)
                            }
                        }
                        HStack{
                            IconText(imageIconLeft: "",text: "Set as default Address", iconLeftSize: 16, color: Color.maintext)
                            Spacer()
                            Toggle(isOn: self.$addressObservable.is_default) {
                                TextBody(text: ((self.addressObservable.is_default) ? "On" : "Off"), color: Color.maintext)
                            }.padding()
                        }
                    }.sheet(isPresented: $showSheet) {
                        PlacePicker(address: self.$addressObservable.address,city: self.$addressObservable.city,state: self.$addressObservable.state,latitude: self.$addressObservable.latitude,longitude: self.$addressObservable.longitude, zip_code: self.$addressObservable.zip_code)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: AddressTopSaveTabbar().environmentObject(self.addressObservable))
        }
    }
    
}
struct AddressTopSaveTabbar: View {
    @EnvironmentObject var addressObservable: AddressObservable
    var body: some View {
        HStack{
            Button(action: {
                self.addressObservable.submitAddress()
            }) {
                Image( "Artboard 8")
                    .resizable()
                    .imageScale(.small)
                    .frame(width:20,height:20)
                    .accentColor(Color.main)
            }
        }
    }
}
struct CreateNewAddress_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewAddress()
    }
}
