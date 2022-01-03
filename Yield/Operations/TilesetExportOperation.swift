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
            
            let edgeConfig = SocketConfig(material: material, style: .concave, volume: .crown, type: .edge(.north))
            let grooveConfig = SocketConfig(material: material, style: .concave, volume: .crown, type: .corner(.northWest))
            let innerCornerConfig = SocketConfig(material: material, style: .concave, volume: .crown, type: .corner(.southWest))
            let outerCornerConfig = SocketConfig(material: material, style: .concave, volume: .crown, type: .corner(.northWest))
            let plateauConfig = SocketConfig(material: material, style: .concave, volume: .crown, type: .edge(.north))
            
            prototypes.append(MonoEdge(config: edgeConfig.with(style: .concave)))
            prototypes.append(MonoEdge(config: edgeConfig.with(style: .straight)))
            prototypes.append(MonoEdge(config: edgeConfig.with(style: .convex)))
            
            prototypes.append(MonoGroove(config: grooveConfig.with(style: .concave)))
            prototypes.append(MonoGroove(config: grooveConfig.with(style: .straight)))
            prototypes.append(MonoGroove(config: grooveConfig.with(style: .convex)))
            
            prototypes.append(MonoInnerCorner(config: innerCornerConfig.with(style: .concave)))
            prototypes.append(MonoInnerCorner(config: innerCornerConfig.with(style: .convex)))
            
            prototypes.append(MonoOuterCorner(config: outerCornerConfig.with(style: .concave)))
            prototypes.append(MonoOuterCorner(config: outerCornerConfig.with(style: .straight)))
            prototypes.append(MonoOuterCorner(config: outerCornerConfig.with(style: .convex)))
            
            prototypes.append(MonoPlateau(config: plateauConfig))
        }
        
        let exportOperation = PrototypeTileExportOperation(type: .mono, prototypes: prototypes, tileCache: Tileset(), fileCache: [:])
        
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
