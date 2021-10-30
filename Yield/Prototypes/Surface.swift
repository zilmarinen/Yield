//
//  Surface.swift
//
//  Created by Zack Brown on 27/10/2021.
//

import Euclid
import Meadow

struct Surface {
    
    let material: SurfaceMaterial
    let volume: Volume
    
    var polygons: [Euclid.Polygon] {
        
        guard volume != .empty else { return [] }
        
        let floor = Vector(x: 0, y: (volume == .crown ? Prototype.Constants.throneHeight : 0), z: 0)
        let ceiling = Vector(x: 0, y: (volume == .crown ? Prototype.Constants.throneHeight + Prototype.Constants.crownHeight :
                                        (volume == .throne ? Prototype.Constants.throneHeight : Prototype.Constants.ceiling)), z: 0)
        
        let lowerCorners = Ordinal.Coordinates.map { (Vector(coordinate: $0) * World.Constants.volumeSize) + floor }
        let upperCorners = Ordinal.Coordinates.map { (Vector(coordinate: $0) * World.Constants.volumeSize) + ceiling }
        
        let apexColor = volume == .crown ? material.colors.primary : material.colors.tertiary
        let edgeColor = volume == .crown ? material.colors.secondary : material.colors.quaterniary
        let baseColor = volume == .crown ? material.colors.tertiary : material.colors.quaterniary
        
        var polygons: [Euclid.Polygon] = []
        
        for cardinal in Cardinal.allCases {
            
            let (o0, o1) = cardinal.ordinals
            let normal = cardinal.normal
            
            let corners = [upperCorners[o0.corner], upperCorners[o1.corner], lowerCorners[o1.corner], lowerCorners[o0.corner]]
            
            let vertices = corners.map { Vertex($0, normal, .zero, edgeColor) }
            
            guard let polygon = Polygon(vertices) else { continue }
            
            polygons.append(polygon)
        }
        
        let lowerVertices = lowerCorners.map { Vertex($0, -.up, .zero, baseColor) }
        let upperVertices = upperCorners.reversed().map { Vertex($0, .up, .zero, apexColor) }
        
        guard let lowerPolygon = Polygon(lowerVertices),
              let upperPolygon = Polygon(upperVertices) else { return polygons }
        
        return polygons + [lowerPolygon, upperPolygon]
    }
}
