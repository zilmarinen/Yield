//
//  MonoGroove.swift
//
//  Created by Zack Brown on 29/10/2021.
//

import Euclid
import Harvest
import Meadow

struct MonoGroove: PrototypeTile {
    
    let config: SocketConfig
    
    var sockets: SurfaceSockets {
        
        var sockets = SurfaceSockets(value: .air)
        
        guard case let .corner(ordinal) = config.type else { return sockets }
        
        switch config.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: config.material, ordinal: ordinal)
            sockets.lower.set(value: config.material, ordinal: ordinal.opposite)
            
        case .mantle:
            
            sockets.set(value: config.material, ordinal: ordinal)
            sockets.set(value: config.material, ordinal: ordinal.opposite)
            
        default: break
        }
        
        return sockets
    }
    
    var style: SurfaceStyle { config.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case .corner = config.type else { return Mesh([]) }
        
        let volumes: [Volume] = config.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let vc0 = config.with(volume: volume)
            
            let surface = Surface(config: vc0).mesh
            
            let insets = Insets(value: config.material.inset(volume: volume))
            
            let biscuit = GrooveBiscuit(config: vc0, insets: insets).mesh
            
            result = result.union(surface.intersect(biscuit))
        }
        
        return result
    }
}
