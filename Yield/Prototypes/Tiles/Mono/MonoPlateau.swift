//
//  MonoPlateau.swift
//
//  Created by Zack Brown on 25/10/2021.
//

import Euclid
import Harvest
import Meadow

struct MonoPlateau: PrototypeTile {
    
    let config: SocketConfig
    
    var sockets: SurfaceSockets {
        
        var sockets = SurfaceSockets(material: .air, volume: .empty)
        
        sockets.set(material: config.material)
        
        let volume = config.volume == .crown ? SurfaceVolume.crown : .throne
        
        sockets.set(volume: volume)
        
        return sockets
    }
    
    var style: SurfaceStyle { config.style }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty else { return Mesh([]) }
        
        let volumes: [BiscuitVolume] = config.volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let mesh = Surface(config: config.with(volume: volume)).mesh
            
            result = result.union(mesh)
        }
        
        return result
    }
}
