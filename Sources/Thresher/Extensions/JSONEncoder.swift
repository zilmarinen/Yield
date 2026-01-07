//
//  JSONEncoder.swift
//
//  Created by Zack Brown on 06/01/2026.
//

import Foundation

extension JSONEncoder {
    
    internal static let `default`: JSONEncoder = {
        
        let encoder = JSONEncoder()
        
        encoder.outputFormatting = .prettyPrinted
        
        return encoder
    }()
}
