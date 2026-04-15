//
//  SlopeMeshingOperation.swift
//
//  Created by Zack Brown on 08/01/2026.
//

import Deltille
import Euclid
import Foundation
import Newel
import PeakOperation
import Yield

internal class SlopeMeshingOperation: MeshingOperation,
                                      @unchecked Sendable {
    
    internal init() {
        
        super.init(category: .slope)
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try Dictionary.folder()
            
            let color = Color("ff8670")
            
            for slope in Slope.allCases {
            
                for rise in Rise.allCases {
                
                    for cast in Cast.allCases {
                        
                        let asset = Asset.slope(slope,
                                                rise,
                                                cast)
                        
                        let mesh = Mesh.slope(slope,
                                              rise,
                                              cast,
                                              color)
                        
                        files[asset.id + .dataSet] = try fileWrapper(for: asset,
                                                                     mesh: mesh)
                    }
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
