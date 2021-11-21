//
//  TetraPlateau.swift
//
//  Created by Zack Brown on 09/11/2021.
//

import Euclid
import Harvest
import Meadow

struct TetraPlateau: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    let tertiary: SocketConfig
    let quaternary: SocketConfig
    
    var sockets: SurfaceSockets<SurfaceMaterial> {
        
        let p0 = MonoOuterCorner(config: primary)
        let p1 = MonoOuterCorner(config: secondary)
        let p2 = MonoOuterCorner(config: tertiary)
        let p3 = MonoOuterCorner(config: quaternary)
        
        return p0.sockets.union(sockets: p1.sockets).union(sockets: p2.sockets).union(sockets: p3.sockets)
    }
    
    var style: SurfaceStyle { primary.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case let .corner(ordinal) = primary.type,
              case .corner = secondary.type,
              case .corner = tertiary.type,
              case .corner = tertiary.type else { return Mesh([]) }
        
        switch primary.style {
            
        case .concave:
            
            let (c0, _) = ordinal.cardinals
            
            let vc1 = secondary.with(style: .straight, type: .edge(c0.opposite))
            let vc2 = tertiary.with(style: .concave)
            let vc3 = quaternary.with(style: .straight, type: .edge(c0))
            
            var result = AdjacentOuterCorner(primary: primary, lhs: quaternary, rhs: quaternary).mesh
            let e1 = ScallopedEdge(primary: vc1, lhs: vc3, rhs: tertiary).mesh
            let c2 = AdjacentOuterCorner(primary: vc2, lhs: secondary, rhs: secondary).mesh
            let e3 = ScallopedEdge(primary: vc3, lhs: secondary, rhs: primary).mesh
            
            if secondary.material != .air {
                
                result = result.union(e1)
            }
            
            if tertiary.material != .air {
                
                result = result.union(c2)
            }
            
            if quaternary.material != .air {
                
                result = result.union(e3)
            }
            
            return result
            
        default:
            
            let vc0 = primary.with(style: .convex)
            let vc1 = secondary.with(style: .convex)
            let vc2 = tertiary.with(style: .convex)
            let vc3 = quaternary.with(style: .convex)
            
            var result = AdjacentOuterCorner(primary: vc0, lhs: quaternary, rhs: secondary).mesh
            let c1 = AdjacentOuterCorner(primary: vc1, lhs: primary, rhs: tertiary).mesh
            let c2 = AdjacentOuterCorner(primary: vc2, lhs: secondary, rhs: quaternary).mesh
            let c3 = AdjacentOuterCorner(primary: vc3, lhs: tertiary, rhs: primary).mesh
            
            if secondary.material != .air {
                
                result = result.union(c1)
            }
            
            if tertiary.material != .air {
                
                result = result.union(c2)
            }
            
            if quaternary.material != .air {
                
                result = result.union(c3)
            }
            
            return result
        }
    }
}
