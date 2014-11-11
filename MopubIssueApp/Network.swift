//
//  Network.swift
//  MopubIssueApp
//
//  Created by Paulo Arthur Venturi on 11/11/14.
//  Copyright (c) 2014 Paulo A Venturi. All rights reserved.
//

import UIKit

import CoreTelephony
import SystemConfiguration

class Network: NSObject {
    
    class func carrier() -> String{
        var carrier = CTTelephonyNetworkInfo().subscriberCellularProvider.carrierName;
        if carrier == nil {
            carrier = "No Carrier"
        }
        return carrier
    }
    
    class func isReachable() -> Bool {
        let reachabilityFlags:SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsReachable)
        if 0 != reachabilityFlags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsReachable) {
            return true
        }
        return false
    }
    
    class func isConnected() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false
    }
   
}
