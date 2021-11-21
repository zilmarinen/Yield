//
//  DuoTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Harvest
import Meadow
import PeakOperation

class DuoTilesetExportOperation: ConcurrentOperation, ConsumesResult, ProducesResult {
    
    public var input: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        do {
            
            let (tileset, wrappers) = try input.get()
            
            var prototypes: [PrototypeTile] = []
            
            for material in SurfaceMaterial.solids {
                
                prototypes.append(contentsOf: grooves(with: material))
                prototypes.append(contentsOf: innerCorners(with: material))
                prototypes.append(contentsOf: outerCorners(with: material))
                prototypes.append(contentsOf: plateau(with: material))
            }
            
            let exportOperation = PrototypeTileExportOperation(type: .duo, prototypes: prototypes, tileCache: tileset, fileCache: wrappers)
            
            let group = DispatchGroup()
            
            group.enter()
            
            exportOperation.enqueue(on: internalQueue) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .failure(let error): self.output = .failure(error)
                case .success(let output): self.output = .success(output)
                }
                
                group.leave()
            }
            
            group.wait()
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}

extension DuoTilesetExportOperation {
    
    typealias TileBuilder = ((_ m0: SurfaceMaterial,
                              _ m1: SurfaceMaterial,
                              _ style: SurfaceStyle,
                              _ volume: Volume) -> ([PrototypeTile]))
    
    private func tiles(with material: SurfaceMaterial, styles: [SurfaceStyle], builder: TileBuilder) -> [PrototypeTile] {
        
        let materials = material.remainder
        
        return [Volume.crown, .mantle].flatMap { volume in
            
            styles.flatMap { style in
            
                materials.flatMap { secondary in
                    
                    builder(material, secondary, style, volume)
                }
            }
        }
    }
    
    private func grooves(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = SurfaceStyle.allCases
        
        return tiles(with: material, styles: styles) { m0, m1, style, volume in
            
            grooves(with: .init(material: m0, style: style, volume: volume, type: .corner(.northWest)),
                    secondary: .init(material: m1, style: style, volume: volume, type: .corner(.northEast)))
        }
    }
    
    private func innerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
    
        let styles = [SurfaceStyle.concave, SurfaceStyle.convex]
        
        return tiles(with: material, styles: styles) { m0, m1, style, volume in
            
            innerCorners(with: .init(material: m0, style: style, volume: volume, type: .corner(.southWest)),
                         secondary: .init(material: m1, style: style, volume: volume, type: .corner(.southWest)))
        }
    }
    
    private func outerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [SurfaceStyle.concave, SurfaceStyle.convex]
        
        return tiles(with: material, styles: styles) { m0, m1, style, volume in
            
            outerCorners(with: .init(material: m0, style: style, volume: volume, type: .corner(.northWest)),
                         secondary: .init(material: m1, style: style, volume: volume, type: .corner(.northEast)))
        }
    }
    
    private func plateau(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = SurfaceStyle.allCases
        
        return tiles(with: material, styles: styles) { m0, m1, style, volume in
            
            plateau(with: .init(material: m0, style: style, volume: volume, type: .edge(.north)),
                    secondary: .init(material: m1, style: style, volume: volume, type: .edge(.south)))
        }
    }
}

extension DuoTilesetExportOperation {
    
    private func grooves(with primary: SocketConfig, secondary: SocketConfig) -> [PrototypeTile] { [TriGroove(primary: primary,
                                                                                                              secondary: secondary.with(volume: .crown, type: .corner(.northEast)),
                                                                                                              tertiary: secondary.empty(volume: .crown, type: .corner(.southWest))),
                                                                                                    
                                                                                                    TriGroove(primary: primary,
                                                                                                              secondary: secondary.empty(volume: .crown, type: .corner(.northEast)),
                                                                                                              tertiary: secondary.with(volume: .crown, type: .corner(.southWest))),

                                                                                                    TriGroove(primary: primary,
                                                                                                              secondary: secondary.with(volume: .mantle, type: .corner(.northEast)),
                                                                                                              tertiary: secondary.empty(volume: .mantle, type: .corner(.southWest))),
                                                                                                    
                                                                                                    TriGroove(primary: primary,
                                                                                                              secondary: secondary.empty(volume: .mantle, type: .corner(.northEast)),
                                                                                                              tertiary: secondary.with(volume: .mantle, type: .corner(.southWest)))] }
    
    private func innerCorners(with primary: SocketConfig, secondary: SocketConfig) -> [PrototypeTile] { [DuoInnerCorner(primary: primary,
                                                                                                                        secondary: secondary.with(volume: .crown)),
                                                                                                         
                                                                                                         DuoInnerCorner(primary: primary,
                                                                                                                        secondary: secondary.with(volume: .mantle))] }
    
    private func outerCorners(with primary: SocketConfig, secondary: SocketConfig) -> [PrototypeTile] { [DuoOuterCorner(primary: primary,
                                                                                                                        secondary: secondary.with(volume: .crown)),
                                                                                                         
                                                                                                         DuoOuterCorner(primary: primary,
                                                                                                                        secondary: secondary.with(volume: .mantle))] }
    
    private func plateau(with primary: SocketConfig, secondary: SocketConfig) -> [PrototypeTile] { [DuoPlateau(primary: primary,
                                                                                                               secondary: secondary.with(volume: .crown)),
    
                                                                                                    DuoPlateau(primary: primary,
                                                                                                               secondary: secondary.with(volume: .mantle))] }
}
