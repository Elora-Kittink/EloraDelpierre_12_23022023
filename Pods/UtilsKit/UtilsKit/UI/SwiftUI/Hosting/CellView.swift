//
//  CellView.swift
//  Total
//
//  Created by Steven on 28/06/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public protocol CellView: View {
	
    static var identifier: String { get }
}

@available(iOS 13, *)
extension CellView {
	
	/// Cell identifier
	public static var identifier: String {
		"\(Self.self)"
	}
}
