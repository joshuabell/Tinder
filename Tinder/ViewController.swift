//
//  ViewController.swift
//  Tinder
//
//  Created by Joshua Bell on 7/17/16.
//  Copyright © 2016 Joshua Bell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let application = UIApplication.sharedApplication()
        if application.applicationIconBadgeNumber > 0 {
            let badgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
            application.applicationIconBadgeNumber = badgeNumber
            (application.delegate as! AppDelegate).launchTinderApp(application)
        } else {
            let alertDefaultAction = UIAlertAction.init(title: "Ok", style: .Default, handler: { (action) -> Void in
                application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:UIUserNotificationType.Badge, categories: nil
                    ))
            })
            
            let alertController = UIAlertController.init(title: "Notification explaination", message: "You must accept notifications to get the badge to show up on the app icon! This app does not send you notifications! ", preferredStyle: .Alert)
            alertController.addAction(alertDefaultAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
}

