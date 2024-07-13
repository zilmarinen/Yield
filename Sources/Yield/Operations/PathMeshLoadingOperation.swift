//
//  PathMeshLoadingOperation.swift  
//
//  Created by Zack Brown on 13/07/2024.
//

import Deltille
import Dependencies
import Euclid
import Foundation
import Furrow
import PeakOperation

public final class PathMeshLoadingOperation: ConcurrentOperation {
    
    @Dependency(\.pathCache) var pathCache
    
    public override func execute() {
        
        var meshes: [String : Mesh] = [:]
        
        for material in PathMaterial.allCases {
            
            for style in PathStyle.allCases {
                
                for pathType in PathType.allCases {
                    
                    do {
                        
                        let identifier = PathCache.identifier(material,
                                                              style,
                                                              pathType)
                        
                        let mesh = try Mesh.decode(identifier,
                                                   .module)
                        
                        meshes[identifier] = mesh
                    }
                    catch { fatalError(error.localizedDescription) }
                }
            }
        }
        
        pathCache.merge(meshes)
        
        finish()
    }
}
