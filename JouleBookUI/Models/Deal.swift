//
//  Deal.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

//
//  Deal.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import UIKit
import SwiftUI
import CoreLocation
import Combine
import URLImage
//import ImageStore Hashable, Identifiable
let instantCats = [Category(id: 1,name: "Babysit",icon: "Artboard 48"),Category(id: 2,name: "Companionship",icon: "Artboard 49"),Category(id: 3,name: "Tutor",icon: "Artboard 41"),Category(id: 4,name: "General office work",icon: "Artboard 51"),Category(id: 5,name: "House cleaning",icon: "Artboard 43"),Category(id: 6,name: "Delivery driver",icon: "Artboard 44"),Category(id: 7,name: "General labor",icon: "Artboard 45"),Category(id: 8,name: "Massage",icon: "Artboard 55"),Category(id: 9,name: "Handyman",icon: "Artboard 56")]
struct Category: Identifiable,Hashable, Codable{
    var id: Int = -1
    var name: String = ""
    var icon: String = ""
}
struct Deal: Identifiable,Hashable, Codable{
    var id:Int = -1
    var address: String = ""
    var addressType: Int = 0
    var approxDuration: Int = 0
    var attachUrl1: String = ""
    var attachUrl2: String = ""
    var attachUrl3: String = ""
    var attachUrl4: String = ""
    var attachUrl5: String = ""
    var building: String = ""
    var categoryId: Int = -1
    var createdTimestamp:String=""
    var dealPrice: Double = 0
    var txtDescription: String = ""
    var expireTime: String = ""
    var floor: String = ""
    var isDeleted: Bool = false
    var lastUpdatedTimestamp: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var name: String=""
    var nonRefundableDeposit: Int = 0
    var normalPrice: Double = 0
    var rateBasis: Int = 0
    var seatsNumber: Int = 0
    var serviceType: Int = 0
    var startTime: String = ""
    var state: String = ""
    var status: Int = 0
    var unit: String = ""
    var useCount: Int = 0
    var useCountLimit: Int = 0
    var userId: Int = -1
    var viewCount: Int = 0
    var zipCode: String = ""
    /*
    var locationCoordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }*/
    /*
    func image(forSize size: Double) -> nil{
         URLImage(
            URL(string:imageName)!,
                processors: [ Resize(size: CGSize(width: size, height: size), scale: UIScreen.main.scale) ],
                placeholder: { _ in
                    Text("Loading...")
                }
        ).frame(width: size, height: size)
    }*/
    //func image (forSize size: Int) -> Image{
         //guard imgUrl = Url(string )
            /*URLSession.shared.dataTask(with: imageName){(data,response,error) in
            if error == nil{
                guard let imageData = data else{return nil}
                return Image(uiImage: imageData)
            }*/
            
       // }
        //task.resume()
        
        //return Image(uiImage: (imageName == nil) ? UIImage(imageL):)
        //ImageStore.shared.image(name: imageName, size: size)
    //}
}


/*
extension Deal {
    var image: Image {
        ImageStore.shared.image(name:imageName)
    }
}*/

