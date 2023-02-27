//
//  View+CornerRadius.swift
//  Total
//
//  Created by Michael Coqueret on 16/07/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
private struct CornerRadiusStyle: ViewModifier {
	
	struct CornerRadiusShape: Shape {
		
		var radius = CGFloat.infinity
		var corners = UIRectCorner.allCorners
		
		func path(in rect: CGRect) -> Path {
			let path = UIBezierPath(roundedRect: rect,
									byRoundingCorners: corners,
									cornerRadii: CGSize(width: radius, height: radius))
			return Path(path.cgPath)
		}
	}
	
	var radius: CGFloat
	var corners: UIRectCorner
	
	func body(content: Content) -> some View {
		content
			.clipShape(CornerRadiusShape(radius: radius, corners: corners))
	}
}

@available(iOS 13.0, *)
extension View {
	
	/// Modifier view with corner radius
	public func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
		ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
	}
}
