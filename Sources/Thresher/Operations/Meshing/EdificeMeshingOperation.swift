//
//  EdificeMeshingOperation.swift
//
//  Created by Zack Brown on 08/01/2026.
//

import Deltille
import Euclid
import Foundation
import Lintel
import PeakOperation
import Yield

internal class EdificeMeshingOperation: MeshingOperation,
                                        @unchecked Sendable {
    
    internal init() {
        
        super.init(category: .edifice)
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try Dictionary.folder()
            
            for septomino in Triangle.Septomino.allCases {
                
                let asset = Asset.edifice(septomino)
                
                let mesh = Mesh.building(septomino)
                
                files[asset.id + .dataSet] = try fileWrapper(for: asset,
                                                             mesh: mesh)
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
