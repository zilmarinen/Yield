//
//  PrototypeOuterCorner.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Meadow

struct PrototypeOuterCorner: PrototypeTile {
    
    let ordinal: Ordinal
    let material: SurfaceMaterial
    let volume: Volume
    let style: BiscuitStyle
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        
        switch volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: material, ordinal: ordinal)
            
        case .mantle:
            
            sockets.lower.set(value: material, ordinal: ordinal)
            
            sockets.upper.set(value: material, ordinal: ordinal)
            
        default: break
        }
        
        return sockets
    }
    
    var polygons: [Euclid.Polygon] {
        
        switch volume {
            
        case .empty: return []
        case .mantle:
            
            let surface = Mesh(Surface(material: material, volume: volume).polygons)
            
            let biscuit = Mesh(OuterCornerBiscuit(ordinal: ordinal, material: material, volume: volume, style: style, inset: material.insetThrone).polygons)
            
            let mesh = surface.intersect(biscuit)
            
            return mesh.polygons
        
        default:
            
            let surfaceThrone = Mesh(Surface(material: material, volume: .throne).polygons)
            let surfaceCrown = Mesh(Surface(material: material, volume: .crown).polygons)
            
            let biscuitThrone = Mesh(OuterCornerBiscuit(ordinal: ordinal, material: material, volume: .throne, style: style, inset: material.insetThrone).polygons)
            let biscuitCrown = Mesh(OuterCornerBiscuit(ordinal: ordinal, material: material, volume: .crown, style: style, inset: material.insetCrown).polygons)
            
            let mesh = surfaceThrone.intersect(biscuitThrone).union(surfaceCrown.intersect(biscuitCrown))
            
            return mesh.polygons
        }
    }
}
