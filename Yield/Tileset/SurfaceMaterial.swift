//
//  SurfaceMaterial.swift
//
//  Created by Zack Brown on 27/10/2021.
//

import Euclid

enum SurfaceMaterial: String, CaseIterable, Codable, Identifiable {
    
    static let solids: [SurfaceMaterial] = [.dirt,
                                            .sand,
                                            .stone,
                                            .undergrowth]
    
    case air
    case dirt
    case sand
    case stone
    case undergrowth
    
    var id: String { rawValue }
    
    var colors: ColorPalette {
        
        switch self {
            
        case .air: return .air
        case .dirt: return .dirt
        case .sand: return .sand
        case .stone: return .stone
        case .undergrowth: return .undergrowth
        }
    }
    
    func inset(volume: Volume) -> Inset {
        
        switch volume {
        case .crown: return self == .dirt ? .inner : .none
        case .throne: return self == .stone ? .inner : .none
        case .mantle: return self == .stone ? .inner : .none
        default: return .none
        }
    }
    
    func adjacentInset(volume: Volume, material: SurfaceMaterial) -> Inset {
        
        switch volume {
            
        case .throne:
            
            guard inset(volume: volume) != .inner else { return .inner }
            
            return material.inset(volume: volume).opposite
            
        default: return inset(volume: volume)
        }
    }
    
    func apexColor(volume: Volume) -> Color { volume == .crown ? colors.primary : colors.tertiary }
    func edgeColor(volume: Volume) -> Color { volume == .crown ? colors.secondary : colors.quaternary }
    func baseColor(volume: Volume) -> Color { volume == .crown ? colors.tertiary : colors.quaternary }
}
