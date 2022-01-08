//
//  GrooveBiscuit.swift
//
//  Created by Zack Brown on 29/10/2021.
//

import Euclid
import Harvest
import Meadow

struct GrooveBiscuit {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: BiscuitVolume
    let ordinal: Ordinal
    
    var mesh: Mesh {
        
        var surface = Surface(material: material, volume: volume).mesh
        
        let (o0, o1) = ordinal.ordinals
        
        let inset = material.inset(volume: volume).opposite
        
        let b0 = CornerBiscuit(shape: shape, material: material, volume: volume, ordinal: o0, inset: inset).mesh
        
        surface = surface.subtract(b0)
        
        switch shape {
            
        case .convex,
                .straight:
            
            let b1 = CornerBiscuit(shape: shape, material: material, volume: volume, ordinal: o1, inset: inset).mesh
            
            return surface.subtract(b1)
            
        default:
            
            let b1 = CornerBiscuit(shape: .convex, material: material, volume: volume, ordinal: o1, inset: inset).mesh
            
            return surface.subtract(b1)
        }
    }
}
