//
//  PrototypeOuterCorner.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Harvest
import Meadow

struct PrototypeOuterCorner: PrototypeTile {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: SurfaceVolume
    let ordinal: Ordinal
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var variation: Int { Tile.outerCorner.bitmask + shape.bitmask }
    
    var sockets: OrdinalPattern<SurfaceSocket> {
        
        var sockets = OrdinalPattern<SurfaceSocket>(value: SurfaceSocket())
        
        sockets.set(value: SurfaceSocket(inner: shape == .convex, outer: true), ordinal: ordinal)
        
        return sockets
    }
    
    var mesh: Mesh {
        
        let volumes: [SurfaceVolume] = volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let surface = Surface(material: material, volume: volume).mesh
                
            let biscuit = CornerBiscuit(shape: shape, material: material, volume: volume, ordinal: ordinal, inset: material.inset(volume: volume)).mesh
            
            result = result.union(surface.intersect(biscuit))
        }
        
        return result
    }
}
