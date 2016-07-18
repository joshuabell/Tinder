//
//  AppDelegate.swift
//  Tinder
//
//  Created by Joshua Bell on 7/17/16.
//  Copyright © 2016 Joshua Bell. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.applicationIconBadgeNumber = 4002
        self.launchTinderApp( application )
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        self.launchTinderApp( application )
    }
    
    func launchTinderApp( application: UIApplication ) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.02 * Double(NSEC_PER_SEC)))
        dispatch_after( delayTime, dispatch_get_main_queue()) {
            let uberAppURL = NSURL.init( string:"tinder://")
            if application.canOpenURL(uberAppURL!) {
                application.openURL(uberAppURL!)
            } else {
                let uberWebURL = NSURL.init( string:"https://www.tinder.com")
                application.openURL( uberWebURL! )
            }
        }
    }


}

