//
//  TerrainKiteLoadingOperation.swift
//
//  Created by Zack Brown on 10/07/2024.
//

import Deltille
import Dependencies
import Euclid
import PeakOperation
import Regolith

public final class TerrainKiteLoadingOperation: ConcurrentOperation {
    
    @Dependency(\.terrainCache) var terrainCache
    
    public override func execute() {
        
        var meshes: [String : Mesh] = [:]
        
        for kite in Grid.Triangle.Kite.allCases {
            
            for terrainType in TerrainType.allCases {
                
                for elevation in Grid.Triangle.Kite.Elevation.allCases {
                    
                    do {
                        
                        let identifier = TerrainCache.identifier(kite,
                                                                 terrainType,
                                                                 elevation)
                        
                        let mesh = try Mesh.decode(identifier,
                                                   .module)
                        
                        meshes[identifier] = mesh
                    }
                    catch { fatalError(error.localizedDescription) }
                }
            }
        }
        
        terrainCache.merge(meshes)
        
        finish()
    }
}
