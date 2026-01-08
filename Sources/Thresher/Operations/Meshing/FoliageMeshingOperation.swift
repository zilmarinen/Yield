//
//  FoliageMeshingOperation.swift
//
//  Created by Zack Brown on 07/01/2026.
//

import Deltille
import Euclid
import Foundation
import PeakOperation
import Verdure
import Yield

internal class FoliageMeshingOperation: MeshingOperation,
                                        @unchecked Sendable {
    
    internal init() {
        
        super.init(category: .foliage)
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try Dictionary.folder()
            
            for septomino in Triangle.Septomino.allCases {
                
                for style in CanopyStyle.allCases {
                    
                    let asset = Asset.foliage(septomino)
                    
                    let mesh = Mesh.foliage(septomino,
                                            style,
                                            Mesh.canopyColorPalette,
                                            Mesh.trunkColorPalette)
                    
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
