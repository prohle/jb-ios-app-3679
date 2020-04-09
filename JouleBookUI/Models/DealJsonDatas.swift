//
//  DealJsonDatas.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/13/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

let dealDatas: [Deal] = loadJson("Deals.json")
let jobDatas: [Job] = loadJson("Jobs.json")
func loadJson<T: Decodable>(_ fileName:String, as type: T.Type = T.self) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Couldnt find \(fileName) in main bundle")
    }
    do{
        data = try Data(contentsOf: file)
    }catch{
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch{
        fatalError("Could'n parse \(fileName) as \(T.self):\n\(error)")
    }
}
final class ImageStore{
    fileprivate typealias _ImageDirectory = [String: [Int: CGImage]]
    fileprivate var images : _ImageDirectory = [:]
    fileprivate static var originalSize = 250
    fileprivate static var scale = 2
    static var shared = ImageStore()
    func image(name: String, size: Int)-> Image{
        let index = _guaranteeInitialImage(name: name)
        let sizeImaged = images.values[index][size] ?? _sizeImage(images.values[index][ImageStore.originalSize]!, to: size * ImageStore.scale) /*if dont have images.values[index][size] -> call _sizeImage**/
        images.values[index][size] = sizeImaged
        return Image(sizeImaged,scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }
    fileprivate func _guaranteeInitialImage(name: String) ->_ImageDirectory.Index{
        if let index = images.index(forKey: name){return index}
        
        guard
            let url = Bundle.main.url(forResource: name, withExtension: ""),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
            else{
                fatalError("Could'n load image \(name).jpg from main bundle")
        }
        images[name] = [ImageStore.originalSize: image]
        return images.index(forKey: name)!
    }
    fileprivate func _sizeImage(_ image:CGImage, to size:Int) -> CGImage{
        guard
            let colorSpace = image.colorSpace,
        let context = CGContext(data: nil, width: size, height: size, bitsPerComponent: image.bitsPerComponent, bytesPerRow: image.bytesPerRow, space: colorSpace, bitmapInfo: image.bitmapInfo.rawValue)
            else{
                fatalError("Couldn't create graphics context.")
        }
        context.interpolationQuality = .high
        context.draw(image, in: CGRect(x:0,y:0,width: size, height: size))
        if let sizedImage = context.makeImage(){
            return sizedImage
        }else{
            fatalError("Couldnt resize image")
        }
    }
}
