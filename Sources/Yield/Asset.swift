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
    
    case bridge
    case edifice
    case foliage(_ septomino: Triangle.Septomino)
    case footpath
    case steps
    
    public var id: String {
        
        switch self {
            
        case .bridge: "Bridge"
        case .edifice: "Edifice"
        case .foliage: "Foliage"
        case .footpath: "Footpath"
        case .steps: "Steps"
        }
    }
}
