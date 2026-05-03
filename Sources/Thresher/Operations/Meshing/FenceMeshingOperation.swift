//
//  FenceMeshingOperation.swift
//  Yield
//
//  Created by Zack Brown on 03/05/2026.
//

import Alluvium
import Bivouac
import Deltille
import Euclid
import Foundation
import Palisade
import PeakOperation
import Yield

internal class FenceMeshingOperation: MeshingOperation,
                                      @unchecked Sendable {
    
    internal init() {
        
        super.init(category: .fence)
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try Dictionary.folder()
            
            let triangle = Triangle.zero
            
            let wedges: [Wedge] = [.corner(triangle: triangle,
                                           corner: .c0),
                                   .edge(triangle: triangle,
                                         edge: .e0),
                                   .tile(triangle: triangle,
                                         corners: triangle.corners)]
            
            var segments: [Segment] = [.doorwayCorner(triangle: triangle,
                                                      corner: .c0),
                                       .doorwayEdge(triangle: triangle,
                                                    edge: .e0,
                                                    mirrored: false),
                                       .doorwayEdge(triangle: triangle,
                                                    edge: .e0,
                                                    mirrored: true)]
            
            segments.append(contentsOf: wedges.map { .wall(wedge: $0) })
            
            for segment in segments {
                
                for rampart in Rampart.allCases {
                    
                    let asset = Asset.fence(rampart,
                                            segment)
                    
                    let mesh = Mesh.fence(segment,
                                          rampart)
                    
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
