//
//  PrototypeInnerCorner.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Meadow

struct PrototypeInnerCorner: PrototypeTile {
    
    let ordinal: Ordinal
    let material: SurfaceMaterial
    let volume: Volume
    let style: BiscuitStyle
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        let (o0, o1) = ordinal.ordinals
        
        switch volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: material, ordinal: ordinal.opposite)
            sockets.lower.set(value: material, ordinal: o0)
            sockets.lower.set(value: material, ordinal: o1)
            
        case .mantle:
            
            sockets.lower.set(value: material, ordinal: ordinal.opposite)
            sockets.lower.set(value: material, ordinal: o0)
            sockets.lower.set(value: material, ordinal: o1)
            
            sockets.upper.set(value: material, ordinal: ordinal.opposite)
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
            
            let surface = Mesh(Surface(material: material, volume: volume).polygons)
            
            let biscuit = Mesh(InnerCornerBiscuit(ordinal: ordinal, material: material, volume: volume, style: style, inset: material.insetThrone).polygons)
            
            let mesh = surface.subtract(biscuit)
            
            return mesh.polygons
        
        default:
            
            let surfaceThrone = Mesh(Surface(material: material, volume: .throne).polygons)
            let surfaceCrown = Mesh(Surface(material: material, volume: .crown).polygons)
            
            let biscuitThrone = Mesh(InnerCornerBiscuit(ordinal: ordinal, material: material, volume: .throne, style: style, inset: material.insetThrone).polygons)
            let biscuitCrown = Mesh(InnerCornerBiscuit(ordinal: ordinal, material: material, volume: .crown, style: style, inset: material.insetCrown).polygons)
            
            let mesh = surfaceThrone.subtract(biscuitThrone).union(surfaceCrown.subtract(biscuitCrown))
            
            return mesh.polygons
        }
    }
}
