//
//  UIDevice+Vibrate.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import AudioToolbox
import UIKit

extension UIDevice {
    
    /**
        Generate a haptic feedback
     
        - parameter type: type of the feedback (.success, .warning or .error)
     */
    @available(iOS 10.0, *)
    public static func vibrate(_ type: UINotificationFeedbackGenerator.FeedbackType? = .error) {
        if let type: UINotificationFeedbackGenerator.FeedbackType = type {
            if let feedbackSupportLevel = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int {
                if feedbackSupportLevel == 2 {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(type)
                    return
                }
            }
        }
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
