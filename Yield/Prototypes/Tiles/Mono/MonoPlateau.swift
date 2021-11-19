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
    
    var sockets: SurfaceSockets<SurfaceMaterial> {
        
        var sockets = SurfaceSockets<SurfaceMaterial>(value: .air)
        
        switch config.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: config.material)
            
        case .mantle:
            
            sockets.set(value: config.material)
            
        default: break
        }
        
        return sockets
    }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull else { return Mesh([]) }
        
        let volumes: [Volume] = config.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let mesh = Surface(config: config.with(volume: volume)).mesh
            
            result = result.union(mesh)
        }
        
        return result
    }
}
