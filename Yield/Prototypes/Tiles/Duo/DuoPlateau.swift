//
//  DuoPlateau.swift
//
//  Created by Zack Brown on 02/11/2021.
//

import Euclid
import Meadow

struct DuoPlateau: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var sockets: Sockets {
        
        let p0 = MonoEdge(config: primary)
        let p1 = MonoEdge(config: .init(material: secondary.material, style: secondary.style, volume: secondary.volume, type: secondary.type))
        
        return p0.sockets.union(sockets: p1.sockets)
    }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case let .edge(c0) = primary.type,
              case let .edge(c1) = secondary.type,
              c0.opposite == c1 else { return Mesh([]) }
        
        let vc1 = secondary.with(style: primary.style.opposite)
        
        let e0 = AdjacentEdge(primary: primary, lhs: vc1, rhs: vc1).mesh
        let e1 = AdjacentEdge(primary: vc1, lhs: primary, rhs: primary).mesh
        
        return e0.union(e1)
    }
}
