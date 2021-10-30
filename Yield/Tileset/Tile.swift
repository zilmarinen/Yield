//
//  Tile.swift
//
//  Created by Zack Brown on 18/10/2021.
//

enum Tile: String, CaseIterable, Identifiable {
    
    case edge
    case groove
    case innerCorner
    case outerCorner
    case plateau
    
    var id: String {
        
        switch self {
            
        case .edge: return "edge"
        case .groove: return "groove"
        case .innerCorner: return "inner corner"
        case .outerCorner: return "outer corner"
        case .plateau: return "plateau"
        }
    }
}
