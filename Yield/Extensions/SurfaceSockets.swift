//
//  SurfaceSockets.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import Harvest
import Meadow

extension SurfaceSockets {
    
    var count: Int { upper.count + lower.count }
    
    var isEmpty: Bool { upper.isEmpty && lower.isEmpty }
    var isFull: Bool { upper.isFull && lower.isFull }
}
