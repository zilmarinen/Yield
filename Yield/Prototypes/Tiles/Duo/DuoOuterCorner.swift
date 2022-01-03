//
//  DuoOuterCorner.swift
//
//  Created by Zack Brown on 06/11/2021.
//

import Euclid
import Harvest
import Meadow

struct DuoOuterCorner: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    
    var sockets: SurfaceSockets {
        
        let p0 = MonoOuterCorner(config: primary)
        let p1 = MonoOuterCorner(config: secondary)
        
        return p0.sockets.merge(sockets: p1.sockets)
    }
    
    var style: SurfaceStyle { primary.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              case let .corner(o0) = primary.type,
              case let .corner(o1) = secondary.type,
              o0 != o1 else { return Mesh([]) }
        
        let (o2, _) = o0.ordinals
        
        var lhs0 = secondary.empty()
        var rhs0 = secondary
        var lhs1 = primary
        var rhs1 = primary.empty()
        
        if o0.opposite == o1 {
         
            lhs0 = secondary.empty()
            rhs0 = secondary.empty()
            
            lhs1 = primary.empty()
            rhs1 = primary.empty()
        }
        else if o1 == o2 {
            
            lhs0 = secondary
            rhs0 = secondary.empty()
            
            lhs1 = primary.empty()
            rhs1 = primary
        }
        
        let corner0 = AdjacentOuterCorner(primary: primary, lhs: lhs0, rhs: rhs0).mesh
        
        switch primary.style {
            
        case .convex:
            
            let corner1 = AdjacentOuterCorner(primary: secondary, lhs: lhs1, rhs: rhs1).mesh
            
            return corner0.union(corner1)
            
        default:
            
            let (c0, c1) = o0.cardinals
            
            let cardinal = o1 == o2 ? c0 : c1
            
            let vc0 = secondary.with(type: .edge(cardinal))
            let vc1 = primary.with(type: .corner(o0))
            
            let corner1 = ScallopedEdge(primary: vc0, lhs: vc0, rhs: vc1).mesh
            
            return corner0.union(corner1)
        }
    }
}
