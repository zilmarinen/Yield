//
//  FootpathMeshingOperation.swift
//  Yield
//
//  Created by Zack Brown on 07/01/2026.
//

import Alluvium
import Bivouac
import Cobble
import Deltille
import Euclid
import Foundation
import PeakOperation
import Yield

internal class FootpathMeshingOperation: MeshingOperation,
                                         @unchecked Sendable {
    
    internal init() {
        
        super.init(category: .footpath)
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try Dictionary.folder()
            
            let triangle = Triangle.zero
            
            let colorPalette = ColorPalette("#A98B76",
                                            "#BFA28C",
                                            "#F3E4C9",
                                            "#BABF94")
            
            let wedges = [Wedge.corner(triangle: triangle,
                                       corner: .c0),
                          Wedge.edge(triangle: triangle,
                                     edge: .e0),
                          Wedge.tile(triangle: triangle,
                                     corners: triangle.corners)]
            
            for design in Design.allCases {
                
                for wedge in wedges {
                    
                    let asset = Asset.footpath(design,
                                               wedge)
                    
                    let mesh = Mesh.footpath(wedge,
                                             design,
                                             colorPalette)
                    
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
