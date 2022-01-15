//
//  EdgeBiscuit.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Harvest
import Meadow

struct EdgeBiscuit {
    
    let shape: SurfaceShape
    let material: SurfaceMaterial
    let volume: SurfaceVolume
    let cardinal: Cardinal
    
    var mesh: Mesh {
        
        switch shape {
            
        case .concave:
            
            let (o0, o1) = cardinal.ordinals
            
            let surface = Surface(material: material, volume: volume).mesh
            
            let b0 = CornerBiscuit(shape: shape, material: material, volume: volume, ordinal: o0, inset: material.inset(volume: volume)).mesh
            let b1 = CornerBiscuit(shape: shape, material: material, volume: volume, ordinal: o1, inset: material.inset(volume: volume)).mesh
            
            return surface.intersect(b0).union(surface.intersect(b1))
            
        case .convex:
            
            let (o0, o1) = cardinal.opposite.ordinals
            
            let surface = Surface(material: material, volume: volume).mesh
            
            let b0 = CornerBiscuit(shape: .concave, material: material, volume: volume, ordinal: o0, inset: material.inset(volume: volume).opposite).mesh
            let b1 = CornerBiscuit(shape: .concave, material: material, volume: volume, ordinal: o1, inset: material.inset(volume: volume).opposite).mesh
            
            return surface.subtract(b0).subtract(b1)
            
        case .straight:
            
            let apexColor = material.apexColor(volume: volume)
            let edgeColor = material.edgeColor(volume: volume)
            let baseColor = material.baseColor(volume: volume)
            
            let grid = SurfaceGrid()
            
            let ceiling = Vector(x: 0, y: Prototype.Constants.ceiling, z: 0)
            
            let inset = material.inset(volume: volume)
            
            let (o0, o1) = cardinal.ordinals
            let (c0, _) = cardinal.cardinals
            
            let lv1 = grid.corner(ordinal: o0)
            let lv2 = grid.corner(ordinal: o1)
            let lv0 = grid.edge(cardinal: c0, ordinal: o0, inset: inset)
            let lv3 = grid.edge(cardinal: c0.opposite, ordinal: o1, inset: inset)
            let lv4 = grid.edge(cardinal: c0.opposite, ordinal: o0, inset: inset)
            
            let e0 = StraightLine(start: lv0, end: lv1)
            let e1 = StraightLine(start: lv2, end: lv3)
            let e2 = StraightLine(start: lv1, end: lv2)
            
            let l0 = WobblyLine(start: lv4, end: lv0, normal: cardinal.direction, steps: Prototype.Constants.edgeSteps, variance: Prototype.Constants.insetDepth)
            let l1 = WobblyLine(start: lv3, end: lv4, normal: -cardinal.direction, steps: Prototype.Constants.edgeSteps, variance: Prototype.Constants.insetDepth)
            
            guard let e0p = e0.polygon(color: edgeColor),
                  let e1p = e1.polygon(color: edgeColor),
                  let e2p = e2.polygon(color: edgeColor) else { return Mesh([]) }
            
            let lowerFace = e2.points + l1.points + Array(l0.points.dropFirst())
            let upperFace = lowerFace.reversed().map { $0 + ceiling }
            
            let edges = [e0p, e1p, e2p] + l0.polygons(color: edgeColor) + l1.polygons(color: edgeColor)
                    
            let lowerVertices = lowerFace.indices.map { Vertex(lowerFace[$0], Vector(x: 0, y: -1, z: 0), lowerFace[$0], baseColor) }
            let upperVertices = upperFace.indices.map { Vertex(upperFace[$0], Vector(x: 0, y: 1, z: 0), upperFace[$0], apexColor) }
            
            guard let lowerPolygon = Polygon(lowerVertices),
                  let upperPolygon = Polygon(upperVertices) else { return Mesh(edges) }
            
            return Mesh([lowerPolygon, upperPolygon] + edges)
        }
    }
}
