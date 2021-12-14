//
//  OrdinalPattern.swift
//
//  Created by Zack Brown on 19/11/2021.
//

import Harvest
import Meadow

extension OrdinalPattern where T == SurfaceMaterial {
    
    var isEmpty: Bool { isHomogenous(with: .air) }
    var isFull: Bool { !contains(value: .air) }
    
    public var count: Int {
        
        return  (northWest == .air ? 0 : 1) +
                (northEast == .air ? 0 : 1) +
                (southEast == .air ? 0 : 1) +
                (southWest == .air ? 0 : 1)
    }
}
