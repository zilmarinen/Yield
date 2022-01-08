//
//  EditorTile.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Combine
import Euclid
import Harvest
import Meadow

class EditorTile: ObservableObject {
    
    @Published var tile: Tile = .edge
    @Published var shape: SurfaceShape = .straight
    @Published var material: SurfaceMaterial = .dirt
    @Published var volume: BiscuitVolume = .crown
    
    var prototype: PrototypeTile { Prototype(tile: tile, shape: shape, material: material, volume: volume) }
    
    var sockets: OrdinalPattern<SurfaceSocket> { prototype.sockets }
    
    var mesh: Mesh { prototype.mesh }
}
