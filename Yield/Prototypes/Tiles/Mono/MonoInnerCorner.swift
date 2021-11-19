//
//  MonoInnerCorner.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Harvest
import Meadow

struct MonoInnerCorner: PrototypeTile {
    
    let config: SocketConfig
    
    var sockets: SurfaceSockets<SurfaceMaterial> {
        
        var sockets = SurfaceSockets<SurfaceMaterial>(value: .air)
        
        guard case let .corner(ordinal) = config.type else { return sockets }
        
        let (o0, o1) = ordinal.ordinals
        
        switch config.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: config.material, ordinal: ordinal.opposite)
            sockets.lower.set(value: config.material, ordinal: o0)
            sockets.lower.set(value: config.material, ordinal: o1)
            
        case .mantle:
            
            sockets.set(value: config.material, ordinal: ordinal.opposite)
            sockets.set(value: config.material, ordinal: o0)
            sockets.set(value: config.material, ordinal: o1)
            
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
            
            let vc0 = config.with(volume: volume)
            
            let surface = Surface(config: vc0).mesh
            
            let insets = Insets(value: config.material.inset(volume: volume))
            
            let biscuit = CornerBiscuit(config: vc0, insets: insets.opposite).mesh
            
            result = result.union(surface.subtract(biscuit))
        }
        
        return result
    }
}
