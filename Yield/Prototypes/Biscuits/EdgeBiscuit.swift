//
//  EdgeBiscuit.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Meadow

struct EdgeBiscuit {
    
    let cardinal: Cardinal
    
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
        
        let (o0, o1) = cardinal.ordinals
        let (o2, o3) = cardinal.opposite.ordinals
        let (c0, c1) = cardinal.cardinals
        
        let lv1 = corners[o0.corner]
        let lv2 = corners[o1.corner]
        let lv0 = corners[o3.corner].lerp(lv1, 0.5 + (inset ? Prototype.Constants.insetDepth : 0))
        let lv3 = corners[o2.corner].lerp(lv2, 0.5 + (inset ? Prototype.Constants.insetDepth : 0))
        
        let uv0 = lv0 + ceiling
        let uv1 = lv1 + ceiling
        let uv2 = lv2 + ceiling
        let uv3 = lv3 + ceiling
        
        let cc = [uv1, uv2, lv2, lv1]
        let c0c = [uv0, uv1, lv1, lv0]
        let c1c = [uv2, uv3, lv3, lv2]
        
        let ccv = cc.map { Vertex($0, cardinal.normal, nil, edgeColor) }
        let c0v = c0c.map { Vertex($0, c0.normal, nil, edgeColor) }
        let c1v = c1c.map { Vertex($0, c1.normal, nil, edgeColor) }
        
        guard let cp = Polygon(ccv),
              let c0p = Polygon(c0v),
              let c1p = Polygon(c1v) else { return [] }
        
        var lowerFace = [lv1, lv2]
        var edges = [cp, c0p, c1p]
        
        var lv4 = cardinal.normal * (inset ? Prototype.Constants.insetDepth : 0)
        
        if style == .rounded {
            
            lv4 += -cardinal.normal * 0.25
        }
        
        let n0 = style == .rounded ? -cardinal.normal : cardinal.normal
        
        let l0 = WobblyLine(start: lv4, end: lv0, normal: n0, steps: 4, variance: Prototype.Constants.insetDepth)
        let l1 = WobblyLine(start: lv3, end: lv4, normal: -cardinal.normal, steps: 4, variance: Prototype.Constants.insetDepth)
        
        lowerFace.append(contentsOf: l1.points + Array(l0.points.dropFirst()))
        edges.append(contentsOf: l0.polygons(color: edgeColor) + l1.polygons(color: edgeColor))
        
        let upperFace = lowerFace.reversed().map { $0 + ceiling }
        
        let lowerVertices = lowerFace.map { Vertex($0, -.up, nil, baseColor) }
        let upperVertices = upperFace.map { Vertex($0, .up, nil, apexColor) }
        
        guard let lowerPolygon = Polygon(lowerVertices),
              let upperPolygon = Polygon(upperVertices) else { return edges }
        
        return [lowerPolygon, upperPolygon] + edges
    }
}
