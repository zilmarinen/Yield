//
//  Tile.swift
//
//  Created by Zack Brown on 18/10/2021.
//

import Harvest

enum Tile: String, CaseIterable, Identifiable {
    
    case edge
    case groove
    case innerCorner
    case outerCorner
    case plateau
    case scallopedEdge
    
    var id: String {
        
        switch self {
            
        case .edge: return "edge"
        case .groove: return "groove"
        case .innerCorner: return "inner corner"
        case .outerCorner: return "outer corner"
        case .plateau: return "plateau"
        case .scallopedEdge: return "scalloped edge"
        }
    }
    
    var shapes: [SurfaceShape] {
        
        switch self {
            
        case .edge: return SurfaceShape.allCases
        case .groove: return SurfaceShape.allCases
        case .innerCorner: return [.concave, .convex]
        case .outerCorner: return [.concave, .convex]
        case .plateau: return [.straight]
        case .scallopedEdge: return [.straight]
        }
    }
}
