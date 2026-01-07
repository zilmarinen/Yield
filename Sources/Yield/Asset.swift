//
//  Asset.swift
//
//  Created by Zack Brown on 05/01/2026.
//

import Cobble
import Deltille
import Lattice
import Lintel
import Newel
import Verdure

public enum Asset: Identifiable {
    
    public enum Category: String,
                          CaseIterable,
                          Identifiable {
        
        case bridges
        case edifices
        case foliage
        case footpaths
        case steps
        
        public var id: String { rawValue.capitalized }
    }

    
    case bridge
    case edifice
    case foliage(_ septomino: Triangle.Septomino)
    case footpath
    case steps
    
    public var id: String {
        
        switch self {
            
        case .bridge: "Bridge"
        case .edifice: "Edifice"
        case .foliage(let septomino):
            "Foliage_\(septomino.id)"
        case .footpath: "Footpath"
        case .steps: "Steps"
        }
    }
    
    public var category: Category {
        
        switch self {
            
        case .bridge: .bridges
        case .edifice: .edifices
        case .foliage: .foliage
        case .footpath: .footpaths
        case .steps: .steps
        }
    }
}
