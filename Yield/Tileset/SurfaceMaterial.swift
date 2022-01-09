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
        case .stone: return .stone
        case .undergrowth: return .undergrowth
        }
    }
    
    func inset(volume: BiscuitVolume) -> Inset {
        
        switch volume {
        case .crown: return self == .dirt ? .inner : .none
        default: return self == .stone ? .inner : .none
        }
    }
    
    func apexColor(volume: BiscuitVolume) -> Color { volume == .crown ? colors.primary : colors.tertiary }
    func edgeColor(volume: BiscuitVolume) -> Color { volume == .crown ? colors.secondary : colors.quaternary }
    func baseColor(volume: BiscuitVolume) -> Color { volume == .crown ? colors.tertiary : colors.quaternary }
}
