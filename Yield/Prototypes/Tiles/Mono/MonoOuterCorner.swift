//
//  MonoOuterCorner.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Harvest
import Meadow

struct MonoOuterCorner: PrototypeTile {
    
    let config: SocketConfig
    
    var sockets: SurfaceSockets {
        
        var sockets = SurfaceSockets(material: .air, volume: .empty)
        
        guard case let .corner(ordinal) = config.type else { return sockets }
        
        sockets.set(material: config.material, ordinal: ordinal)
        
        let volume = config.volume == .crown ? SurfaceVolume.crown : .throne
        
        sockets.set(volume: volume, ordinal: ordinal)
        
        return sockets
    }
    
    var style: SurfaceStyle { config.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              case .corner = config.type else { return Mesh([]) }
        
        let volumes: [BiscuitVolume] = config.volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let vc0 = config.with(volume: volume)
            
            let surface = Surface(config: vc0).mesh
            
            let insets = Insets(value: config.material.inset(volume: volume))
                
            let biscuit = CornerBiscuit(config: vc0, insets: insets).mesh
            
            result = result.union(surface.intersect(biscuit))
        }
        
        return result
    }
}
