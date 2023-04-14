//
//  AppDelegate.swift
//  FosterApp
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import CoreDataUtilsKit
import UtilsKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        TODO: Faire quelque chose ici pour changer le view controller initial
        
        // MARK: - CoreData
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths.first
        log(.data, "Documents directory: \(documentsDirectory?.absoluteString ?? ":danger: No documents directory file !")")
        do {
            try CoreDataManager.default.setCoreDataStack("FosterApp")
            log(.data, "core data succes")
        } catch {
            log(.data, "fail core data init", error: error)
        }
        
        // MARK: - FireBase
        FirebaseApp.configure()
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    
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

