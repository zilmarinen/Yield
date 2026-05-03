//
//  Asset.swift
//
//  Created by Zack Brown on 05/01/2026.
//

import Bivouac
import Cobble
import Deltille
import Lintel
import Newel
import Palisade
import Verdure

public enum Asset: Hashable,
                   Identifiable,
                   Sendable {
    
    public enum Category: String,
                          CaseIterable,
                          Identifiable {
        
        case bridge
        case building
        case fence
        case foliage
        case footpath
        case slope
        
        public var id: String { rawValue.capitalized }
    }
    
    case bridge
    case building(_ septomino: Triangle.Septomino)
    case fence(_ rampart: Rampart,
               _ segment: Segment)
    case foliage(_ septomino: Triangle.Septomino)
    case footpath(_ design: Design,
                  _ wedge: Wedge)
    case slope(_ slope: Slope,
               _ rise: Rise,
               _ cast: Cast)
    
    public var id: String {
        
        switch self {
            
        case .bridge: "Bridge"
        case .building(let septomino):
            
            "Building_\(septomino.id)"
            
        case .fence(let rampart,
                    let segment):
            
            "Fence_\(rampart.id)_\(segment.id)"
            
        case .foliage(let septomino):
            
            "Foliage_\(septomino.id)"
            
        case .footpath(let design,
                       let wedge):
            
            "Footpath_\(design.id)_\(wedge.id)"
            
        case .slope(let slope,
                    let rise,
                    let cast):
            
            "Steps_\(slope.id)_\(cast.id)_\(rise.id)"
        }
    }
    
    public var category: Category {
        
        switch self {
            
        case .bridge: .bridge
        case .building: .building
        case .fence: .fence
        case .foliage: .foliage
        case .footpath: .footpath
        case .slope: .slope
        }
    }
}
