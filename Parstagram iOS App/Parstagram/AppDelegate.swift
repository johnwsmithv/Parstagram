//
//  AppDelegate.swift
//  Parstagram
//
//  Created by John Smith V on 3/16/21.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // This is all of the data base stuff that we are going to need to use to get the app working and syncing with the database
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "z3zsxKLVSkm4fwyccMfJW08EaT3SOUKW2DAlaqtt"
            $0.clientKey = "3qx1oLiBZKOp8viKTwHQCI2bPBUJva2X7sax8LvU"
            $0.server = "https://parseapi.back4app.com"
        }
        
        Parse.initialize(with: parseConfig)
        
//        if PFUser.current() != nil {
//            let main = UIStoryboard(name: "Main", bundle: nil)
//            let feedNavigationController = main.instantiateViewController(withIdentifier: "FeedNavigationController")
//            
//            
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

