//
//  Util.swift
//  Jet2Travel
//
//  Created by Rohan Sarkar on 20/06/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation

class Util
{
    static let sharedInstance = Util()
    
    func convertToFloatValue(val: String) -> String
    {
        var result = val
        if Int(val)! > 100
        {
            result = String(format: "%.1f", ceil((result as NSString).floatValue)/1000) + "K"
        }
        return result
    }
}
