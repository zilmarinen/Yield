//
//  FoliageMeshLoadingOperation.swift
//
//  Created by Zack Brown on 10/07/2024.
//

import Deltille
import Dependencies
import Euclid
import Foundation
import PeakOperation
import Verdure

public final class FoliageMeshLoadingOperation: ConcurrentOperation {
    
    @Dependency(\.foliageCache) var foliageCache
    
    public override func execute() {
        
        var meshes: [String : Mesh] = [:]
        
        for foliageType in FoliageType.allCases {
            
            do {
                
                let mesh = try Mesh.decode(foliageType.id,
                                           .module)
                
                meshes[foliageType.id] = mesh
            }
            catch { fatalError(error.localizedDescription) }
        }
        
        foliageCache.merge(meshes)
        
        finish()
    }
}
