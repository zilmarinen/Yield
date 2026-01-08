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
        
        case bridge
        case edifice
        case foliage
        case footpath
        case step
        
        public var id: String { rawValue.capitalized }
    }

    
    case bridge
    case edifice
    case foliage(_ septomino: Triangle.Septomino)
    case footpath
    case steps(_ stoop: Stoop,
               _ direction: Stoop.Direction)
    
    public var id: String {
        
        switch self {
            
        case .bridge: "Bridge"
        case .edifice: "Edifice"
        case .foliage(let septomino):
            
            "Foliage_\(septomino.id)"
            
        case .footpath: "Footpath"
        case .steps(let stoop,
                    let direction):
            
            "Steps_\(stoop.id)_\(direction.id)"
        }
    }
    
    public var category: Category {
        
        switch self {
            
        case .bridge: .bridge
        case .edifice: .edifice
        case .foliage: .foliage
        case .footpath: .footpath
        case .steps: .step
        }
    }
}
