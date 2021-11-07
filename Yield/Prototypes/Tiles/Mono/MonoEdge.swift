//
//  MonoEdge.swift
//
//  Created by Zack Brown on 24/10/2021.
//

import Euclid
import Meadow

struct MonoEdge: PrototypeTile {
    
    let config: SocketConfig
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        
        guard case let .edge(cardinal) = config.type else { return sockets }
        
        let (o0, o1) = cardinal.ordinals
        
        switch config.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: config.material, ordinal: o0)
            sockets.lower.set(value: config.material, ordinal: o1)
            
        case .mantle:
            
            sockets.lower.set(value: config.material, ordinal: o0)
            sockets.lower.set(value: config.material, ordinal: o1)
            
            sockets.upper.set(value: config.material, ordinal: o0)
            sockets.upper.set(value: config.material, ordinal: o1)
            
        default: break
        }
        
        return sockets
    }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case .edge = config.type else { return Mesh([]) }
        
        let volumes: [Volume] = config.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let surface = Surface(config: .init(material: config.material, style: config.style, volume: volume, type: config.type)).mesh
            
            let insets = Insets(value: config.material.inset(volume: volume))
            
            let biscuit = EdgeBiscuit(config: .init(material: config.material, style: config.style, volume: volume, type: config.type), insets: insets).mesh
            
            let mesh = surface.intersect(biscuit)
            
            result = result.union(mesh)
        }
        
        return result
    }
}
