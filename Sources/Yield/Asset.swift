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

public enum Asset: Hashable,
                   Identifiable,
                   Sendable {
    
    public enum Category: String,
                          CaseIterable,
                          Identifiable {
        
        case bridge
        case building
        case foliage
        case footpath
        case staircase
        
        public var id: String { rawValue.capitalized }
    }

    
    case bridge
    case building(_ septomino: Triangle.Septomino)
    case foliage(_ septomino: Triangle.Septomino)
    case footpath
    case staircase(_ staircaseType: StaircaseType,
                   _ direction: StaircaseType.Direction)
    
    public var id: String {
        
        switch self {
            
        case .bridge: "Bridge"
        case .building(let septomino):
            
            "Building_\(septomino.id)"
            
        case .foliage(let septomino):
            
            "Foliage_\(septomino.id)"
            
        case .footpath: "Footpath"
        case .staircase(let staircaseType,
                        let direction):
            
            "Steps_\(staircaseType.id)_\(direction.id)"
        }
    }
    
    public var category: Category {
        
        switch self {
            
        case .bridge: .bridge
        case .building: .building
        case .foliage: .foliage
        case .footpath: .footpath
        case .staircase: .staircase
        }
    }
}
