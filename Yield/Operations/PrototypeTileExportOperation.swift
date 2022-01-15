//
//  PrototypeTileExportOperation.swift
//
//  Created by Zack Brown on 02/11/2021.
//

import Euclid
import Foundation
import Harvest
import Meadow
import PeakOperation

class PrototypeTileExportOperation: ConcurrentOperation, ProducesResult {
    
    public var output: Result<([SurfaceTilesetTile], [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    let prototypes: [PrototypeTile]
    
    init(prototypes: [PrototypeTile]) {
        
        self.prototypes = prototypes
        
        super.init()
    }
    
    override func execute() {
        
        do {
            
            var tileset: [SurfaceTilesetTile] = []
            var wrappers: [String : FileWrapper] = [:]
            
            var id = 0
            let encoder = JSONEncoder()
            
            for prototype in prototypes {
                
                let identifier = "surface_tile_\(id)"
                
                let tile = SurfaceTilesetTile(identifier: identifier, variation: prototype.variation, material: prototype.material, rotations: prototype.rotations, sockets: prototype.sockets, volume: prototype.volume)
                
                tileset.append(tile)
                
                id += 1
                
                let model = Model(mesh: prototype.mesh, tile: tile)
            
                let data = try encoder.encode(model)
                
                wrappers["\(identifier).mesh"] = FileWrapper(regularFileWithContents: data)
            }
            
            output = .success((tileset, wrappers))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
