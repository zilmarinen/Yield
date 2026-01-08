//
//  Contents.swift
//
//  Created by Zack Brown on 06/01/2026.
//

internal struct Contents: Codable {
    
    internal static let `default` = Contents(info: .default,
                                             data: nil)
    
    internal struct Data: Codable {
        
        internal let filename: String
        internal let idiom: String
        
        internal init(filename: String) {
            
            self.filename = filename
            self.idiom = "universal"
        }
    }
    
    internal struct Info: Codable {
        
        internal static let `default` = Info(author: "Yield",
                                             version: 1)
        
        internal let author: String
        internal let version: Int
    }
    
    internal let info: Info
    internal let data: [Self.Data]?
}
