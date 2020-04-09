//
//  Welcome.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import Foundation
import SwiftUI
struct TrackPixelConfig {
    static let TrackTagURL: String = "http://ada0d8307545b11eaa56a067f445bde2-1694308063.us-west-2.elb.amazonaws.com:2550/api/track/1234/12/5?fromemail=isotemplates@gmail.com"
    static let FrameworkName = "TrackPixelSDK"
    static let FrameworkVersion = "1.0"
}
struct UserAgent {
    static func getUserAgent() -> String {
        let bundleDict = Bundle.main.infoDictionary!
        let appName = bundleDict["CFBundleName"] as? String ?? TrackPixelConfig.FrameworkName
        let appVersion = bundleDict["CFBundleShortVersionString"] as? String ?? TrackPixelConfig.FrameworkVersion
        let appDescriptor = appName + "/" + appVersion
        
        let currentDevice = UIDevice.current
        let osDescriptor = "iOS/" + currentDevice.systemVersion
        
        let hardwareString = self.getHardwareString()
        
        return appDescriptor + " (" + TrackPixelConfig.FrameworkName + " " + TrackPixelConfig.FrameworkVersion
            + ") " + osDescriptor + " (" + hardwareString + ")"
    }
    
    static func getHardwareString() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, nil, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, nil, 0)
        
        let hardware: String = String.init(validatingUTF8: hw_machine)!
        return hardware
    }
    
}
struct Welcome: View {
    //@EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var viewrouter: ViewRouter
    var subViews = [
        UIHostingController(rootView: SubSliderViewOne()),
        UIHostingController(rootView: SubSliderViewTwo()),
        UIHostingController(rootView: SubSliderViewOne())
    ]
    
    @State var currentPageIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            PageViewController(currentPageIndex: $currentPageIndex,viewControllers: subViews)
            //.frame(height: (UIScreen.main.bounds.width * 500) / 414)
            HStack {
                //SVGImage()
                Button(action: {
                    //self.report()
                    if self.currentPageIndex >= 1 {
                        self.currentPageIndex -= 1
                    }
                    
                }) {
                    Text("PREV").bold().foregroundColor(Color.white).font(.body)
                }
                Spacer()
                //CircleImage(imageUrl: TrackPixelConfig.TrackTagURL,size: 111)
                PageControl(numberOfPages: subViews.count, currentPageIndex: $currentPageIndex)
                Spacer()
                Button(action: {
                    if self.currentPageIndex + 1 == self.subViews.count {
                        //self.viewRouter.currentPage = "signin"
                        self.viewrouter.onboardComplete = true
                                    //self.userOnboard.onboardComplete = true
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    Text("NEXT").bold().foregroundColor(Color.white).font(.body)
                }
            }.padding(10).background(Color.main)
        }
    }
    func report(){
        let userAgentStr = UserAgent.getUserAgent()
        
        let pixelUrl = URL(string: TrackPixelConfig.TrackTagURL)
        
        let config = URLSessionConfiguration.default
        
        let headers: [String: String] = ["User-Agent": userAgentStr]
        
        config.httpAdditionalHeaders = headers
        
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: pixelUrl!) {(data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let usableData = data {
                    
                    print(usableData)
                }
            }
        }
        
        task.resume()
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
