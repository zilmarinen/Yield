//
//  Asset.swift
//
//  Created by Zack Brown on 10/07/2024.
//

import PeakOperation

public enum Asset: String,
                   CaseIterable,
                   Identifiable {
    
    case building
    case foliage
    case path
    case terrain
    
    public var id: String { rawValue.capitalized }
}

extension Asset {
    
    var operation: ConcurrentOperation {
        
        switch self {
            
        case .building: return BuildingMeshLoadingOperation()
        case .foliage: return FoliageMeshLoadingOperation()
        case .path: return PathMeshLoadingOperation()
        case .terrain: return TerrainKiteLoadingOperation()
        }
    }
}
