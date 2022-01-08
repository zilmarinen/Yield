//
//  TilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Harvest
import Meadow
import PeakOperation

class TilesetExportOperation: ConcurrentOperation, ProducesResult {
    
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        var prototypes: [PrototypeTile] = []
        
        for material in SurfaceMaterial.solids {
            
            prototypes.append(MonoEdge(shape: .concave, material: material, volume: .crown, cardinal: .north))
            prototypes.append(MonoEdge(shape: .straight, material: material, volume: .crown, cardinal: .north))
            prototypes.append(MonoEdge(shape: .convex, material: material, volume: .crown, cardinal: .north))
            
            prototypes.append(MonoGroove(shape: .concave, material: material, volume: .crown, ordinal: .northWest))
            prototypes.append(MonoGroove(shape: .straight, material: material, volume: .crown, ordinal: .northWest))
            prototypes.append(MonoGroove(shape: .convex, material: material, volume: .crown, ordinal: .northWest))
            
            prototypes.append(MonoInnerCorner(shape: .concave, material: material, volume: .crown, ordinal: .southWest))
            prototypes.append(MonoInnerCorner(shape: .convex, material: material, volume: .crown, ordinal: .southWest))
            
            prototypes.append(MonoOuterCorner(shape: .concave, material: material, volume: .crown, ordinal: .northWest))
            prototypes.append(MonoOuterCorner(shape: .straight, material: material, volume: .crown, ordinal: .northWest))
            prototypes.append(MonoOuterCorner(shape: .convex, material: material, volume: .crown, ordinal: .northWest))
            
            prototypes.append(MonoPlateau(shape: .straight, material: material, volume: .crown))
        }
        
        let exportOperation = PrototypeTileExportOperation(prototypes: prototypes, tileCache: Tileset(), fileCache: [:])
        
        let group = DispatchGroup()
        
        group.enter()
        
        exportOperation.enqueue(on: internalQueue) { [weak self] result in
            
            guard let self = self else { return }
            
            self.output = result
            
            group.leave()
        }
        
        group.wait()
        
        finish()
    }
}
