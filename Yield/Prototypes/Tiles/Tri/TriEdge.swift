//
//  TriEdge.swift
//
//  Created by Zack Brown on 09/11/2021.
//

import Euclid
import Harvest
import Meadow

struct TriEdge: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    let tertiary: SocketConfig
    
    var sockets: SurfaceSockets {
        
        let p0 = MonoEdge(config: primary)
        let p1 = MonoOuterCorner(config: secondary)
        let p2 = MonoOuterCorner(config: tertiary)
        
        return p0.sockets.merge(sockets: p1.sockets).merge(sockets: p2.sockets)
    }
    
    var style: SurfaceStyle { primary.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case let .edge(cardinal) = primary.type,
              case .corner = secondary.type,
              case .corner = tertiary.type else { return Mesh([]) }
        
        guard secondary.material != tertiary.material else {
            
            let adjacent = secondary.with(style: primary.style.opposite, type: .edge(cardinal.opposite))
            
            let e0 = AdjacentEdge(primary: primary, lhs: adjacent, rhs: adjacent).mesh
            let e1 = AdjacentEdge(primary: adjacent, lhs: primary, rhs: primary).mesh
            
            return e0.union(e1)
        }
        
        switch primary.style {
            
        case .concave:
            
            let (c0, c1) = cardinal.cardinals
            let (o0, o1) = cardinal.ordinals
            
            let vc1 = tertiary.with(type: .edge(c0))
            let vc2 = secondary.with(type: .edge(c1))
            
            let vc3 = primary.with(type: .corner(o0))
            let vc4 = primary.with(type: .corner(o1))
            
            var result = AdjacentEdge(primary: primary, lhs: tertiary, rhs: secondary).mesh
            let s0 = ScallopedEdge(primary: vc1, lhs: vc2, rhs: vc3).mesh
            let s1 = ScallopedEdge(primary: vc2, lhs: vc1, rhs: vc4).mesh
            
            if secondary.material != .air {
                
                result = result.union(s1)
            }
            
            if tertiary.material != .air {
                
                result = result.union(s0)
            }
            
            return result
            
        default:
            
            let vc1 = secondary.with(style: primary.style == .convex ? .concave : .convex)
            let vc2 = tertiary.with(style: primary.style == .convex ? .concave : .convex)
            
            var result = AdjacentEdge(primary: primary, lhs: secondary, rhs: tertiary).mesh
            let c1 = AdjacentOuterCorner(primary: vc1, lhs: primary, rhs: tertiary).mesh
            let c2 = AdjacentOuterCorner(primary: vc2, lhs: secondary, rhs: primary).mesh
            
            if secondary.material != .air {
                
                result = result.union(c1)
            }
            
            if tertiary.material != .air {
                
                result = result.union(c2)
            }
            
            return result
        }
    }
}
