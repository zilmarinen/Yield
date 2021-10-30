//
//  GrooveBiscuit.swift
//
//  Created by Zack Brown on 29/10/2021.
//

import Euclid
import Meadow

struct GrooveBiscuit {
    
    let ordinal: Ordinal
    
    let material: SurfaceMaterial
    let volume: Volume
    let style: BiscuitStyle
    
    let inset: Bool
    
    var polygons: [Euclid.Polygon] {
        
        var surface = Mesh(Surface(material: material, volume: volume).polygons)
        
        let (o0, o1) = ordinal.ordinals
        
        let b0 = Mesh(InnerCornerBiscuit(ordinal: o0, material: material, volume: volume, style: style, inset: inset).polygons)
        
        surface = surface.subtract(b0)
        
        switch style {
        case .rounded:
        
            let b1 = Mesh(InnerCornerBiscuit(ordinal: o1, material: material, volume: volume, style: style, inset: inset).polygons)
            
            return surface.subtract(b1).polygons
            
        case .squared:
            
            let b1 = Mesh(InnerCornerBiscuit(ordinal: o1, material: material, volume: volume, style: .rounded, inset: inset).polygons)
            
            return surface.subtract(b1).polygons
        }
    }
}
