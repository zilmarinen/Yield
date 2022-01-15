//
//  PrototypeGroove.swift
//
//  Created by Zack Brown on 29/10/2021.
//

import Euclid
import Harvest
import Meadow

struct PrototypeGroove: PrototypeTile {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: SurfaceVolume
    let ordinal: Ordinal
    
    var rotations: [Ordinal] {
        
        switch shape {
        
        case .concave: return Ordinal.allCases
        default: return [.northWest, .northEast]
        }
    }
    
    var variation: Int { Tile.groove.bitmask + shape.bitmask }
    
    var sockets: OrdinalPattern<SurfaceSocket> {
        
        var sockets = OrdinalPattern<SurfaceSocket>(value: SurfaceSocket())
        
        let (o0, o1) = ordinal.ordinals
        
        sockets.set(value: SurfaceSocket(inner: true, outer: true), ordinal: ordinal)
        sockets.set(value: SurfaceSocket(inner: true, outer: true), ordinal: ordinal.opposite)
        
        sockets.set(value: SurfaceSocket(inner: shape != .convex, outer: false), ordinal: o0)
        sockets.set(value: SurfaceSocket(inner: shape == .straight, outer: false), ordinal: o1)
        
        return sockets
    }
    
    var mesh: Mesh {
        
        let volumes: [SurfaceVolume] = volume != .crown ? [.mantle] : [.crown, .throne]
        
        var result = Mesh([])
        
        for volume in volumes {
            
            let surface = Surface(material: material, volume: volume).mesh
            
            let biscuit = GrooveBiscuit(shape: shape, material: material, volume: volume, ordinal: ordinal).mesh
            
            result = result.union(surface.intersect(biscuit))
        }
        
        return result
    }
}
