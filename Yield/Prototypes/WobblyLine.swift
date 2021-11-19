//
//  WobblyLine.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Euclid
import Meadow

struct WobblyLine {
    
    public let start: Position
    public let end: Position
    public let normal: Direction
    
    public let steps: Int
    public let variance: Double
    
    public let points: [Position]
    
    init(start: Position, end: Position, normal: Direction, steps: Int, variance: Double) {
        
        self.start = start
        self.end = end
        self.normal = normal
        self.steps = steps
        self.variance = variance
        
        let step = 1.0 / Double(steps)
        
        var vectors = [start]
        
        for index in 1...steps {
            
            let interpolator = Double(index) * step
            
            let stagger = (index % 2 != 0 ? normal * variance : .zero)
            
            vectors.append(start.lerp(end, interpolator) + stagger)
        }
        
        self.points = vectors
    }
}

extension WobblyLine {
    
    func polygons(color: Color) -> [Euclid.Polygon] {
     
        let ceiling = Distance(x: 0, y: Prototype.Constants.ceiling, z: 0)
        
        var polygons: [Euclid.Polygon] = []
        
        for index in 0..<(points.count - 1) {
            
            let v0 = points[index]
            let v1 = points[index + 1]
            let v2 = v1 + ceiling
            let v3 = v0 + ceiling
            
            let face = [v3, v2, v1, v0]
            let normal = face.normal()
            let uvs = UVs.corners.corners
            
            let vertices = face.indices.map { Vertex(face[$0], normal, uvs[$0], color) }
            
            guard let polygon = Polygon(vertices) else { continue }
            
            polygons.append(polygon)
        }
        
        return polygons
    }
}
