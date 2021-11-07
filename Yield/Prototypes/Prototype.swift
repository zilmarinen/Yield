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
        
        static let socketSize = Vector(x: 0.1, y: 0.1, z: 0.1)
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
        case .tri: return monoPrototype
        case .tetra: return monoPrototype
        }
    }
    
    var monoPrototype: PrototypeTile {
        
        switch tile {
            
        case .edge: return MonoEdge(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .edge(.north)))
        case .groove: return MonoGroove(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .corner(.northWest)))
        case .innerCorner: return MonoInnerCorner(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .corner(.southWest)))
        case .outerCorner: return MonoOuterCorner(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .corner(.northWest)))
        case .plateau: return MonoPlateau(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .plateau))
        }
    }
    
    var duoPrototype: PrototypeTile {
        
        switch tile {
            
        case .edge: return DuoEdge(primary: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .edge(.north)),
                                   secondary: secondary)
            
        case .groove: return DuoGroove(primary: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .corner(.northWest)),
                                       secondary: secondary)
            
        case .innerCorner: return MonoInnerCorner(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .corner(.southWest)))
        case .outerCorner: return MonoOuterCorner(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .corner(.northWest)))
        case .plateau: return MonoPlateau(config: .init(material: primary.material, style: primary.style, volume: primary.volume, type: .plateau))
        }
    }
}
