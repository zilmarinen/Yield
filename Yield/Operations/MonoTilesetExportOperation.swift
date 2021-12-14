//
//  MonoTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Harvest
import Meadow
import PeakOperation

class MonoTilesetExportOperation: ConcurrentOperation, ProducesResult {
    
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        var prototypes: [PrototypeTile] = []
        
        for material in SurfaceMaterial.solids {
            
            prototypes.append(contentsOf: edges(with: material))
            prototypes.append(contentsOf: grooves(with: material))
            prototypes.append(contentsOf: innerCorners(with: material))
            prototypes.append(contentsOf: outerCorners(with: material))
            prototypes.append(contentsOf: plateau(with: material))
        }
        
        let exportOperation = PrototypeTileExportOperation(type: .mono, prototypes: prototypes, tileCache: Tileset(), fileCache: [:])
        
        let group = DispatchGroup()
        
        group.enter()
        
        exportOperation.enqueue(on: internalQueue) { [weak self] result in
            
            guard let self = self else { return }
            
            self.output = result
            
            group.leave()
        }
        
        group.wait()
        
        finish()
    }
}

extension MonoTilesetExportOperation {
    
    typealias TileBuilder = ((_ m0: SurfaceMaterial, _ style: SurfaceStyle, _ volume: Volume) -> ([PrototypeTile]))
    
    private func tiles(with material: SurfaceMaterial, styles: [SurfaceStyle], builder: TileBuilder) -> [PrototypeTile] {
        
        return [Volume.crown, .mantle].flatMap { volume in
                
            styles.flatMap { style in
                
                builder(material, style, volume)
            }
        }
    }
    
    private func edges(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = SurfaceStyle.allCases
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            edges(with: .init(material: m0, style: style, volume: volume, type: .edge(.north)))
        }
    }
    
    private func grooves(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = SurfaceStyle.allCases
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            grooves(with: .init(material: m0, style: style, volume: volume, type: .corner(.northWest)))
        }
    }
    
    private func innerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
    
        let styles = [SurfaceStyle.concave, .convex]
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            innerCorners(with: .init(material: m0, style: style, volume: volume, type: .corner(.southWest)))
        }
    }
    
    private func outerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [SurfaceStyle.concave, .convex]
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            outerCorners(with: .init(material: m0, style: style, volume: volume, type: .corner(.northWest)))
        }
    }
    
    private func plateau(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [SurfaceStyle.straight]
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            plateau(with: .init(material: m0, style: style, volume: volume, type: .plateau))
        }
    }
}

extension MonoTilesetExportOperation {
    
    private func edges(with primary: SocketConfig) -> [PrototypeTile] {
        
        let volume = primary.volume == .mantle ? Volume.crown : Volume.mantle
        
        return [MonoEdge(config: primary),
                
                TriEdge(primary: primary,
                        secondary: primary.with(volume: volume, type: .corner(.southEast)),
                        tertiary: primary.empty(volume: volume, type: .corner(.southWest))),
                
                TriEdge(primary: primary,
                        secondary: primary.empty(volume: volume, type: .corner(.southEast)),
                        tertiary: primary.with(volume: volume, type: .corner(.southWest))),
                
                TriEdge(primary: primary,
                        secondary: primary.with(volume: volume, type: .corner(.southEast)),
                        tertiary: primary.with(volume: volume, type: .corner(.southWest)))]
    }
    
    private func grooves(with primary: SocketConfig) -> [PrototypeTile] {
        
        let volume = primary.volume == .mantle ? Volume.crown : Volume.mantle
        
        return [MonoGroove(config: primary),
        
                TriGroove(primary: primary,
                          secondary: primary.with(volume: volume, type: .corner(.northEast)),
                          tertiary: primary.empty(volume: volume, type: .corner(.southWest))),
        
                TriGroove(primary: primary,
                          secondary: primary.empty(volume: volume, type: .corner(.northEast)),
                          tertiary: primary.with(volume: volume, type: .corner(.southWest)))]
    }
    
    private func innerCorners(with primary: SocketConfig) -> [PrototypeTile] {
        
        let volume = primary.volume == .mantle ? Volume.crown : Volume.mantle
        
        return [MonoInnerCorner(config: primary),
        
                DuoInnerCorner(primary: primary,
                               secondary: primary.with(volume: volume, type: .corner(.southWest)))]
    }
    
    private func outerCorners(with primary: SocketConfig) -> [PrototypeTile] {
        
        let volume = primary.volume == .mantle ? Volume.crown : Volume.mantle
        
        return [MonoOuterCorner(config: primary),
        
                DuoOuterCorner(primary: primary,
                               secondary: primary.with(volume: volume, type: .corner(.northEast))),
                
                DuoOuterCorner(primary: primary,
                               secondary: primary.with(volume: volume, type: .corner(.southWest)))]
    }
    
    private func plateau(with primary: SocketConfig) -> [PrototypeTile] { [MonoPlateau(config: primary)] }
}
