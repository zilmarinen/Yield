//
//  DuoEdge.swift
//
//  Created by Zack Brown on 02/11/2021.
//

import Euclid
import Meadow

struct DuoEdge: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        
        guard case let .edge(cardinal) = primary.type else { return sockets }
        
        let (o0, o1) = cardinal.ordinals
        
        switch primary.volume {
        case .crown,
                .throne:
            
            sockets.lower.set(value: primary.material, ordinal: o0)
            sockets.lower.set(value: primary.material, ordinal: o1)
            
        case .mantle:
            
            sockets.lower.set(value: primary.material, ordinal: o0)
            sockets.lower.set(value: primary.material, ordinal: o1)
            
            sockets.upper.set(value: primary.material, ordinal: o0)
            sockets.upper.set(value: primary.material, ordinal: o1)
            
        default: break
        }
        
        switch secondary.type {
        case .edge:
        
            let prototype = MonoEdge(config: .init(material: secondary.material, style: secondary.style, volume: secondary.volume, type: secondary.type))
        
            sockets = sockets.union(sockets: prototype.sockets)
        
        case .corner:
        
            let prototype = MonoOuterCorner(config: .init(material: secondary.material, style: secondary.style, volume: secondary.volume, type: secondary.type))
        
            sockets = sockets.union(sockets: prototype.sockets)
            
        default: break
        }
        
        return sockets
    }
    
    var mesh: Mesh {
        
        guard !sockets.isEmpty,
              !sockets.isFull,
              case let .edge(cardinal) = primary.type else { return Mesh([]) }
        
        let e0 = AdjacentEdge(primary: primary, lhs: secondary, rhs: secondary).mesh
        
        switch secondary.type {
            
        case .edge:
            
            guard case let .edge(c0) = secondary.type,
                  c0 == cardinal.opposite else { return Mesh([]) }
            
            let e1 = AdjacentEdge(primary: secondary, lhs: primary, rhs: primary).mesh
            
            return e0.union(e1)
            
        case .corner:
            
            guard case let .corner(ordinal) = secondary.type else { return Mesh([]) }
            
            let (o0, _) = cardinal.ordinals
            let (o1, _) = o0.ordinals
            
            guard ordinal == o0.opposite || ordinal == o1 else { return Mesh([]) }
            
            switch primary.style {
                
            case .concave:
                
                let e0 = AdjacentEdge(primary: primary, lhs: secondary, rhs: secondary).mesh
                
                return e0
                
            default:
                
                let empty = SocketConfig.init(material: .air, style: secondary.style, volume: secondary.volume, type: secondary.type)
                var e0lhs = secondary
                var e0rhs = empty
                var c0lhs = primary
                var c0rhs = empty
                let style: BiscuitStyle = primary.style == .convex ? .concave : .convex
                
                switch primary.style {
                    
                case .convex:
                    
                    if o0.opposite != ordinal {
                        
                        e0lhs = empty
                        e0rhs = secondary
                        
                        c0lhs = empty
                        c0rhs = primary
                    }
                    
                default:
                    
                    if o0.opposite != ordinal {
                        
                        c0lhs = empty
                        c0rhs = primary
                    }
                    else {
                        
                        e0lhs = empty
                        e0rhs = secondary
                    }
                }
                
                let config = SocketConfig(material: secondary.material, style: style, volume: secondary.volume, type: secondary.type)
                
                let e0 = AdjacentEdge(primary: primary, lhs: e0lhs, rhs: e0rhs).mesh
                let c0 = AdjacentCorner(primary: config, lhs: c0lhs, rhs: c0rhs).mesh
                
                return e0.union(c0)
            }
            
        default: return Mesh([])
        }
    }
}
