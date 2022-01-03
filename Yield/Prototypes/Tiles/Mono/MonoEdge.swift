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
    
    var sockets: SurfaceSockets {
        
        var sockets = SurfaceSockets(material: .air, volume: .empty)
        
        guard case let .edge(cardinal) = config.type else { return sockets }
        
        let (o0, o1) = cardinal.ordinals
        
        sockets.set(material: config.material, ordinal: o0)
        sockets.set(material: config.material, ordinal: o1)
        
        let volume = config.volume == .crown ? SurfaceVolume.crown : .throne
        
        sockets.set(volume: volume, ordinal: o0)
        sockets.set(volume: volume, ordinal: o1)
        
        return sockets
    }
    
    var style: SurfaceStyle { config.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              case .edge = config.type else { return Mesh([]) }
        
        let volumes: [BiscuitVolume] = config.volume != .crown ? [.mantle] : [.crown, .throne]
        
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
