//
//  PrototypeEdge.swift
//
//  Created by Zack Brown on 24/10/2021.
//

import Euclid
import Harvest
import Meadow

struct PrototypeEdge: PrototypeTile {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: SurfaceVolume
    let cardinal: Cardinal
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var variation: Int { Tile.edge.bitmask + shape.bitmask }
    
    var sockets: OrdinalPattern<SurfaceSocket> {
        
        var sockets = OrdinalPattern<SurfaceSocket>(value: SurfaceSocket())
        
        let (o0, o1) = cardinal.ordinals
        
        sockets.set(value: SurfaceSocket(inner: shape != .concave, outer: true), ordinal: o0)
        sockets.set(value: SurfaceSocket(inner: shape != .concave, outer: true), ordinal: o1)
        
        if shape == .convex {
            
            let (o2, o3) = cardinal.opposite.ordinals
            
            sockets.set(value: SurfaceSocket(inner: true, outer: false), ordinal: o2)
            sockets.set(value: SurfaceSocket(inner: true, outer: false), ordinal: o3)
        }
        
        return sockets
    }
    
    var mesh: Mesh {
        
        let volumes: [SurfaceVolume] = volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let surface = Surface(material: material, volume: volume).mesh
            
            let biscuit = EdgeBiscuit(shape: shape, material: material, volume: volume, cardinal: cardinal).mesh
            
            result = result.union(surface.intersect(biscuit))
        }
        
        return result
    }
}
