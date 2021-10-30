//
//  InnerCornerBiscuit.swift
//
//  Created by Zack Brown on 29/10/2021.
//

import Euclid
import Meadow

struct InnerCornerBiscuit {
    
    let ordinal: Ordinal
    
    let material: SurfaceMaterial
    let volume: Volume
    let style: BiscuitStyle
    
    let inset: Bool
    
    var polygons: [Euclid.Polygon] {
        
        let apexColor = volume == .crown ? material.colors.primary : material.colors.tertiary
        let edgeColor = volume == .crown ? material.colors.secondary : material.colors.quaterniary
        let baseColor = volume == .crown ? material.colors.tertiary : material.colors.quaterniary
        
        let corners = Ordinal.Coordinates.map { Vector(coordinate: $0) * World.Constants.volumeSize }
        let ceiling = Vector(x: 0, y: 1, z: 0)
        
        let (c0, c1) = ordinal.cardinals
        let (o0, o1) = ordinal.ordinals
        
        let lv1 = corners[ordinal.corner]
        var lv0 = Vector.zero
        var lv2 = Vector.zero
        
        switch style {
        case .rounded:
         
            lv0 = corners[o0.corner].lerp(lv1, 0.5 - (inset ? Prototype.Constants.insetDepth : 0))
            lv2 = lv1.lerp(corners[o1.corner], 0.5 + (inset ? Prototype.Constants.insetDepth : 0))
            
        case .squared:
            
            lv0 = corners[o0.corner].lerp(lv1, 0.5 - (inset ? Prototype.Constants.insetDepth : 0))
            lv2 = lv1.lerp(corners[o1.corner], 0.5 + (inset ? Prototype.Constants.insetDepth : 0))
        }
        
        let uv0 = lv0 + ceiling
        let uv1 = lv1 + ceiling
        let uv2 = lv2 + ceiling
        
        let c0c = [uv0, uv1, lv1, lv0]
        let c1c = [uv1, uv2, lv2, lv1]
        
        let c0v = c0c.map { Vertex($0, c0.normal, nil, edgeColor) }
        let c1v = c1c.map { Vertex($0, c1.normal, nil, edgeColor) }
        
        guard let c0p = Polygon(c0v),
              let c1p = Polygon(c1v) else { return [] }
        
        var lowerFace = [lv1]
        var edges = [c0p, c1p]
        
        switch style {
        case .rounded:
            
            let normal = -(c0.normal + c1.normal)
            
            let line = WobblyLine(start: lv2, end: lv0, normal: normal, steps: 4, variance: Prototype.Constants.insetDepth)
            
            lowerFace.append(contentsOf: line.points)
            
            edges.append(contentsOf: line.polygons(color: edgeColor))
            
        case .squared:
            
            let lv3 = -c1.normal * (inset ? Prototype.Constants.insetDepth : 0)
            let lv4 = -c0.normal * (inset ? Prototype.Constants.insetDepth : 0)
            
            let lc0 = WobblyLine(start: lv2, end: lv4, normal: c0.opposite.normal, steps: 4, variance: Prototype.Constants.insetDepth)
            let lc1 = WobblyLine(start: lv3, end: lv0, normal: c1.normal, steps: 4, variance: Prototype.Constants.insetDepth)
            
            if inset {
                
                lowerFace.append(contentsOf: lc0.points + lc1.points.dropFirst())
                
                edges.append(contentsOf: lc0.polygons(color: edgeColor) + lc1.polygons(color: edgeColor))
                
                guard let v0 = lc0.points.last,
                      let v1 = lc1.points.first else { return edges }
                
                let face = [v0 + ceiling, v1 + ceiling, v1, v0]
                
                let normal = face.normal()
                
                let vertices = face.map { Vertex($0, normal, nil, edgeColor) }
                
                guard let polygon = Polygon(vertices) else { return edges }
                
                edges.append(polygon)
            }
            else {
                
                lowerFace = [lv1] + lc0.points + lc1.points.dropFirst()
                
                edges.append(contentsOf: lc0.polygons(color: edgeColor))
                edges.append(contentsOf: lc1.polygons(color: edgeColor))
            }
        }
        
        let upperFace = lowerFace.reversed().map { $0 + ceiling }
        
        let lowerVertices = lowerFace.map { Vertex($0, -.up, nil, baseColor) }
        let upperVertices = upperFace.map { Vertex($0, .up, nil, apexColor) }
        
        guard let lowerPolygon = Polygon(lowerVertices),
              let upperPolygon = Polygon(upperVertices) else { return [] }
        
        return [lowerPolygon, upperPolygon] + edges
    }
}
