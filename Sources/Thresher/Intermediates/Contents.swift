//
//  Contents.swift
//  Yield
//
//  Created by Zack Brown on 06/01/2026.
//

internal struct Contents: Codable {
    
    internal static let `default` = Contents(info: .init(author: "Yield",
                                                         version: 1),
                                             data: nil)
    
    internal struct Data: Codable {
        
        internal let filename: String
        internal let idiom: String
        internal let universalTypeIdentifier : String
    }
    
    internal struct Info: Codable {
        
        internal let author: String
        internal let version: Int
    }
    
    internal let info: Info
    internal let data: [Self.Data]?
}
