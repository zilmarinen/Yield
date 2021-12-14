//
//  TriGroove.swift
//
//  Created by Zack Brown on 06/11/2021.
//

import Euclid
import Harvest
import Meadow

struct TriGroove: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    let tertiary: SocketConfig
    
    var sockets: SurfaceSockets {
        
        let p0 = MonoGroove(config: primary)
        let p1 = MonoOuterCorner(config: secondary)
        let p2 = MonoOuterCorner(config: tertiary)
        
        return p0.sockets.merge(sockets: p1.sockets).merge(sockets: p2.sockets)
    }
    
    var style: SurfaceStyle { primary.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case let .corner(o0) = primary.type,
              case let .corner(o1) = secondary.type,
              case .corner = tertiary.type else { return Mesh([]) }
        
        let (o2, _) = o0.ordinals
        
        let lhs = o1 == o2 ? tertiary : secondary
        let rhs = o1 == o2 ? secondary : tertiary
        
        let vc1 = lhs.with(style: primary.style == .straight ? .concave : .convex)
        let vc2 = rhs.with(style: primary.style == .convex ? .convex : .concave)
        
        var result = AdjacentGroove(primary: primary, lhs: lhs, rhs: rhs).mesh
        let c0 = AdjacentOuterCorner(primary: vc1, lhs: primary, rhs: primary).mesh
        let c1 = AdjacentOuterCorner(primary: vc2, lhs: primary, rhs: primary).mesh
        
        if vc1.material != .air {
            
            result = result.union(c0)
        }
        
        if vc2.material != .air {
            
            result = result.union(c1)
        }
        
        return result
    }
}
