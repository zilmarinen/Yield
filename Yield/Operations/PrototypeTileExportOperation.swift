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
    let startIndex: Int
    
    init(type: TileType, prototypes: [PrototypeTile], startIndex: Int) {
        
        self.type = type
        self.prototypes = prototypes
        self.startIndex = startIndex
        
        super.init()
    }
    
    override func execute() {
        
        do {
            
            var tileset = Tileset()
            var wrappers: [String : FileWrapper] = [:]
            var id = startIndex
            let encoder = JSONEncoder()
            
            for tile in prototypes {
                
                let sockets = tile.rotations.map { tile.sockets.rotate(ordinal: $0) }
                
                tileset.tiles.append(TilesetTile(id: id, sockets: sockets))
                
                let data = try encoder.encode(tile.mesh)
                
                wrappers["\(type)_surface_tile_\(id).mesh"] = FileWrapper(regularFileWithContents: data)
                
                id += 1
            }
            
            output = .success((tileset, wrappers))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
