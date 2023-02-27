//
//  LoadingButton.swift
//  UtilsKit
//
//  Created by RGMC on 24/10/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

/**
Customable with an activity indicator
*/
open class LoadingButton: UIButton {
    
    /**
     Position of the activity indicator
     */
    public enum LoaderPosition {
        case right, left, center
    }
    
    /**
     Type of the loader
     
     - `rotateImage`: rotate imageView
     - `loader`: activity indicator
     - `none`: no animation
     */
    public enum LoaderType {
        case rotateImage(duration: Double), loader(LoaderPosition), none
    }
    
    // MARK: - Inspectables
    /**
     Wether or not the activity indicator starts loading immediatly after initialization
     */
    @IBInspectable public var autoStart: Bool = false
    
    /**
     Distance between the activity indicator and the border
     Used to determine button content left and right inset
     */
    @IBInspectable public var loaderInset: CGFloat = 20
    
    /**
     Background color of the button when `isEnabled` is set to `false`
     If `nil`, the background color of the button is used instead
     */
    @IBInspectable public var disableBackgroundColor: UIColor? {
        didSet { setColors() }
    }
    
    /**
     Background color of the button when the activity indicator is animating
     If `nil`, the background color of the button is used instead
     */
    @IBInspectable public var loadingBackgroundColor: UIColor? {
        didSet { setColors() }
    }
    
    /**
     Color of the title when `isEnabled` is set to `false`
     If `nil`, the title color of the button is used instead and an 0.5 alpha is applied
     */
    @IBInspectable public var disableTitleColor: UIColor? {
        didSet { setColors() }
    }
    
    /**
     Color of the title when the activity indicator is animating
     If `nil`, the title color of the button is used instead and an 0.5 alpha is applied
     */
    @IBInspectable public var loadingTitleColor: UIColor? {
        didSet { setColors() }
    }
    
    /**
     Corner radius of the button
     */
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet { self.layer.cornerRadius = cornerRadius }
    }
    
    // MARK: - Variables
    private var activityIndicator: UIActivityIndicatorView?
    
    // Save state of the colors or title to be able to restore them later
    private var originalBackgroundColor: UIColor?
    private var originalImage: UIImage?
    private var originalImageTintColor: UIColor?
    private var originalTitleColor: UIColor?
    private var originalLeftInset: CGFloat?
    private var originalInsets: UIEdgeInsets?
    
    // MARK: - Custom conf
    
    /**
     Type of the loader
     */
    public var loaderType: LoaderType = .none
    
    /**
     Loading state of the button
     Setting this value starts or stops the loading
     */
    public var isLoading: Bool = false {
        didSet {
            if oldValue == self.isLoading { return }
            if self.isLoading {
                self.startLoader()
            } else {
                self.stopLoader()
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet { setColors() }
    }
    
    // MARK: - Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    private func setup() {
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        self.setColors()
        if self.autoStart { self.isLoading = true }
    }
    
    private func setBackgroundColor(_ color: UIColor?) {
        if let backgroundColor: UIColor = color {
            if self.originalBackgroundColor == nil { self.originalBackgroundColor = self.backgroundColor }
            self.backgroundColor = backgroundColor
        }
    }
    
    private func setTitleColor(_ color: UIColor?) {
        if self.originalTitleColor == nil { self.originalTitleColor = self.titleLabel?.textColor }
        if let loadingColor: UIColor = color {
            self.setTitleColor(loadingColor, for: .normal)
        }
    }
    
    private func setColors() {
        // Loading colors
        if isLoading {
            self.setBackgroundColor(self.loadingBackgroundColor ?? self.backgroundColor)
            
            var titleColor: UIColor?
            
            switch self.loaderType {
            case .loader(let position):
                titleColor = position == .center ? self.titleLabel?.textColor : self.loadingTitleColor ?? self.titleLabel?.textColor
                
            default:
                titleColor = self.loadingTitleColor ?? self.titleLabel?.textColor
            }
            
            self.setTitleColor(titleColor)
            
            return
        }
        
        // Disable colors
        if !isEnabled {
            self.setBackgroundColor(self.disableBackgroundColor ?? self.backgroundColor?.withAlphaComponent(0.3))
            self.setTitleColor(self.disableTitleColor ?? self.titleLabel?.textColor)
            return
        }
        
        // Restore colors
        if let cacheBackgroundColor = self.originalBackgroundColor {
            self.backgroundColor = cacheBackgroundColor
            self.originalBackgroundColor = nil
        }
        if let cacheTitleColor = self.originalTitleColor {
            self.setTitleColor(cacheTitleColor, for: .normal)
            self.originalTitleColor = nil
        }
    }
    
    // MARK: - Loader
    private func startLoader() {
        self.activityIndicator?.removeFromSuperview()
        self.isEnabled = false
        
        switch self.loaderType {
        case .loader(let position):
            self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            
            guard let activityIndicator = self.activityIndicator else { return }
            activityIndicator.style = .white
            activityIndicator.color = self.tintColor
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(activityIndicator)
            
            var constraints: [NSLayoutConstraint] = [activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
            
            self.originalInsets = self.contentEdgeInsets
            let inset: CGFloat = 30 + self.loaderInset
            self.contentEdgeInsets.left = inset
            self.contentEdgeInsets.right = inset
            
            switch position {
            case .right:
                constraints.append(activityIndicator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.loaderInset))
                
            case .left:
                self.hideImage()
                constraints.append(activityIndicator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.loaderInset))
                
            case .center:
                self.hideTitle()
                self.hideImage()
                
                constraints.append(activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor))
            }
            
            NSLayoutConstraint.activate(constraints)
            
        case .rotateImage(let duration):
            self.imageView?.rotate(duration: duration)
            
        case .none:
            break
        }
    }
    
    private func stopLoader() {
        self.activityIndicator?.removeFromSuperview()
        self.activityIndicator = nil
        self.isEnabled = true
        
        self.imageView?.stopRotating()
        
        self.contentEdgeInsets = self.originalInsets ?? self.contentEdgeInsets
        self.originalInsets = nil
        
        self.showTitleIfNeeded()
        self.showImageIfNeeded()
    }
    
    // MARK: UI Utils
    private func hideTitle() {
        self.originalTitleColor = self.titleLabel?.textColor
        self.setTitleColor(.clear, for: .normal)
    }
    
    private func showTitleIfNeeded() {
        if let originalTitleColor = self.originalTitleColor {
            self.setTitleColor(originalTitleColor, for: .normal)
            self.originalTitleColor = nil
        }
    }
    
    private func hideImage() {
        self.originalImageTintColor = self.imageView?.tintColor
        self.originalImage = self.image(for: .disabled)
        self.setImage(self.originalImage?.withRenderingMode(.alwaysTemplate), for: .disabled)
        self.imageView?.tintColor = .clear
    }
    
    private func showImageIfNeeded() {
        if let originalImageTintColor = self.originalImageTintColor {
            self.setImage(self.originalImage, for: .disabled)
            if self.imageView?.image?.renderingMode == .alwaysTemplate {
                self.imageView?.tintColor = originalImageTintColor
            }
            self.originalImageTintColor = nil
        }
    }
}
