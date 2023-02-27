//
//  PagerView.swift
//  UtilsKit
//
//  Created by RGMC on 24/09/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

public protocol PagerViewDelegate: UIScrollViewDelegate {
	func pageDidChange(_ page: Int)
}

open class PagerView: UIView, UIScrollViewDelegate {
	
	// MARK: - Variables
	private var oldOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
    /// Allows to know the direction of the reading of the user
    private var isRightToLeft: Bool?
	
    private var innerViews: [UIView] = []
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		
		// Scroll view
		scrollView.delegate = self
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.backgroundColor = .clear
		scrollView.isPagingEnabled = true
		self.addSubview(scrollView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: self.rightAnchor)
		])
		
		return scrollView
	}()
	
	private var stackViewConstraint: NSLayoutConstraint?
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
		self.scrollView.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
			stackView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
			stackView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor)
		])
		
		switch self.scrollDirection {
		case .vertical:
			stackView.axis = .vertical
			stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
			self.stackViewConstraint = stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1)
			self.stackViewConstraint?.isActive = true
			
		case .horizontal:
			stackView.axis = .horizontal
			stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
			self.stackViewConstraint = stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1)
			self.stackViewConstraint?.isActive = true
		}
		
		return stackView
	}()
	
	/**
	The current page of the pager.
	*/
	private var visiblePage: Int = 0
	private var _currentPage: Int {
		guard self.scrollView.frame != CGRect.zero else { return 0 }
		switch scrollDirection {
		case .horizontal:
			return Int(round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width))
			
		case .vertical:
			return Int(round(self.scrollView.contentOffset.y / self.scrollView.frame.size.height))
		}
	}
    
    public var currentPage: Int {
        if self.isRightToLeft ?? false {
            return self.innerViews.count - self._currentPage - 1
        } else {
            return self._currentPage
        }
    }
	
	/**
	The scroll direction of the pager.
	*/
	public private(set) var scrollDirection: ScrollDirection = .horizontal
	
	/**
	Pager delegate
	*/
	public weak var delegate: PagerViewDelegate?
	
	// MARK: - Scroll view variables
	public var isPagingEnabled: Bool {
		get { scrollView.isPagingEnabled }
		set { scrollView.isPagingEnabled = newValue }
	}
	
	public var isScrollEnabled: Bool {
		get { scrollView.isScrollEnabled }
		set { scrollView.isScrollEnabled = newValue }
	}
	
	public var bounces: Bool {
		get { scrollView.bounces }
		set { scrollView.bounces = newValue }
	}
	
	public var showsVerticalScrollIndicator: Bool {
		get { scrollView.showsVerticalScrollIndicator }
		set { scrollView.showsVerticalScrollIndicator = newValue }
	}
	
	public var showsHorizontalScrollIndicator: Bool {
		get { scrollView.showsHorizontalScrollIndicator }
		set { scrollView.showsHorizontalScrollIndicator = newValue }
	}
	
	// MARK: - Init
	public init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupUI()
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
	}
	
	// MARK: - Scroll View overrides
	override open func layoutSubviews() {
		super.layoutSubviews()
		
		self._scrollToPage(self.visiblePage)
	}
	
	private func configureScrollView() {
		self.layoutSubviews()
		self.layoutIfNeeded()
		self.configureInnerViews()
	}
	
	private func configureInnerViews() {
		
		self.stackView.arrangedSubviews.forEach {
			self.stackView.removeArrangedSubview($0)
			$0.removeFromSuperview()
		}
		
		self.innerViews.forEach {
			self.stackView.addArrangedSubview($0)
		}
		
		self.stackViewConstraint = self.stackViewConstraint?.setMultiplier(multiplier: CGFloat(self.innerViews.count))
	}
	
	// MARK: - Setup
	private func setupUI() {
		self.oldOrientation = UIDevice.current.orientation
		NotificationCenter.default.addObserver(self,
											   selector: #selector(didRotate),
											   name: UIDevice.orientationDidChangeNotification,
											   object: nil)
	}
	
	// MARK: - Scroll view delegate
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		self.delegate?.scrollViewDidScroll?(scrollView)
	}
	
	public func scrollViewDidZoom(_ scrollView: UIScrollView) {
		self.delegate?.scrollViewDidZoom?(scrollView)
	}
	
	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		self.delegate?.scrollViewWillBeginDragging?(scrollView)
	}
	
	public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
										  withVelocity velocity: CGPoint,
										  targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		self.delegate?.scrollViewWillEndDragging?(scrollView,
												  withVelocity: velocity,
												  targetContentOffset: targetContentOffset)
	}
	
	public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		self.delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
	}
	
	public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		self.delegate?.scrollViewWillBeginDragging?(scrollView)
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		self.visiblePage = self._currentPage
		self.delegate?.pageDidChange(self.currentPage)
		
		self.delegate?.scrollViewDidEndDecelerating?(scrollView)
	}
	
	public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		self.delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
	}
	
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		self.delegate?.viewForZooming?(in: scrollView)
	}
	
	public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
		self.delegate?.scrollViewWillBeginZooming?(scrollView, with: view)
	}
	
	public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
		self.delegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
	}
	
	public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
		self.delegate?.scrollViewShouldScrollToTop?(scrollView) ?? false
	}
	
	public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
		self.delegate?.scrollViewDidScrollToTop?(scrollView)
	}
	
	@available(iOS 11.0, *)
	public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
		self.delegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
	}
	
	// MARK: - Actions
	@objc
	private func didRotate() {
		let orientation: UIDeviceOrientation = UIDevice.current.orientation
		
		defer {
			if !orientation.isFlat {
				self.oldOrientation = orientation
			}
		}
		
		if !orientation.isFlat && oldOrientation != orientation {
			self._scrollToPage(self._currentPage)
		}
	}
	
	// MARK: - Utils
	
	/**
	
	Configure the pager.
	
	- parameter views: the views contained in pager.
	- parameter scrollDirection: the direction of the scroll. Default is set to `horizontal`
	
	*/
	public func configure(withViews views: [UIView],
						  delegate: PagerViewDelegate? = nil,
						  scrollDirection: ScrollDirection = .horizontal,
                          isRightToLeft: Bool? = false) {
        self.isRightToLeft = isRightToLeft
        
        self.innerViews = views
		
		if self.isRightToLeft ?? false {
			self.innerViews.reverse()
			self.visiblePage = self.innerViews.count - 1
		}
		
        if delegate != nil {
            self.delegate = delegate
        }
        self.scrollDirection = scrollDirection
        self.configureScrollView()
	}
	
	private func _scrollToPage(_ page: Int, animationDuration: TimeInterval = 0) {
		self.visiblePage = page
		UIView.animate(withDuration: animationDuration) { [weak self] in
			guard let self = self else { return }
			switch self.scrollDirection {
			case .horizontal:
				let contentOffsetX = CGFloat(page) * self.scrollView.frame.size.width
				self.scrollView.contentOffset.x = contentOffsetX
				
			case .vertical:
				let contentOffsetY = CGFloat(page) * self.scrollView.frame.size.height
				self.scrollView.contentOffset.y = contentOffsetY
			}
		}
	}
	
	/**
	
	Scroll to the given page.
	The scroll is performed only if `isPagingEnabled` is set to `true`.
	
	- parameter page: the page to scroll to.
	- parameter animationDuration: the duration of the animation. `0` is default and not animated.
	
	*/
	public func scrollToPage(_ page: Int, animationDuration: TimeInterval = 0) {
		if scrollView.isPagingEnabled {
			_scrollToPage(page, animationDuration: animationDuration)
			scrollViewDidEndDecelerating(self.scrollView)
		}
	}
	
	
	/**
	Scroll to next page if exist depends on `orientation` parameter
	*/
	@discardableResult
	public func scrollToNextPage() -> Bool {
		self.scrollView.scrollToNextPage(self.scrollDirection)
	}
	
	/**
	Scroll to previous page if exist depends on `orientation` parameter
	*/
	@discardableResult
	public func scrollToPreviousPage() -> Bool {
		self.scrollView.scrollToPreviousPage(self.scrollDirection)
	}
}
