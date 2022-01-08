//
//  Inset.swift
//
//  Created by Zack Brown on 04/11/2021.
//

enum Inset {
    
    case inner
    case none
    case outer
    
    var opposite: Inset {
        
        switch self {
            
        case .inner: return .outer
        case .outer: return .inner
        case .none: return .none
        }
    }
}
