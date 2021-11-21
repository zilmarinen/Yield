//
//  DuoInnerCorner.swift
//
//  Created by Zack Brown on 06/11/2021.
//

import Euclid
import Harvest
import Meadow

struct DuoInnerCorner: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    
    var sockets: SurfaceSockets<SurfaceMaterial> {
        
        let p0 = MonoInnerCorner(config: primary)
        let p1 = MonoOuterCorner(config: secondary)
        
        return p0.sockets.union(sockets: p1.sockets)
    }
    
    var style: SurfaceStyle { primary.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case let .corner(o0) = primary.type,
              case let .corner(o1) = secondary.type,
              o0 == o1 else { return Mesh([]) }
        
        let vc1 = secondary.with(style: primary.style == .convex ? .convex : .concave)
        
        let c0 = AdjacentInnerCorner(primary: primary, secondary: secondary).mesh
        let c1 = AdjacentOuterCorner(primary: vc1, lhs: primary, rhs: primary).mesh
        
        return c0.union(c1)
    }
}
