//
//  SurfaceMaterial.swift
//
//  Created by Zack Brown on 27/10/2021.
//

import Euclid
import Meadow

extension SurfaceMaterial {
    
    var colors: ColorPalette {
        
        switch self {
            
        case .air: return .air
        case .dirt: return .dirt
        case .sand: return .sand
        case .snow: return .snow
        case .stone: return .stone
        case .undergrowth: return .undergrowth
        }
    }
    
    var remainder: [SurfaceMaterial] {
        
        switch self {
            
        case .air: return []
        case .dirt: return [.sand, .snow, .stone, .undergrowth]
        case .sand: return [.dirt, .snow, .stone, .undergrowth]
        case .snow: return [.dirt, .sand, .stone, .undergrowth]
        case .stone: return [.dirt, .sand, .snow, .undergrowth]
        case .undergrowth: return [.dirt, .sand, .snow, .stone]
        }
    }
    
    func inset(volume: Volume) -> Inset {
        
        switch volume {
        case .crown: return self == .dirt || self == .snow ? .inner : .none
        case .throne: return self == .stone ? .inner : .none
        case .mantle: return self == .stone ? .inner : .none
        default: return .none
        }
    }
    
    func adjacentInset(volume: Volume, material: SurfaceMaterial) -> Inset {
        
        switch volume {
            
        case .throne:
            
            return material.inset(volume: volume).opposite
            
        default: return inset(volume: volume)
        }
    }
    
    func apexColor(volume: Volume) -> Color { volume == .crown ? colors.primary : colors.tertiary }
    func edgeColor(volume: Volume) -> Color { volume == .crown ? colors.secondary : colors.quaternary }
    func baseColor(volume: Volume) -> Color { volume == .crown ? colors.tertiary : colors.quaternary }
}
