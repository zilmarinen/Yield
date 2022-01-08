//
//  Tileset.swift
//
//  Created by Zack Brown on 16/10/2021.
//

import Harvest

struct Tileset {
    
    var tiles: [SurfaceTilesetTile] = []
}

extension Tileset {
    
    mutating func add(tile: SurfaceTilesetTile) {
        
        guard tiles.first(where: { $0.shape == tile.shape && $0.sockets == tile.sockets }) == nil else { return }
        
        tiles.append(tile)
    }
}
