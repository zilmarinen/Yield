//
//  Tileset.swift
//
//  Created by Zack Brown on 16/10/2021.
//

struct Tileset: Codable {
    
    var tiles: [TilesetTile] = []
}

extension Tileset {
    
    mutating func add(tile: TilesetTile) {
        
        guard tiles.first(where: { $0.style == tile.style && $0.sockets == tile.sockets }) == nil else { return }
        
        tiles.append(tile)
    }
}
