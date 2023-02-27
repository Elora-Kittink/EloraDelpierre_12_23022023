//
//  NetworkLogType.swift
//  UtilsKit
//
//  Created by RGMC on 15/06/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation

/**
 Network Log type.
 */
public enum NetworkLogType: LogType {
    case sending(String)
    case success(String)
    case error(String)
    
    public var prefix: String {
        switch self {
        case .sending(let type): return "➡️ \(type)"
        case .success(let type): return "✅ \(type)"
        case .error(let type): return "❌ \(type)"
        }
    }
}
