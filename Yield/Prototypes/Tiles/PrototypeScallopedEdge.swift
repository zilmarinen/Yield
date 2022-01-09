//
//  PrototypeScallopedEdge.swift
//
//  Created by Zack Brown on 09/01/2022.
//

import Euclid
import Harvest
import Meadow

struct PrototypeScallopedEdge: PrototypeTile {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: BiscuitVolume
    let ordinal: Ordinal
    let cardinal: Cardinal
    
    var sockets: OrdinalPattern<SurfaceSocket> {
        
        var sockets = OrdinalPattern<SurfaceSocket>(value: SurfaceSocket())
        
        let (o0, o1) = cardinal.ordinals
        let adjacentOrdinal = ordinal == o0 ? o1 : o0
        
        sockets.set(value: SurfaceSocket(inner: true, outer: true), ordinal: ordinal)
        sockets.set(value: SurfaceSocket(inner: true, outer: false), ordinal: adjacentOrdinal)
        
        return sockets
    }
    
    var mesh: Mesh {
        
        let volumes: [BiscuitVolume] = volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        let (o0, o1) = cardinal.ordinals
        let adjacentOrdinal = ordinal == o0 ? o1 : o0
        
        for volume in volumes {
            
            let surface = Surface(material: material, volume: volume).mesh
            
            let edge = EdgeBiscuit(shape: .straight, material: material, volume: volume, cardinal: cardinal).mesh
            let corner = CornerBiscuit(shape: .concave, material: material, volume: volume, ordinal: adjacentOrdinal, inset: material.inset(volume: volume).opposite).mesh
            
            result = result.union(surface.intersect(edge)).subtract(corner)
        }
        
        return result
    }
}
