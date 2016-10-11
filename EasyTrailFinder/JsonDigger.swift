//
//  JsonDigger.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

struct JsonDigger {
    
    static func getNestedValues(arr: NSArray?, index: Int, key: String) -> String? {
        print("getting value")
        if (arr?.count)! > index {
            if let actIndex = arr![index] as? [String : AnyObject] {
                if let value = actIndex[key] {
                    print(value)
                    return value as? String
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func getNestedArray (dict: [String : AnyObject], key: String) -> NSArray? {
        if let arr = dict[key] as? NSArray {
            return arr
        } else {
            return nil
        }
    }
    
    static func arrayToString(arr: [String]) -> String {
        let str = arr.joined(separator: ",")
        return str
    }
    
    static func stringToArray(str: String) -> [String] {
        let arr = str.components(separatedBy: ",")
        return arr
    }
}
