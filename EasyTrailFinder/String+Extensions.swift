//
//  String+Extensions.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

extension String {
    
    func removeSpaceAtEnd() -> String {
        if self.hasSuffix(" ") {
            return self.substring(to: self.index(before: self.endIndex))
        }
        return self
    }
}
