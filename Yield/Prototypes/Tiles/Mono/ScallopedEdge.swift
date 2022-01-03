//
//  ScallopedEdge.swift
//
//  Created by Zack Brown on 08/11/2021.
//

import Euclid
import Meadow

struct ScallopedEdge {
    
    let primary: SocketConfig
    let lhs: SocketConfig
    let rhs: SocketConfig
    
    var mesh: Mesh {
        
        guard case .edge = primary.type,
              case .corner = rhs.type else { return Mesh([]) }
        
        var result = Mesh([])
        
        let volumes: [BiscuitVolume] = primary.volume == .throne ? [.mantle] : [.crown, .throne]
        
        for volume in volumes {
            
            let vc0 = primary.with(style: .straight, volume: volume)
            let vc1 = SocketConfig(material: primary.material, style: .concave, volume: volume, type: rhs.type)
            
            let surface = Surface(config: vc0).mesh
            
            let i0 = Insets(left: primary.material.adjacentInset(volume: volume, material: lhs.material),
                            right: primary.material.adjacentInset(volume: volume, material: lhs.material))
            let i1 = Insets(left: primary.material.adjacentInset(volume: volume, material: rhs.material),
                            right: primary.material.adjacentInset(volume: volume, material: rhs.material))
            
            let edge = EdgeBiscuit(config: vc0, insets: i0).mesh
            let corner = CornerBiscuit(config: vc1, insets: i1.opposite).mesh
            
            result = result.union(surface.intersect(edge)).subtract(corner)
        }
        
        return result
    }
}
