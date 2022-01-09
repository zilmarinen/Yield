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
        
        for volume in BiscuitVolume.solids {
            
            for material in SurfaceMaterial.solids {
                
                prototypes.append(PrototypeEdge(shape: .concave, material: material, volume: volume, cardinal: .north))
                prototypes.append(PrototypeEdge(shape: .straight, material: material, volume: volume, cardinal: .north))
                prototypes.append(PrototypeEdge(shape: .convex, material: material, volume: volume, cardinal: .north))
                
                prototypes.append(PrototypeGroove(shape: .concave, material: material, volume: volume, ordinal: .northWest))
                prototypes.append(PrototypeGroove(shape: .straight, material: material, volume: volume, ordinal: .northWest))
                prototypes.append(PrototypeGroove(shape: .convex, material: material, volume: volume, ordinal: .northWest))
                
                prototypes.append(PrototypeInnerCorner(shape: .concave, material: material, volume: volume, ordinal: .southWest))
                prototypes.append(PrototypeInnerCorner(shape: .convex, material: material, volume: volume, ordinal: .southWest))
                
                prototypes.append(PrototypeOuterCorner(shape: .concave, material: material, volume: volume, ordinal: .northWest))
                prototypes.append(PrototypeOuterCorner(shape: .convex, material: material, volume: volume, ordinal: .northWest))
                
                prototypes.append(PrototypePlateau(shape: .straight, material: material, volume: volume))
                
                prototypes.append(PrototypeScallopedEdge(shape: .straight, material: material, volume: volume, ordinal: .northWest, cardinal: .north))
                prototypes.append(PrototypeScallopedEdge(shape: .straight, material: material, volume: volume, ordinal: .northWest, cardinal: .west))
            }
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
