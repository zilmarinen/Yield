//
//  EditorTile.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Combine
import Euclid
import Meadow

class EditorTile: ObservableObject {
    
    @Published var tile: Tile = .edge
    @Published var type: TileType = .mono
    
    @Published var primary = SocketConfig(material: .dirt)
    @Published var secondary = SocketConfig(material: .sand)
    @Published var tertiary = SocketConfig(material: .stone)
    @Published var quaternary = SocketConfig(material: .undergrowth)
    
    var prototype: PrototypeTile { Prototype(tile: tile,
                                             type: type,
                                             primary: primary,
                                             secondary: secondary,
                                             tertiary: tertiary,
                                             quaternary: quaternary) }
    
    var sockets: Sockets { prototype.sockets }
    
    var mesh: Mesh { prototype.mesh }
}
