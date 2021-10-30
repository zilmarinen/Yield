//
//  PrototypeEdge.swift
//
//  Created by Zack Brown on 24/10/2021.
//

import Euclid
import Meadow

struct PrototypeEdge: PrototypeTile {
    
    let cardinal: Cardinal
    let material: SurfaceMaterial
    let style: BiscuitStyle
    let volume: Volume
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        let (o0, o1) = cardinal.ordinals
        
        switch volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: material, ordinal: o0)
            sockets.lower.set(value: material, ordinal: o1)
            
        case .mantle:
            
            sockets.lower.set(value: material, ordinal: o0)
            sockets.lower.set(value: material, ordinal: o1)
            
            sockets.upper.set(value: material, ordinal: o0)
            sockets.upper.set(value: material, ordinal: o1)
            
        default: break
        }
        
        return sockets
    }
    
    var polygons: [Euclid.Polygon] {
        
        switch volume {
            
        case .empty: return []
        case .mantle:
            
            let surface = Mesh(Surface(material: material, volume: .mantle).polygons)
            
            let biscuit = Mesh(EdgeBiscuit(cardinal: cardinal, material: material, volume: .mantle, style: style, inset: material.insetThrone).polygons)
            
            let mesh = surface.intersect(biscuit)
            
            return mesh.polygons
        
        default:
            
            let surfaceThrone = Mesh(Surface(material: material, volume: .throne).polygons)
            let surfaceCrown = Mesh(Surface(material: material, volume: .crown).polygons)
            
            let biscuitThrone = Mesh(EdgeBiscuit(cardinal: cardinal, material: material, volume: .throne, style: style, inset: material.insetThrone).polygons)
            let biscuitCrown = Mesh(EdgeBiscuit(cardinal: cardinal, material: material, volume: .crown, style: style, inset: material.insetCrown).polygons)
            
            let mesh = surfaceThrone.intersect(biscuitThrone).union(surfaceCrown.intersect(biscuitCrown))
            
            return mesh.polygons
        }
    }
}
