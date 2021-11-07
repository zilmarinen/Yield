//
//  AdjacentCorner.swift
//
//  Created by Zack Brown on 07/11/2021.
//

import Euclid
import Meadow

struct AdjacentCorner {
    
    let primary: SocketConfig
    let lhs: SocketConfig
    let rhs: SocketConfig
    
    var mesh: Mesh {
        
        var result = Mesh([])
        
        let volumes: [Volume] = primary.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        for volume in volumes {
            
            let config = SocketConfig(material: primary.material, style: primary.style, volume: volume, type: primary.type)
         
            let surface = Surface(config: config).mesh
            
            let insets = Insets(left: primary.material.adjacentInset(volume: volume, material: lhs.material),
                                right: primary.material.adjacentInset(volume: volume, material: rhs.material))
            
            let corner = OuterCornerBiscuit(config: config, insets: insets).mesh
            
            result = result.union(surface.intersect(corner))
        }
        
        return result
    }
}
