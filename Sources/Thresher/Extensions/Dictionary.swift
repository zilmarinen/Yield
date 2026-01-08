//
//  Dictionary.swift
//
//  Created by Zack Brown on 08/01/2026.
//

import Foundation

extension Dictionary where Key == String,
                           Value == FileWrapper {
    
    internal static func folder() throws -> Self {
        
        let contents = Contents.default
        
        let encoder = JSONEncoder.default
        
        let jsonData = try encoder.encode(contents)
        
        let jsonWrapper = FileWrapper(regularFileWithContents: jsonData)
        
        return [.contents : jsonWrapper]
    }
}
