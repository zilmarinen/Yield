//
//  Prototype.swift
//
//  Created by Zack Brown on 24/10/2021.
//

import Euclid
import Harvest
import Meadow

protocol PrototypeTile {
    
    var sockets: OrdinalPattern<SurfaceSocket> { get }
    
    var mesh: Mesh { get }
    
    var shape: SurfaceShape { get }
    var material: SurfaceMaterial { get }
}

struct Prototype: PrototypeTile {
    
    enum Constants {
        
        static let throneHeight = ceiling - crownHeight
        static let crownHeight = 0.07
        static let insetDepth = 0.035
        
        static let ceiling = 0.5
        
        static let socketSize = Vector(x: 0.1, y: 0.1, z: 0.1)
    }
    
    let tile: Tile
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: BiscuitVolume
    
    var sockets: OrdinalPattern<SurfaceSocket> { prototype.sockets }
    var mesh: Mesh { prototype.mesh }
}

extension Prototype {
    
    var prototype: PrototypeTile {
        
        switch tile {
            
        case .edge: return MonoEdge(shape: shape, material: material, volume: volume, cardinal: .north)
        case .groove: return MonoGroove(shape: shape, material: material, volume: volume, ordinal: .northWest)
        case .innerCorner: return MonoInnerCorner(shape: shape, material: material, volume: volume, ordinal: .southWest)
        case .outerCorner: return MonoOuterCorner(shape: shape, material: material, volume: volume, ordinal: .northWest)
        case .plateau: return MonoPlateau(shape: shape, material: material, volume: volume)
        }
    }
}
