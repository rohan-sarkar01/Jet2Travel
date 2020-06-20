//
//  CheckReachability.swift
//  Jet2Travel
//
//  Created by Rohan Sarkar on 19/06/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation

class CheckReachability
{
    static let sharedInstance = CheckReachability()
    
    func isConnectedToNetwork() -> Bool
    {
        let status = Reach().connectionStatus()
        var isConnected: Bool = false
        switch status
        {
            case .unknown, .offline:
                print("Not connected")
                isConnected = false
                break
            case .online(.wwan):
                print("Connected via WWAN")
                isConnected = true
                break
            case .online(.wiFi):
                print("Connected via WiFi")
                isConnected = true
                break
        }
        return isConnected
    }
    
}
