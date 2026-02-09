//
//  StaircaseMeshingOperation.swift
//
//  Created by Zack Brown on 08/01/2026.
//

import Deltille
import Euclid
import Foundation
import Newel
import PeakOperation
import Yield

internal class StaircaseMeshingOperation: MeshingOperation,
                                          @unchecked Sendable {
    
    internal init() {
        
        super.init(category: .step)
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try Dictionary.folder()
            
            for staircaseType in StaircaseType.allCases {
                
                for direction in StaircaseType.Direction.allCases {
                    
                    let asset = Asset.steps(staircaseType,
                                            direction)
                    
                    let mesh = Mesh.staircase(staircaseType,
                                              7,
                                              1.0,
                                              direction)
                    
                    files[asset.id + .dataSet] = try fileWrapper(for: asset,
                                                                 mesh: mesh)
                }
            }
            
            output = .success((files,
                               category.id))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
