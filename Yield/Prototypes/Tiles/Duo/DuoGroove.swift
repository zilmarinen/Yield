//
//  DuoGroove.swift
//
//  Created by Zack Brown on 06/11/2021.
//

import Euclid
import Meadow

struct DuoGroove: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        
        guard case let .corner(ordinal) = primary.type else { return sockets }
        
        switch primary.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: primary.material, ordinal: ordinal)
            sockets.lower.set(value: primary.material, ordinal: ordinal.opposite)
            
        case .mantle:
            
            sockets.lower.set(value: primary.material, ordinal: ordinal)
            sockets.lower.set(value: primary.material, ordinal: ordinal.opposite)
            
            sockets.upper.set(value: primary.material, ordinal: ordinal)
            sockets.upper.set(value: primary.material, ordinal: ordinal.opposite)
            
        default: break
        }
        
        return sockets
    }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case let .corner(o0) = primary.type,
              case let .corner(o1) = secondary.type else { return Mesh([]) }
        
        let (o2, o3) = o0.ordinals
        
        guard o1 == o2 || o1 == o3 else{ return Mesh([]) }
        
        let groove = MonoGroove(config: primary).mesh
        
        return groove
    }
}
