//
//  MonoEdge.swift
//
//  Created by Zack Brown on 24/10/2021.
//

import Euclid
import Harvest
import Meadow

struct MonoEdge: PrototypeTile {
    
    let config: SocketConfig
    
    var sockets: SurfaceSockets<SurfaceMaterial> {
        
        var sockets = SurfaceSockets<SurfaceMaterial>(value: .air)
        
        guard case let .edge(cardinal) = config.type else { return sockets }
        
        let (o0, o1) = cardinal.ordinals
        
        switch config.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: config.material, ordinal: o0)
            sockets.lower.set(value: config.material, ordinal: o1)
            
        case .mantle:
            
            sockets.set(value: config.material, ordinal: o0)
            sockets.set(value: config.material, ordinal: o1)
            
        default: break
        }
        
        return sockets
    }
    
    var style: SurfaceStyle { config.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case .edge = config.type else { return Mesh([]) }
        
        let volumes: [Volume] = config.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let vc0 = config.with(volume: volume)
            
            let surface = Surface(config: vc0).mesh
            
            let insets = Insets(value: config.material.inset(volume: volume))
            
            let biscuit = EdgeBiscuit(config: vc0, insets: insets).mesh
            
            result = result.union(surface.intersect(biscuit))
        }
        
        return result
    }
}
