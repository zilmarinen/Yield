//
//  PrototypePlateau.swift
//
//  Created by Zack Brown on 25/10/2021.
//

import Euclid
import Harvest
import Meadow

struct PrototypePlateau: PrototypeTile {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: BiscuitVolume
    
    var sockets: OrdinalPattern<SurfaceSocket> { OrdinalPattern<SurfaceSocket>(value: SurfaceSocket(inner: true, outer: true)) }
    
    var mesh: Mesh {
        
        let volumes: [BiscuitVolume] = volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let mesh = Surface(material: material, volume: volume).mesh
            
            result = result.union(mesh)
        }
        
        return result
    }
}
