//
//  PrototypePlateau.swift
//
//  Created by Zack Brown on 25/10/2021.
//

import Euclid
import Meadow

struct PrototypePlateau: PrototypeTile {
    
    let material: SurfaceMaterial
    let volume: Volume
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        
        switch volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: material)
            
        case .mantle:
            
            sockets.lower.set(value: material)
            
            sockets.upper.set(value: material)
            
        default: break
        }
        
        return sockets
    }
    
    var polygons: [Euclid.Polygon] {
        
        switch volume {
            
        case .empty: return []
        case .mantle:
            
            return Surface(material: material, volume: volume).polygons
        
        default:
            
            let surfaceThrone = Mesh(Surface(material: material, volume: .throne).polygons)
            let surfaceCrown = Mesh(Surface(material: material, volume: .crown).polygons)
            
            let mesh = surfaceThrone.union(surfaceCrown)
            
            return mesh.polygons
        }
    }
}
