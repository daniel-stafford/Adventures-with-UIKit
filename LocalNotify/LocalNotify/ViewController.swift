//
//  ViewController.swift
//  LocalNotify
//
//  Created by Daniel Stafford on 1/19/22.
//

import UIKit
// new framework for user nitifications
import UserNotifications

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        // show message, badge on icon, play a sound
        // to delete permissions, go to hardware menu, and erase all content and settings
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }

    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        //only show new notifications
        center.removeAllPendingNotificationRequests()
        // create content
        let content = UNMutableNotificationContent()
        // big text, just a couple of words at most
        content.title = "Late wake up call"
        // main text for notification, e.g. actual content of text message
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        // custom action
        content.categoryIdentifier = "alarm"
        // custom data to attach
        content.userInfo = ["customData": "fizzbuzz"]
        // specify sound or use default
        content.sound = UNNotificationSound.default

        // create calendar notification
        var dateComponents = DateComponents()
        // 10:30
        dateComponents.hour = 10
        dateComponents.minute = 30
    
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // can use whatever identifier, but must be unique
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
