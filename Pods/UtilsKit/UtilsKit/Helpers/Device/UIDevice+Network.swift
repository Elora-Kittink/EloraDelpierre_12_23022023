//  Reachability.swift
//  UtilsKit
//
//  Created by RGMC on 04/04/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit
import SystemConfiguration

extension UIDevice {
    
    /// Network type
    public enum NetworkType {
        
        /// All device network
        case all
        
        /// Only wifi network
        case wifi
    }
    
    /**
     Check network connectivity
     
     - parameter type: type of the network to be checked (see `NetworkType`). The default value is .all.
     
     - returns: a `boolean` value indicating the network connectivity for given type.
     */
    public class func isConnectedToNetwork(_ type: NetworkType = .all) -> Bool {
        
        var zeroAddress: sockaddr_in = sockaddr_in(sin_len: 0,
                                                   sin_family: 0,
                                                   sin_port: 0,
                                                   sin_addr: in_addr(s_addr: 0),
                                                   sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachabilityPointer: SCNetworkReachability? = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        
        guard let defaultRouteReachability: SCNetworkReachability = defaultRouteReachabilityPointer else { return false }
        
        var flags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        
        switch type {
        case .all:
            let isReachable: Bool = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection: Bool = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            
            return (isReachable && !needsConnection)
            
        case .wifi:
            let isReachable: Bool = flags == .reachable
            let needsConnection: Bool = flags == .connectionRequired
            
            return isReachable && !needsConnection
        }
    }
}
