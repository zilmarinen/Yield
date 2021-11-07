//
//  EditorTile.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Combine
import Euclid
import Meadow

class EditorTile: ObservableObject {
    
    enum Format: String, CaseIterable, Identifiable {
        
        case corner
        case edge
        
        var id: String { rawValue }
    }
    
    @Published var tile: Tile = .edge
    @Published var type: TileType = .duo
    
    @Published var format: Format = .corner
    @Published var cardinal: Cardinal = .north
    @Published var ordinal: Ordinal = .southEast
    
    @Published var primary = SocketConfig(material: .dirt)
    @Published var secondary = SocketConfig(material: .sand)
    @Published var tertiary = SocketConfig(material: .stone)
    @Published var quaternary = SocketConfig(material: .undergrowth)
    
    var prototype: PrototypeTile { Prototype(tile: tile,
                                             type: type,
                                             primary: primary,
                                             secondary: .init(material: secondary.material, style: primary.style.opposite, volume: secondary.volume, type: format == .corner ? .corner(ordinal) : .edge(cardinal)),
                                             tertiary: tertiary,
                                             quaternary: quaternary) }
    
    var sockets: Sockets { prototype.sockets }
    
    var mesh: Mesh { prototype.mesh }
}
