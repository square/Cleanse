//
//  DebugInfo.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/28/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// This is used to pass around source info similar to what one would get from stack traces

public struct SourceLocation : CustomStringConvertible {
    public let file: StaticString
    public let line: Int
    public let function: StaticString
    
    public init(
        file: StaticString,
        line: Int,
        function: StaticString
        ) {
        
        self.file = file
        self.line = line
        self.function = function
    }
    
    public var description: String {
        return "\(file):\(line)"
    }
}

