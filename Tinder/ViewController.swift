//
//  ViewController.swift
//  Tinder
//
//  Created by Joshua Bell on 7/17/16.
//  Copyright © 2016 Joshua Bell. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    
    let companionAppDeepLink = "tinder://"
    let companionAppWebLink = "https://www.tinder.com"
    let hasRequestedNotificationsKey = "hasRequestedNotifications"
    let initialBadgeCount = 4002
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let foregroundName = UIApplication.willEnterForegroundNotification
        NotificationCenter.default.addObserver(self, selector: #selector(didAppear), name: foregroundName, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.didAppear()
        }
    }

    @objc
    func didAppear() {
        let application = UIApplication.shared
        if  UserDefaults.standard.bool(forKey: self.hasRequestedNotificationsKey) {
            let badgeNumber = application.applicationIconBadgeNumber + 1
            application.applicationIconBadgeNumber = badgeNumber
            self.launchOtherApp()
        } else {
            UserDefaults.standard.set(true, forKey: self.hasRequestedNotificationsKey)
            let options: UNAuthorizationOptions = [.badge];
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
                DispatchQueue.main.async {
                    if granted {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            application.applicationIconBadgeNumber = self.initialBadgeCount
                        })
                        
                        self.launchOtherApp()
                    } else {
                        let alertDefaultAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                        let alertController = UIAlertController.init(title: "Notification explaination", message: "You must allow notifications to get the badge to show up on the app icon! This app does not send you notifications! ", preferredStyle: .alert)
                        alertController.addAction( alertDefaultAction )
                        self.present(alertController, animated: true, completion:nil)
                    }
                }
            }
        }
        
    }
    
    
    func launchOtherApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let application = UIApplication.shared
            guard let uberAppURL = URL(string:self.companionAppDeepLink) else { return }
            if application.canOpenURL( uberAppURL ) {
                application.open(uberAppURL, options: [:], completionHandler: nil)
            } else {
                guard let uberWebURL = URL( string: self.companionAppWebLink ) else { return }
                application.open(uberWebURL, options: [:], completionHandler: nil)
            }
        }
    }
}

