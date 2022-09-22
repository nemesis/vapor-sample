//
//  AppDelegate.swift
//  VaporSample
//
//  Created by Constantin Lungu on 22.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Server.start()

    return true
  }

  // Our attempt at making sure we don't crash in the background
  func applicationDidEnterBackground(_ application: UIApplication) {
    Server.shutdown()
  }

  // Make sure we restart the server once entering foreground
  func applicationWillEnterForeground(_ application: UIApplication) {
    Server.start()
  }

}

