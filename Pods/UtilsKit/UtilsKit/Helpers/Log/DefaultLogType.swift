//
//  DefaultLogType.swift
//  UtilsKit
//
//  Created by RGMC on 15/06/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation

/**
    Default Log type.
 */
public enum DefaultLogType: LogType {
    case data
	case decode
    case network
    case coredata
    case file
    case user
    case security
    case notification
    case camera
    case photo
    case biometry
    case tag
    case refresh
    case map
    case spotlight
    case navigation
    case debug
    case custom(String)
    
	public var prefix: String {
		switch self {
		case .data: return "🗄"
		case .decode: return "🔤"
		case .network: return "📶"
		case .coredata: return "💾"
		case .file: return "📃"
		case .security: return "🗝"
		case .user: return "👤"
		case .notification: return "🛎"
		case .camera: return "📹"
		case .photo: return "📷"
		case .biometry: return "🛡"
		case .tag: return "🏷"
		case .refresh: return "🔄"
		case .map: return "🗺"
		case .spotlight: return "🔍"
		case .navigation: return "⛳️"
		case .debug: return "🕹"
		case .custom(let prefix): return prefix
		}
	}
}
