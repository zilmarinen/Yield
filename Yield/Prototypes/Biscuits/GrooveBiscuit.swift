//
//  GrooveBiscuit.swift
//
//  Created by Zack Brown on 29/10/2021.
//

import Euclid
import Meadow

struct GrooveBiscuit {
    
    let config: SocketConfig
    
    let insets: Insets
    
    var mesh: Mesh {
        
        guard case let .corner(ordinal) = config.type else { return Mesh([]) }
        
        var surface = Surface(config: config).mesh
        
        let (o0, o1) = ordinal.ordinals
        
        let b0 = CornerBiscuit(config: .init(material: config.material, style: config.style, volume: config.volume, type: .corner(o0)), insets: insets.rhs.opposite).mesh
        
        surface = surface.subtract(b0)
        
        switch config.style {
            
        case .convex,
                .straight:
                
            let b1 = CornerBiscuit(config: .init(material: config.material, style: config.style, volume: config.volume, type: .corner(o1)), insets: insets.lhs.opposite).mesh
            
            return surface.subtract(b1)
            
        default:
            
            let b1 = CornerBiscuit(config: .init(material: config.material, style: .convex, volume: config.volume, type: .corner(o1)), insets: insets.lhs.opposite).mesh
            
            return surface.subtract(b1)
        }
    }
}
