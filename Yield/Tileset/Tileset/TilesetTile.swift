//
//  TilesetTile.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Harvest
import Meadow

struct TilesetTile: Codable {
    
    let id: Int
    let sockets: SurfaceSockets<SurfaceMaterial>
}
