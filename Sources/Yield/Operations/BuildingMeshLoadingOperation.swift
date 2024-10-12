//
//  BuildingMeshLoadingOperation.swift
//  Yield
//
//  Created by Zack Brown on 12/10/2024.
//

import Deltille
import Dependencies
import Euclid
import Lintel
import Foundation
import PeakOperation

public final class BuildingMeshLoadingOperation: ConcurrentOperation {
    
    @Dependency(\.buildingCache) var buildingCache
    
    public override func execute() {
        
        var meshes: [String : Mesh] = [:]
        
        for architectureType in ArchitectureType.allCases {
            
            for septomino in Grid.Triangle.Septomino.allCases {
                
                for floor in 1...3 {
                    
                    do {
                        
                        let identifier = BuildingCache.identifier(architectureType,
                                                                  septomino,
                                                                  floor)
                        
                        let mesh = try Mesh.decode(identifier,
                                                   .module)
                        
                        meshes[identifier] = mesh
                    }
                    catch { fatalError(error.localizedDescription) }
                }
            }
        }
        
        buildingCache.merge(meshes)
        
        print("Loaded [\(meshes.count)] building meshes")
        
        finish()
    }
}
