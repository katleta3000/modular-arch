//
//  AppDelegate.swift
//  AppA
//
//  Created by Evgenii Rtischev on 04/06/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	lazy var appStartRule = AppStartRule()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		appStartRule.perform()
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

