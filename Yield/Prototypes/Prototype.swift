//
//  Prototype.swift
//
//  Created by Zack Brown on 24/10/2021.
//

import Euclid
import Meadow

protocol PrototypeTile {
    
    var sockets: Sockets { get }
    
    var polygons: [Euclid.Polygon] { get }
}

struct Prototype: PrototypeTile {
    
    enum Constants {
        
        static let throneHeight = 0.5 - crownHeight
        static let crownHeight = 0.07
        static let insetDepth = 0.035
        
        static let ceiling = 1.0
        
        static let socketSize = Vector(x: 0.1, y: 0.1, z: 0.1)
    }
    
    let tile: Tile
    let material: SurfaceMaterial
    let style: BiscuitStyle
    let volume: Volume
    
    var sockets: Sockets { prototype.sockets }
    var polygons: [Euclid.Polygon] { prototype.polygons }
}

extension Prototype {
    
    var prototype: PrototypeTile {
        
        switch tile {
            
        case .edge: return PrototypeEdge(cardinal: .north, material: material, volume: volume, style: style)
        case .groove: return PrototypeGroove(ordinal: .northWest, material: material, volume: volume, style: style)
        case .innerCorner: return PrototypeInnerCorner(ordinal: .southWest, material: material, volume: volume, style: style)
        case .outerCorner: return PrototypeOuterCorner(ordinal: .northWest, material: material, volume: volume, style: style)
        case .plateau: return PrototypePlateau(material: material, volume: volume)
        }
    }
}
