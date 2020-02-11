//
//  ViewController.swift
//  PlayProject
//
//  Created by Roman Bogun on 7/15/19.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    private var granted = false
    private let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageLabelMask: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerToNotifs()
        self.imagePicker.delegate = self
    }
}

extension ViewController {
    
    @IBAction func pushLocalNotification(_ sender: Any) {
        
        guard self.granted else {
            return
        }
        
        let center = UNUserNotificationCenter.current()
        
        let content =  UNMutableNotificationContent()
        content.title = "Hey wake up, man!"
        content.body = "The aerly bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "Ho-Ho"]
        content.sound = .default
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        var dateComponent = DateComponents()
        dateComponent.hour = 16
        dateComponent.minute = 20
        
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    private func registerToNotifs() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound, .criticalAlert]) { [weak self] (granted, error) in
            
            self?.granted = granted
            
            if granted {
                print("Yeah!")
            } else {
                print("D'oh!")
            }
        }
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func showImagePicker(_ sender: Any) {
        self.imagePicker.sourceType = .camera
        self.present(self.imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
//            self.imageView.image = pickedImage
//            self.imageView.layer.mask = self.imageLabelMask.layer
//            self.imageView.mask.bo
//            self.imageView.layer.masksToBounds = true
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    @IBAction func shakeTheView(_ sender: Any) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -7.0, 7.0, -5.0, 5.0, 0.0]
        
        if let button = sender as? UIButton {
            button.layer.add(animation, forKey: "shake")
        }
    }
}

extension ViewController {
    @IBAction func swipeGesture(_ sender: Any) {
        if let gesture = sender as? UISwipeGestureRecognizer {
            
            let message = "Swipe to the \(gesture.direction.rawValue)"
            showAlert(message: message)
        }
    }
    
    @IBAction func edgePanGesture(_ sender: Any) {
        if sender is UIScreenEdgePanGestureRecognizer {
            
            let message = "Edge pan gesture"
            showAlert(message: message)
        }
    }
    
    @IBAction func longpressGesture(_ sender: Any) {
        if sender is UILongPressGestureRecognizer {
            
            let message = "Longpress gesture"
            showAlert(message: message)
        }
    }
}

extension ViewController {
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}

