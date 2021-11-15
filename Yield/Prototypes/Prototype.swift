//
//  Prototype.swift
//
//  Created by Zack Brown on 24/10/2021.
//

import Euclid
import Meadow

protocol PrototypeTile {
    
    var rotations: [Ordinal] { get }
    
    var sockets: Sockets { get }
    
    var mesh: Mesh { get }
}

struct Prototype: PrototypeTile {
    
    enum Constants {
        
        static let throneHeight = 0.5 - crownHeight
        static let crownHeight = 0.07
        static let insetDepth = 0.035
        
        static let ceiling = 1.0
        
        static let socketSize = Distance(x: 0.1, y: 0.1, z: 0.1)
    }
    
    let tile: Tile
    let type: TileType
    let primary: SocketConfig
    let secondary: SocketConfig
    let tertiary: SocketConfig
    let quaternary: SocketConfig
    
    var rotations: [Ordinal] { prototype.rotations }
    var sockets: Sockets { prototype.sockets }
    var mesh: Mesh { prototype.mesh }
}

extension Prototype {
    
    var prototype: PrototypeTile {
        
        switch type {
            
        case .mono: return monoPrototype
        case .duo: return duoPrototype
        case .tri: return triPrototype
        case .tetra: return tetraPrototype
        }
    }
    
    var monoPrototype: PrototypeTile {
        
        switch tile {
            
        case .edge: return MonoEdge(config: primary)
        case .groove: return MonoGroove(config: primary)
        case .innerCorner: return MonoInnerCorner(config: primary)
        case .outerCorner: return MonoOuterCorner(config: primary)
        case .plateau: return MonoPlateau(config: primary)
        }
    }
    
    var duoPrototype: PrototypeTile {
        
        switch tile {
            
        case .groove: return TriGroove(primary: primary,
                                       secondary: secondary,
                                       tertiary: tertiary)
            
        case .innerCorner: return DuoInnerCorner(primary: primary,
                                                 secondary: secondary)
            
        case .outerCorner: return DuoOuterCorner(primary: primary,
                                                 secondary: secondary)
            
        default: return DuoPlateau(primary: primary,
                                   secondary: secondary)
        }
    }
    
    var triPrototype: PrototypeTile {
        
        switch tile {
            
        case .edge: return TriEdge(primary: primary,
                                   secondary: secondary,
                                   tertiary: tertiary)
            
        default: return TriGroove(primary: primary,
                                  secondary: secondary,
                                  tertiary: tertiary)
            
        }
    }
    
    var tetraPrototype: PrototypeTile {
        
        return TetraPlateau(primary: primary.with(type: .corner(.northWest)),
                            secondary: secondary.with(type: .corner(.northEast)),
                            tertiary: tertiary.with(type: .corner(.southEast)),
                            quaternary: quaternary.with(type: .corner(.southWest)))
    }
}
