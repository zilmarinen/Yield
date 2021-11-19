//
//  Surface.swift
//
//  Created by Zack Brown on 27/10/2021.
//

import Euclid
import Meadow

struct Surface {
    
    let config: SocketConfig
    
    var mesh: Mesh {
        
        guard config.volume != .empty else { return Mesh([]) }
        
        let floor = Distance(x: 0, y: (config.volume == .crown ? Prototype.Constants.throneHeight : 0), z: 0)
        let ceiling = Distance(x: 0, y: (config.volume == .crown ? Prototype.Constants.throneHeight + Prototype.Constants.crownHeight :
                                        (config.volume == .throne ? Prototype.Constants.throneHeight : Prototype.Constants.ceiling)), z: 0)
        
        let lowerCorners = Ordinal.corners.map { $0 + floor }
        let upperCorners = Ordinal.corners.map { $0 + ceiling }
        
        let apexColor = config.material.apexColor(volume: config.volume)
        let edgeColor = config.material.edgeColor(volume: config.volume)
        let baseColor = config.material.baseColor(volume: config.volume)
        
        let uvs = UVs.corners.corners
        
        var polygons: [Euclid.Polygon] = []
        
        for cardinal in Cardinal.allCases {
            
            let (o0, o1) = cardinal.ordinals
            
            let corners = [upperCorners[o0.corner], upperCorners[o1.corner], lowerCorners[o1.corner], lowerCorners[o0.corner]]
            
            let vertices = corners.indices.map { Vertex(corners[$0], cardinal.direction, uvs[$0], edgeColor) }
            
            guard let polygon = Polygon(vertices) else { continue }
            
            polygons.append(polygon)
        }
        
        let lowerVertices = lowerCorners.indices.map { Vertex(lowerCorners[$0], -.y, uvs[$0], baseColor) }
        let upperVertices = upperCorners.indices.reversed().map { Vertex(upperCorners[$0], .y, uvs[$0], apexColor) }
        
        guard let lowerPolygon = Polygon(lowerVertices),
              let upperPolygon = Polygon(upperVertices) else { return Mesh(polygons) }
        
        return Mesh(polygons + [lowerPolygon, upperPolygon])
    }
}
