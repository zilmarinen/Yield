//
//  PrototypeTileExportOperation.swift
//
//  Created by Zack Brown on 02/11/2021.
//

import Euclid
import Foundation
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
                
                let hasMesh = !prototype.sockets.isEmpty && !prototype.sockets.isFull
                
                let identifier = hasMesh ? "\(id)_\(type)" : nil
                
                let tile = TilesetTile(id: id, mesh: identifier, sockets: prototype.sockets, style: prototype.style)
                
                tileCache.add(tile: tile)
                
                id += 1
                
                guard hasMesh,
                      let identifier = identifier else { continue }
                
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
