//
//  AlertManager.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

/**
 Represent an action for an alert controller.
 */
public struct AlertAction {
    
    /// Title of the action
    public let title: String
    
    /// Style of the action
    public let style: UIAlertAction.Style
    
    /// Completion of the action
    public let completion: (() -> Void)?
    
    
    /**
     Init an action
     
     - parameter title: title of the action.
     - parameter style: style of the action.
     - parameter completion: completion of the action
     */
    public init(title: String, style: UIAlertAction.Style, completion: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.completion = completion
    }
}

/**
 Manage alert controllers with a single method `show`.
 */
@available(iOSApplicationExtension, introduced: 1.0, unavailable)
public struct AlertManager {
    
    // MARK: Singleton
    /// The shared singleton AlertManager object
    public static var shared = AlertManager()
    
    private init() { }
    
    /**
     Show an alert controller on top of the navigation stack.
     
     - parameter actions: list of actions.
     - parameter title: title of the alert.
     - parameter message: message of the alert.
     - parameter alignment: alignment of the message.
     - parameter preferredStyle: controller style.
     */
    public func show(actions: [AlertAction],
                     title: String? = nil,
                     message: String? = nil,
                     alignment: NSTextAlignment = .center,
                     preferredStyle: UIAlertController.Style = .alert,
					 sourceView: UIView? = nil) {
                
        DispatchQueue.main.async {
            guard let currenViewController = UIApplication.shared.topViewController else { return }
            
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: preferredStyle)
            
            for action in actions {
                let actionButton = UIAlertAction(title: action.title, style: action.style, handler: ({ _ in
                    action.completion?()
                }))
                alertController.addAction(actionButton)
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            
            if let message: String = message {
                let messageText = NSMutableAttributedString(
                    string: message,
                    attributes: [
                        NSAttributedString.Key.paragraphStyle: paragraphStyle,
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)
                    ]
                )
                
                alertController.setValue(messageText, forKey: "attributedMessage")
            }
            
			alertController.popoverPresentationController?.sourceView = sourceView
            currenViewController.present(alertController, animated: true)
        }
    }
	
	/**
	Show an alert controller on top of the navigation stack.
	
	- parameter actions: list of actions.
	- parameter title: title of the alert.
	- parameter message: message of the alert.
	- parameter alignment: alignment of the message.
	- parameter preferredStyle: controller style.
	*/
	public func show(actions: [AlertAction],
					 title: String? = nil,
					 message: String? = nil,
					 textFieldConf: @escaping (UITextField) -> Void,
					 alignment: NSTextAlignment = .center,
					 preferredStyle: UIAlertController.Style = .alert,
					 sourceView: UIView? = nil) {
		
		DispatchQueue.main.async {
			guard let currenViewController = UIApplication.shared.topViewController else { return }
			
			let alertController = UIAlertController(title: title,
													message: message,
													preferredStyle: preferredStyle)
			
			for action in actions {
				let actionButton = UIAlertAction(title: action.title, style: action.style, handler: ({ _ in
					action.completion?()
				}))
				alertController.addAction(actionButton)
			}
			
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.alignment = alignment
			
			if let message: String = message {
				let messageText = NSMutableAttributedString(
					string: message,
					attributes: [
						NSAttributedString.Key.paragraphStyle: paragraphStyle,
						NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)
					]
				)
				
				alertController.setValue(messageText, forKey: "attributedMessage")
			}
			
			alertController.addTextField { textField in
				textFieldConf(textField)
			}
			
			alertController.popoverPresentationController?.sourceView = sourceView
			currenViewController.present(alertController, animated: true)
		}
	}
    
    /**
     Show a default error alert controller on top of the navigation stack.
     The title of the alert controller is the localized description of the error.
     
     - parameter error: error to be printed.
     */
    public func show(_ error: Error) {
        var infos: String? = error.localizedDescription
        
        if let error: LocalizedError = error as? LocalizedError {
            infos = error.errorDescription
        }
        
        self.show(actions: [AlertAction(title: "OK", style: .cancel)], title: infos)
    }
}
