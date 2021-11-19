//
//  OrdinalPattern.swift
//
//  Created by Zack Brown on 19/11/2021.
//

import Harvest
import Meadow

extension OrdinalPattern where T == SurfaceMaterial {
    
    var isEmpty: Bool { count == 0 }
    var isFull: Bool { count == 4 }
    
    public var count: Int {
        
        return  (northWest == .air ? 0 : 1) +
                (northEast == .air ? 0 : 1) +
                (southEast == .air ? 0 : 1) +
                (southWest == .air ? 0 : 1)
    }
    
    func union(pattern: OrdinalPattern) -> Self {
        
        var result = Self(value: .air)
        
        for ordinal in Ordinal.allCases {
         
            let lhs = value(for: ordinal)
            let rhs = pattern.value(for: ordinal)
            
            result.set(value: lhs.rawValue > rhs.rawValue ? lhs : rhs, ordinal: ordinal)
        }
        
        return result
    }
}
