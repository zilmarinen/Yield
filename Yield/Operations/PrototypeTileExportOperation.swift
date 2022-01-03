//
//  PrototypeTileExportOperation.swift
//
//  Created by Zack Brown on 02/11/2021.
//

import Euclid
import Foundation
import Harvest
import PeakOperation

class PrototypeTileExportOperation: ConcurrentOperation, ProducesResult {
    
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    let type: TileType
    let prototypes: [PrototypeTile]
    
    var tileCache: Tileset
    var fileCache: [String : FileWrapper]
    
    init(type: TileType, prototypes: [PrototypeTile], tileCache: Tileset, fileCache: [String : FileWrapper]) {
        
        self.type = type
        self.prototypes = prototypes
        self.tileCache = tileCache
        self.fileCache = fileCache
        
        super.init()
    }
    
    override func execute() {
        
        do {
            
            var id = tileCache.tiles.count
            let encoder = JSONEncoder()
            
            for prototype in prototypes {
                
                let identifier = "surface_tile_\(id)"
                
                let tile = SurfaceTilesetTile(identifier: identifier, sockets: prototype.sockets, style: prototype.style)
                
                tileCache.add(tile: tile)
                
                id += 1
                
                guard !prototype.sockets.isEmpty else { continue }
                
                let model = Model(mesh: prototype.mesh, tile: tile)
            
                let data = try encoder.encode(model)
                
                fileCache["\(identifier).mesh"] = FileWrapper(regularFileWithContents: data)
            }
            
            output = .success((tileCache, fileCache))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
