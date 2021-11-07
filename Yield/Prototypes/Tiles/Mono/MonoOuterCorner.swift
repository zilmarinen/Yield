//
//  MonoOuterCorner.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Meadow

struct MonoOuterCorner: PrototypeTile {
    
    let config: SocketConfig
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        
        guard case let .corner(ordinal) = config.type else { return sockets }
        
        switch config.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: config.material, ordinal: ordinal)
            
        case .mantle:
            
            sockets.lower.set(value: config.material, ordinal: ordinal)
            
            sockets.upper.set(value: config.material, ordinal: ordinal)
            
        default: break
        }
        
        return sockets
    }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case .corner = config.type else { return Mesh([]) }
        
        let volumes: [Volume] = config.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let surface = Surface(config: .init(material: config.material, style: config.style, volume: volume, type: .plateau)).mesh
            
            let insets = Insets(value: config.material.inset(volume: volume))
                
            let biscuit = OuterCornerBiscuit(config: .init(material: config.material, style: config.style, volume: volume, type: config.type), insets: insets).mesh
            
            let mesh = surface.intersect(biscuit)
            
            result = result.union(mesh)
        }
        
        return result
    }
}
