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
    
    var material: SurfaceMaterial { get }
    var volume: SurfaceVolume { get }
    var rotations: [Ordinal] { get }
    var variation: Int { get }
}

struct Prototype: PrototypeTile {
    
    enum Constants {
        
        static let throneHeight = ceiling - crownHeight
        static let crownHeight = 0.07
        static let insetDepth = 0.035
        
        static let ceiling = 0.5
        
        static let edgeSteps = 4
        
        static let socketSize = Vector(x: 0.1, y: 0.1, z: 0.1)
    }
    
    let tile: Tile
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: SurfaceVolume
    
    var sockets: OrdinalPattern<SurfaceSocket> { prototype.sockets }
    var mesh: Mesh { prototype.mesh }
    var rotations: [Ordinal] { prototype.rotations }
    var variation: Int { prototype.variation }
}

extension Prototype {
    
    var prototype: PrototypeTile {
        
        switch tile {
            
        case .edge: return PrototypeEdge(shape: shape, material: material, volume: volume, cardinal: .north)
        case .groove: return PrototypeGroove(shape: shape, material: material, volume: volume, ordinal: .northWest)
        case .innerCorner: return PrototypeInnerCorner(shape: shape, material: material, volume: volume, ordinal: .southWest)
        case .outerCorner: return PrototypeOuterCorner(shape: shape, material: material, volume: volume, ordinal: .northWest)
        case .plateau: return PrototypePlateau(material: material, volume: volume)
        case .scallopedEdge: return PrototypeScallopedEdge(material: material, volume: volume, ordinal: .northWest, cardinal: .north)
        }
    }
}
