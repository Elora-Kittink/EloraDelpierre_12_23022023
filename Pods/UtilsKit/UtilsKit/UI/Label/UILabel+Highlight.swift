//
//  UILabel+Highlight.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 27/04/2021.
//  Copyright © 2021 RGMC. All rights reserved.
//

import UIKit

extension UILabel {
	/**
	Set `text` and highlight the `highlightedText` if contains
	*/
	public func set(_ text: String?,
					highlightedText: String?,
					highlightedTextColor: UIColor,
					highlightedBackgroundColor: UIColor) {
		guard let _text = text,
			  let highlightedText = highlightedText
		else {
			self.text = text
			return
		}
		let textRange = _text.startIndex..<_text.endIndex
		let attributedText = NSMutableAttributedString(string: _text)
		_text
			.lowercased()
			.ranges(of: highlightedText.lowercased())
			.compactMap { range -> NSRange? in
				range.clamped(to: textRange) == range ? NSRange(range, in: _text) : nil
			}
			.forEach { range in
				attributedText.addAttributes([
					.backgroundColor: highlightedBackgroundColor,
					.foregroundColor: highlightedTextColor
				], range: range)
			}
		self.attributedText = attributedText
	}
}
