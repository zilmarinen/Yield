//
//  AdjacentOuterCorner.swift
//
//  Created by Zack Brown on 07/11/2021.
//

import Euclid
import Meadow

struct AdjacentOuterCorner {
    
    let primary: SocketConfig
    let lhs: SocketConfig
    let rhs: SocketConfig
    
    var mesh: Mesh {
        
        var result = Mesh([])
        
        let volumes: [Volume] = primary.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        for volume in volumes {
            
            let vc0 = primary.with(volume: volume)
            
            let surface = Surface(config: vc0).mesh
            
            let insets = Insets(left: primary.material.adjacentInset(volume: volume, material: lhs.material),
                                right: primary.material.adjacentInset(volume: volume, material: rhs.material))
            
            let biscuit = CornerBiscuit(config: vc0, insets: insets).mesh
            
            result = result.union(surface.intersect(biscuit))
        }
        
        return result
    }
}
