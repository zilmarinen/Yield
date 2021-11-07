//
//  BiscuitStyle.swift
//
//  Created by Zack Brown on 28/10/2021.
//

enum BiscuitStyle: String, CaseIterable, Identifiable {
    
    case concave
    case convex
    case straight
    
    var id: String { rawValue }
    
    var opposite: BiscuitStyle {
        
        switch self {
            
        case .concave: return .convex
        case .convex: return .concave
        case .straight: return .straight
        }
    }
}
