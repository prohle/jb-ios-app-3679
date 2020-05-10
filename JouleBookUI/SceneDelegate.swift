//
//  SceneDelegate.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import UIKit
import SwiftUI
import KeychainAccess

class UserSettings: ObservableObject {
    @Published var loggedIn : Bool = false
}
class UserOnboard: ObservableObject {
    @Published var onboardComplete : Bool = false
}
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //BaseView().environmentObject(ViewRouter())
            //let contentView = StartOnboardView()
            //let onboard = UserOnboard()
        let viewrouter = ViewRouter()
        let locationupdate = LocationUpdate()
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        let token = try! keychain.getString("access_token") ?? ""
        //let rereshToken = try! keychain.getString("refresh_token") ?? ""
        
        if(token != ""){
            debugPrint("Token did saved: "+token)
            viewrouter.currentPage = "home"
            viewrouter.onboardComplete = true
            viewrouter.loggedIn = true
            //onboard.accessToken = token
            //onboard.refreshToken = rereshToken
        }
        // Use a UIHostingController as window root view controller
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: BaseView().environmentObject(viewrouter).environmentObject(locationupdate))
            /*if(viewrouter.loggedIn == true){
                window.rootViewController = UIHostingController(rootView: StartView().environmentObject(viewrouter))
            }else{
                window.rootViewController = UIHostingController(rootView: StartOnboardView().environmentObject(viewrouter))
            }*/
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    struct StartView: View {
        @EnvironmentObject var viewrouter: ViewRouter
        var body: some View {
            if viewrouter.loggedIn == true {
                return AnyView(BaseView().environmentObject(viewrouter))
            } else {
                return AnyView(SignIn().environmentObject(viewrouter))
            }
        }
    }

    struct StartOnboardView: View {
        @EnvironmentObject var viewrouter: ViewRouter
        var body: some View {
            let contentView = StartView()
            //let settings = UserSettings()
            if viewrouter.onboardComplete {
                /*let keychain = Keychain(service: "ISOWEB.JouleBookUI")
                let token = try! keychain.getString("access_token") ?? ""
                if(token != ""){
                    debugPrint("Token did saved2 : "+token)
                    viewrouter.loggedIn = true
                }*/
                return AnyView(contentView.environmentObject(viewrouter))
            } else {
                return AnyView(Welcome().environmentObject(viewrouter))
                /*
                if userViewModel.accessToken != "" {
                    return AnyView(BaseView().environmentObject(ViewRouter()))
                } else {
                    return AnyView(Welcome().environmentObject(userViewModel))
                }*/
            }
        }
    }

}

