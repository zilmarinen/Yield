//
//  AdjacentInnerCorner.swift
//
//  Created by Zack Brown on 09/11/2021.
//

import Euclid
import Meadow

struct AdjacentInnerCorner {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    
    var mesh: Mesh {
        
        var result = Mesh([])
        
        let volumes: [Volume] = primary.volume == .mantle ? [.mantle] : [.crown, .throne]
        
        for volume in volumes {
            
            let vc0 = primary.with(volume: volume)
            let vc1 = primary.with(volume: volume)
            
            let surface = Surface(config: vc0).mesh
            
            let insets = Insets(left: primary.material.adjacentInset(volume: volume, material: secondary.material),
                                right: primary.material.adjacentInset(volume: volume, material: secondary.material))
            
            let biscuit = CornerBiscuit(config: vc1, insets: insets.opposite).mesh
            
            result = result.union(surface.subtract(biscuit))
        }
        
        return result
    }
}
