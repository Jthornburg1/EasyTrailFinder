//
//  Trail.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

struct Trail {
    
    var city: String?
    var state: String?
    var name: String?
    var lat: NSNumber?
    var long: NSNumber?
    var described1: String?
    var described2: String?
    var described3: String?
    var activities1: String?
    var activities2: String?
    var activities3: String?
    var thumbnail1: String?
    var thumbnail2: String?
    var thumbnail3: String?
    var url1: String?
    var url2: String?
    var url3: String?
    var actArray: NSArray?

    mutating func fromDictionary(dict: [String : AnyObject]) -> Trail {
        if let city = dict["city"] as? String {
            self.city = city
        }
        if let state = dict["state"] as? String {
            self.state = state
        }
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let lat = dict["lat"] as? NSNumber {
            self.lat = lat
        }
        
        if let long = dict["lon"] as? NSNumber {
            self.long = long
        }
        
        self.actArray = JsonDigger.getNestedArray(dict: dict, key: "activities")
        
        self.activities1 = JsonDigger.getNestedValues(arr: actArray!, index: 0, key: "activity_type_name")
        
        self.activities2 = JsonDigger.getNestedValues(arr: actArray!, index: 1, key: "activity_type_name")
        
        self.activities3 = JsonDigger.getNestedValues(arr: actArray!, index: 2, key: "activity_type_name")
        
        self.described1 = JsonDigger.getNestedValues(arr: actArray!, index: 0, key: "description")
        
        self.described2 = JsonDigger.getNestedValues(arr: actArray!, index: 1, key: "description")
        
        self.described3 = JsonDigger.getNestedValues(arr: actArray!, index: 2, key: "description")
        
        self.thumbnail1 = JsonDigger.getNestedValues(arr: actArray!, index: 0, key: "thumbnail")
        
        self.thumbnail2 = JsonDigger.getNestedValues(arr: actArray!, index: 1, key: "thumbnail")
        
        self.thumbnail3 = JsonDigger.getNestedValues(arr: actArray!, index: 2, key: "thumbnail")
        
        self.url1 = JsonDigger.getNestedValues(arr: actArray!, index: 0, key: "url")
        
        self.url2 = JsonDigger.getNestedValues(arr: actArray!, index: 1, key: "url")
        
        self.url3 = JsonDigger.getNestedValues(arr: actArray!, index: 2, key: "url")
        
        return self
    }
}
