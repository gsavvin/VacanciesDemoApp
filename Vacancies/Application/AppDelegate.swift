//
//  AppDelegate.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vacationsListVc = VacanciesListAssembly.make()
        let navVc = UINavigationController.init(rootViewController: vacationsListVc)
        self.window?.rootViewController = navVc
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

