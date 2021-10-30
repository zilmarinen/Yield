//
//  Tileset.swift
//
//  Created by Zack Brown on 16/10/2021.
//

import Combine
import Euclid

class Tileset: ObservableObject {
    
    @Published var identifier: String = "Tileset"
    @Published var tile: Tile = .outerCorner
    
    @Published var material: SurfaceMaterial = .dirt
    @Published var style: BiscuitStyle = .rounded
    @Published var volume: Volume = .crown
    
    var prototype: PrototypeTile { Prototype(tile: tile, material: material, style: style, volume: volume) }
    
    var sockets: Sockets { prototype.sockets }
    
    var mesh: Mesh { Mesh(prototype.polygons) }
}
