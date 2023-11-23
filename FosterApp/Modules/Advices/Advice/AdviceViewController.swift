//  AdviceViewController.swift
//
//  Created by Elora on 09/05/2023.
//

import WebKit
import UtilsKit

class AdviceViewController: BaseViewController < AdviceViewModel, AdvicePresenter, AdviceInteractor > {
	
	// MARK: - Outlets
    var html: String!
    var webView: WKWebView!
    // MARK: - Variables
	
	// MARK: - View life cycle
    override func loadView() {
        webView = WKWebView()
//        webView.navigationDelegate = self
        view = webView
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        webView.loadHTMLString(html, baseURL: nil)
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
	}

	// MARK: - Actions
}

//extension AdviceViewController: WKNavigationDelegate {
//
//}

extension AdviceViewController: StoryboardProtocol {
    
    static var storyboardName: String {
        "Advice"
    }
    static var identifier: String? {
        "AdviceViewController"
    }
}
