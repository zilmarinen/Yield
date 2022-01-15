//
//  SurfaceShape.swift
//
//  Created by Zack Brown on 11/01/2022.
//

import Harvest

extension SurfaceShape {
    
    var bitmask: Int {
        
        switch self {
            
        case .concave: return 0
        case .convex: return 1
        case .straight: return 2
        }
    }
}
