//
//  CornerBiscuit.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Meadow

struct CornerBiscuit {
    
    let config: SocketConfig
    
    let insets: Insets
    
    var mesh: Mesh {
        
        guard case let .corner(ordinal) = config.type else { return Mesh([]) }
        
        let apexColor = config.material.apexColor(volume: config.volume)
        let edgeColor = config.material.edgeColor(volume: config.volume)
        let baseColor = config.material.baseColor(volume: config.volume)
        
        let grid = SurfaceGrid()
        
        let ceiling = Distance(x: 0, y: 1, z: 0)
        
        let (c0, c1) = ordinal.cardinals
        
        let lv1 = grid.corner(ordinal: ordinal)
        let lv0 = grid.edge(cardinal: c0, ordinal: ordinal, inset: insets.left)
        let lv2 = grid.edge(cardinal: c1, ordinal: ordinal, inset: insets.right)
        let lv3 = grid.edge(cardinal: c1.opposite, ordinal: ordinal, inset: insets.right)
        let lv4 = grid.edge(cardinal: c0.opposite, ordinal: ordinal, inset: insets.left)
        
        var lowerFace = [lv1]
        var edges: [Euclid.Polygon] = []
        
        switch config.style {
            
        case .convex:
            
            let l0 = WobblyLine(start: lv2, end: lv3, normal: c0.opposite.direction, steps: 4, variance: Prototype.Constants.insetDepth)
            let l1 = WobblyLine(start: lv4, end: lv0, normal: c1.direction, steps: 4, variance: Prototype.Constants.insetDepth)
            
            switch (insets.left, insets.right) {
                
            case (.inner, .inner),
                (.inner, .none),
                (.none, .inner):
                
                guard let lv5 = l0.points.dropLast().last,
                      let lv6 = l1.points.dropFirst().first else { break }
                
                let lv7 = grid.inner(corner: ordinal)
                
                let l2 = StraightLine(start: lv5, end: lv7)
                let l3 = StraightLine(start: lv7, end: lv6)
                
                guard let e2p = l2.polygon(color: edgeColor),
                      let e3p = l3.polygon(color: edgeColor) else { break }
                
                lowerFace.append(contentsOf: l0.points.dropLast() + [lv7] + l1.points.dropFirst())
                
                edges.append(contentsOf: [e2p, e3p] + l0.polygons(color: edgeColor).dropLast() + l1.polygons(color: edgeColor).dropFirst())
                
            case (.none, .none):
                
                lowerFace.append(contentsOf: l0.points + l1.points.dropFirst())
                
                edges.append(contentsOf: l0.polygons(color: edgeColor) + l1.polygons(color: edgeColor))
                
            default:
                
                let l2 = StraightLine(start: l0.end, end: l1.start)
                
                guard let e2p = l2.polygon(color: edgeColor) else { break }
                
                lowerFace.append(contentsOf: l0.points + l1.points)
                
                edges.append(contentsOf: [e2p] + l0.polygons(color: edgeColor) + l1.polygons(color: edgeColor))
            }
            
        default:
            
            let normal = -Direction.mean(c0.direction, c1.direction)
            
            let line = WobblyLine(start: lv2, end: lv0, normal: normal, steps: 4, variance: Prototype.Constants.insetDepth)
            
            lowerFace.append(contentsOf: line.points)
            
            edges.append(contentsOf: line.polygons(color: edgeColor))
        }
        
        let e0 = StraightLine(start: lv0, end: lv1)
        let e1 = StraightLine(start: lv1, end: lv2)
        
        let upperFace = lowerFace.reversed().map { $0 + ceiling }
        
        let lowerVertices = lowerFace.map { Vertex($0, -.y, nil, baseColor) }
        let upperVertices = upperFace.map { Vertex($0, .y, nil, apexColor) }
        
        guard let e0p = e0.polygon(color: edgeColor),
              let e1p = e1.polygon(color: edgeColor),
              let lowerPolygon = Polygon(lowerVertices),
              let upperPolygon = Polygon(upperVertices) else { return Mesh(edges) }
        
        return Mesh([lowerPolygon, upperPolygon] + edges + [e0p, e1p])
    }
}
