//
//  OrdinalPattern.swift
//
//  Created by Zack Brown on 19/11/2021.
//

import Harvest
import Meadow

extension OrdinalPattern where T == SurfaceSocket {
    
    public var count: Int {
        
        return  (value(for: .northWest).outer ? 0 : 1) +
                (value(for: .northEast).outer ? 0 : 1) +
                (value(for: .southEast).outer ? 0 : 1) +
                (value(for: .southWest).outer ? 0 : 1)
    }
}
