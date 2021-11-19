//
//  EdgeBiscuit.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Meadow

struct EdgeBiscuit {
    
    let config: SocketConfig
    
    let insets: Insets
    
    var mesh: Mesh {
        
        guard case let .edge(cardinal) = config.type else { return Mesh([]) }
        
        switch config.style {
            
        case .concave:
            
            let (o0, o1) = cardinal.ordinals
            
            let surface = Surface(config: config).mesh
            
            let b0 = CornerBiscuit(config: .init(material: config.material, style: config.style, volume: config.volume, type: .corner(o0)), insets: insets.lhs).mesh
            let b1 = CornerBiscuit(config: .init(material: config.material, style: config.style, volume: config.volume, type: .corner(o1)), insets: insets.rhs).mesh
            
            return surface.intersect(b0).union(surface.intersect(b1))
            
        case .convex:
            
            let (o0, o1) = cardinal.opposite.ordinals
            
            let surface = Surface(config: config).mesh
            
            let b0 = CornerBiscuit(config: .init(material: config.material, style: .concave, volume: config.volume, type: .corner(o0)), insets: insets.lhs.opposite).mesh
            let b1 = CornerBiscuit(config: .init(material: config.material, style: .concave, volume: config.volume, type: .corner(o1)), insets: insets.rhs.opposite).mesh
            
            return surface.subtract(b0).subtract(b1)
            
        case .straight:
            
            let apexColor = config.material.apexColor(volume: config.volume)
            let edgeColor = config.material.edgeColor(volume: config.volume)
            let baseColor = config.material.baseColor(volume: config.volume)
            
            let grid = SurfaceGrid()
            
            let ceiling = Distance(x: 0, y: Prototype.Constants.ceiling, z: 0)
            
            let (o0, o1) = cardinal.ordinals
            let (c0, _) = cardinal.cardinals
            
            let lv1 = grid.corner(ordinal: o0)
            let lv2 = grid.corner(ordinal: o1)
            let lv0 = grid.edge(cardinal: c0, ordinal: o0, inset: insets.left)
            let lv3 = grid.edge(cardinal: c0.opposite, ordinal: o1, inset: insets.right)
            let lv4 = grid.edge(cardinal: c0.opposite, ordinal: o0, inset: insets.center)
            
            let e0 = StraightLine(start: lv0, end: lv1)
            let e1 = StraightLine(start: lv2, end: lv3)
            let e2 = StraightLine(start: lv1, end: lv2)
            
            let l0 = WobblyLine(start: lv4, end: lv0, normal: cardinal.direction, steps: 4, variance: Prototype.Constants.insetDepth)
            let l1 = WobblyLine(start: lv3, end: lv4, normal: -cardinal.direction, steps: 4, variance: Prototype.Constants.insetDepth)
            
            guard let e0p = e0.polygon(color: edgeColor),
                  let e1p = e1.polygon(color: edgeColor),
                  let e2p = e2.polygon(color: edgeColor) else { return Mesh([]) }
            
            let lowerFace = e2.points + l1.points + Array(l0.points.dropFirst())
            let upperFace = lowerFace.reversed().map { $0 + ceiling }
            
            let edges = [e0p, e1p, e2p] + l0.polygons(color: edgeColor) + l1.polygons(color: edgeColor)
                    
            let lowerVertices = lowerFace.indices.map { Vertex(lowerFace[$0], -.y, lowerFace[$0], baseColor) }
            let upperVertices = upperFace.indices.map { Vertex(upperFace[$0], .y, upperFace[$0], apexColor) }
            
            guard let lowerPolygon = Polygon(lowerVertices),
                  let upperPolygon = Polygon(upperVertices) else { return Mesh(edges) }
            
            return Mesh([lowerPolygon, upperPolygon] + edges)
        }
    }
}
