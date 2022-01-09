//
//  PrototypeInnerCorner.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Harvest
import Meadow

struct PrototypeInnerCorner: PrototypeTile {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: BiscuitVolume
    let ordinal: Ordinal
    
    var sockets: OrdinalPattern<SurfaceSocket> {
        
        var sockets = OrdinalPattern<SurfaceSocket>(value: SurfaceSocket())
        
        let (o0, o1) = ordinal.ordinals
        
        sockets.set(value: SurfaceSocket(inner: shape == .convex, outer: false), ordinal: ordinal)
        sockets.set(value: SurfaceSocket(inner: true, outer: true), ordinal: ordinal.opposite)
        sockets.set(value: SurfaceSocket(inner: true, outer: true), ordinal: o0)
        sockets.set(value: SurfaceSocket(inner: true, outer: true), ordinal: o1)
        
        return sockets
    }
    
    var mesh: Mesh {
        
        let volumes: [BiscuitVolume] = volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let surface = Surface(material: material, volume: volume).mesh
            
            let biscuit = CornerBiscuit(shape: shape.opposite, material: material, volume: volume, ordinal: ordinal, inset: material.inset(volume: volume).opposite).mesh
            
            result = result.union(surface.subtract(biscuit))
        }
        
        return result
    }
}
