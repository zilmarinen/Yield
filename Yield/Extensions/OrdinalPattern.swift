//
//  OrdinalPattern.swift
//
//  Created by Zack Brown on 19/11/2021.
//

import Harvest
import Meadow

extension OrdinalPattern where T == SurfaceMaterial {
    
    public var isEmpty: Bool { isHomogenous(with: .air) }
    public var isFull: Bool { !contains(value: .air) }
    
    public var count: Int {
        
        return  (value(for: .northWest) == .air ? 0 : 1) +
                (value(for: .northEast) == .air ? 0 : 1) +
                (value(for: .southEast) == .air ? 0 : 1) +
                (value(for: .southWest) == .air ? 0 : 1)
    }
}
