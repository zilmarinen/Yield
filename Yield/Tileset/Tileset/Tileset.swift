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
        
        guard tiles.first(where: { $0.style == tile.style && $0.sockets == tile.sockets }) == nil else { return }
        
        tiles.append(tile)
    }
}
