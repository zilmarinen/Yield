//
//  SurfaceStyle.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Harvest

extension SurfaceStyle {
    
    var opposite: SurfaceStyle {
        
        switch self {
            
        case .concave: return .convex
        case .convex: return .concave
        case .straight: return .straight
        }
    }
}
