//
//  UINavigationBarAppearance+Gradient.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
extension UINavigationBarAppearance {
	
	/**
	 Add gradient color to navigation bar
	 */
	public func setBackgroundImage(colors: [UIColor], in scene: UIWindowScene?) {
		
		func image(withGradient colors: [UIColor]) -> UIImage? {
			guard let size = scene?.statusBarManager?.statusBarFrame.size
			else { return nil }
			
			let cgcolors = colors.map { $0.cgColor }
			UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
			
			guard let context = UIGraphicsGetCurrentContext() else { return nil }
			defer { UIGraphicsEndImageContext() }
			
			var locations: [CGFloat] = [0.0, 1.0]
			guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
											colors: cgcolors as NSArray as CFArray,
											locations: &locations)
			else { return nil }
			
			context.drawLinearGradient(gradient,
									   start: .init(x: 0.0, y: 0.0),
									   end: .init(x: 0.0, y: size.height),
									   options: [])
			
			return UIGraphicsGetImageFromCurrentImageContext()
		}
		
		self.backgroundImage = image(withGradient: colors)
	}
}
