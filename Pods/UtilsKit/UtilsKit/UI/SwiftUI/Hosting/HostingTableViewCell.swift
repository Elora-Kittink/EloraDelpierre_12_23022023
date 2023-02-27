//
//  HostingTableViewCell.swift
//  Total
//
//  Created by Michael Coqueret on 22/06/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public class HostingTableViewCell<Content: CellView>: UITableViewCell, ViewReusable {
	
	// MARK: - Static
	public static var identifier: String { Content.identifier }
	
	// MARK: - Variables
	private weak var controller: UIHostingController<Content>?
	
	// MARK: - Init
	deinit {
		self.controller?.willMove(toParent: nil)
		self.controller?.view.removeFromSuperview()
		self.controller?.removeFromParent()
		self.controller = nil
	}
	
	// MARK: - Functions
	public func host(_ view: Content, parent: UIViewController) {
		if let controller = self.controller {
			controller.rootView = view
			controller.view.layoutIfNeeded()
		} else {
			let hostingViewController = UIHostingController(rootView: view)
			self.controller = hostingViewController
			
			hostingViewController.view.backgroundColor = .clear
			
			self.layoutIfNeeded()
			
			parent.addChild(hostingViewController)
			self.contentView.addSubview(hostingViewController.view)
			
			hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				self.contentView.topAnchor.constraint(equalTo: hostingViewController.view.topAnchor),
				self.contentView.bottomAnchor.constraint(equalTo: hostingViewController.view.bottomAnchor),
				self.contentView.leadingAnchor.constraint(equalTo: hostingViewController.view.leadingAnchor),
				self.contentView.trailingAnchor.constraint(equalTo: hostingViewController.view.trailingAnchor)
			])
			
			hostingViewController.didMove(toParent: parent)
			hostingViewController.view.layoutIfNeeded()
		}
	}
}
