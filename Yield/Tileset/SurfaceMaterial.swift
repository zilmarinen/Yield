//
//  SurfaceMaterial.swift
//
//  Created by Zack Brown on 27/10/2021.
//

import Euclid

enum SurfaceMaterial: String, CaseIterable, Codable, Identifiable {
    
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
    
    var insetCrown: Bool {
        
        switch self {
            
        case .dirt: return true
        default: return false
        }
    }
    
    var insetThrone: Bool {
        
        switch self {
            
        case .stone: return true
        default: return false
        }
    }
}
