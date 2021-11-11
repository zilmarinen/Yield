//
//  TriGroove.swift
//
//  Created by Zack Brown on 06/11/2021.
//

import Euclid
import Meadow

struct TriGroove: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    let tertiary: SocketConfig
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var sockets: Sockets {
        
        let p0 = MonoGroove(config: primary)
        let p1 = MonoOuterCorner(config: secondary)
        let p2 = MonoOuterCorner(config: tertiary)
        
        return p0.sockets.union(sockets: p1.sockets).union(sockets: p2.sockets)
    }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case .corner = primary.type,
              case .corner = secondary.type,
              case .corner = tertiary.type else { return Mesh([]) }
        
        let vc1 = secondary.with(style: primary.style == .straight ? .concave : .convex)
        let vc2 = tertiary.with(style: primary.style == .convex ? .convex : .concave)
        
        var result = AdjacentGroove(primary: primary, lhs: secondary, rhs: tertiary).mesh
        let c0 = AdjacentOuterCorner(primary: vc1, lhs: primary, rhs: primary).mesh
        let c1 = AdjacentOuterCorner(primary: vc2, lhs: primary, rhs: primary).mesh
        
        if secondary.material != .air {
            
            result = result.union(c1)
        }
        
        if tertiary.material != .air {
            
            result = result.union(c0)
        }
        
        return result
    }
}
