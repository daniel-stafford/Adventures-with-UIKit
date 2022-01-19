//
//  ViewController.swift
//  LocalNotify
//
//  Created by Daniel Stafford on 1/19/22.
//

import UIKit
// new framework for user notifications
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
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

    @objc func scheduleLocal(isReminder: Bool = false) {
        registerCategories()

        let center = UNUserNotificationCenter.current()
        // only show new notifications
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
        let trigger = isReminder ? UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) : UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // can use whatever identifier, but must be unique
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        // any messages sent, get reported to us, so remember that class must conform to UNUserNotificationCenterDelegate
        center.delegate = self

        // identifier is internal
        // foreground = when tapped, launch app
        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
        let ignore = UNNotificationAction(identifier: "kill", title: "Stop this madness", options: .foreground)
        let remind = UNNotificationAction(identifier: "remind", title: "Remind me later", options: .destructive)

        // identifier must match with content.categoryIdentifier
        // intents relates to talking to Siri
        // options - carPlay support, custom dismiss etc.
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, ignore, remind], intentIdentifiers: [], options: [])

        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                runAlert(title: "Default identifier", message: "You swiped")
            case "show":
                // the user tapped our "show more info…" button
                runAlert(title: "Show more info", message: "Blah blah blah")
            case "kill":
                // tapped ignore
                runAlert(title: "Notification stopped", message: "Alright, alright. Forget about it!")
            case "remind":
                scheduleLocal(isReminder: true)
            default:
                break
            }
        }

        // you must call the completion handler when you're done
        completionHandler()
    }

    func runAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
