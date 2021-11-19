//
//  SurfaceSockets.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import Harvest
import Meadow

extension SurfaceSockets where T == SurfaceMaterial {
    
    var count: Int { upper.count + lower.count }
    
    var isEmpty: Bool { upper.isEmpty && lower.isEmpty }
    var isFull: Bool { upper.isFull && lower.isFull }
    
    func union(sockets: Self) -> Self { SurfaceSockets<T>(upper: upper.union(pattern: sockets.upper), lower: lower.union(pattern: sockets.lower)) }
    
    public mutating func set(value: T) {
        
        upper.set(value: value)
        lower.set(value: value)
    }
}
