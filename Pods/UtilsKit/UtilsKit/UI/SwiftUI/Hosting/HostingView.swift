//
//  HostingView.swift
//  Total
//
//  Created by Thibaud Lambert on 24/06/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public class HostingView<Content: View>: UIView {
	
	private weak var controller: UIHostingController<Content>?
	
	public func host(_ view: Content,
			  parent: UIViewController,
			  withInset inset: UIEdgeInsets = .zero) {
		
		if let controller = self.controller {
			controller.rootView = view
			controller.view.layoutIfNeeded()
		} else {
			let hostingViewController = UIHostingController(rootView: view)
			self.controller = hostingViewController
			
			hostingViewController.view.backgroundColor = .clear
			
			self.layoutIfNeeded()
			
			parent.addChild(hostingViewController)
			self.addSubview(hostingViewController.view)
			
			hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				self.topAnchor.constraint(equalTo: hostingViewController.view.topAnchor, constant: -inset.top),
				self.bottomAnchor.constraint(equalTo: hostingViewController.view.bottomAnchor, constant: inset.bottom),
				self.leadingAnchor.constraint(equalTo: hostingViewController.view.leadingAnchor, constant: -inset.left),
				self.trailingAnchor.constraint(equalTo: hostingViewController.view.trailingAnchor, constant: inset.right)
			])
			
			hostingViewController.didMove(toParent: parent)
			hostingViewController.view.layoutIfNeeded()
		}
	}
}
