//
//  TriTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Meadow
import PeakOperation

class TriTilesetExportOperation: ConcurrentOperation, ConsumesResult, ProducesResult {
    
    public var input: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        do {
            
            let (tileset, wrappers) = try input.get()
            
            var prototypes: [PrototypeTile] = []
            
            for material in SurfaceMaterial.solids {
                
                prototypes.append(contentsOf: edges(with: material))
                prototypes.append(contentsOf: grooves(with: material))
            }
            
            let exportOperation = PrototypeTileExportOperation(type: .tri, prototypes: prototypes, tileCache: tileset, fileCache: wrappers)
            
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

extension TriTilesetExportOperation {
    
    typealias TileBuilder = ((_ m0: SurfaceMaterial,
                              _ m1: SurfaceMaterial,
                              _ m2: SurfaceMaterial,
                              _ style: BiscuitStyle,
                              _ volume: Volume) -> ([PrototypeTile]))
    
    private func tiles(with material: SurfaceMaterial, styles: [BiscuitStyle], builder: TileBuilder) -> [PrototypeTile] {
        
        let secondaryMaterials = material.remainder
        
        var tiles: [PrototypeTile] = []
        
        [Volume.crown, .mantle].forEach { volume in
            
            styles.forEach { style in
            
                secondaryMaterials.forEach { secondary in
                    
                    let tertiaryMaterials = secondaryMaterials.filter { $0 != secondary }
                    
                    tertiaryMaterials.forEach { tertiary in
                    
                        tiles.append(contentsOf: builder(material, secondary, tertiary, style, volume))
                    }
                }
            }
        }
        
        return tiles
    }
    
    private func edges(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [BiscuitStyle.concave, .convex]
        
        return tiles(with: material, styles: styles) { m0, m1, m2, style, volume in
            
            return edges(with: .init(material: m0, style: style, volume: volume, type: .edge(.north)),
                  secondary: .init(material: m1, style: style, volume: volume, type: .corner(.southEast)),
                  tertiary: .init(material: m2, style: style, volume: volume, type: .corner(.southWest)))
        }
    }
    
    private func grooves(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = BiscuitStyle.allCases
        
        return tiles(with: material, styles: styles) { m0, m1, m2, style, volume in
            
            grooves(with: .init(material: m0, style: style, volume: volume, type: .corner(.northWest)),
                    secondary: .init(material: m1, style: style, volume: volume, type: .corner(.northEast)),
                    tertiary: .init(material: m2, style: style, volume: volume, type: .corner(.southWest)))
        }
    }
}

extension TriTilesetExportOperation {
    
    private func edges(with primary: SocketConfig, secondary: SocketConfig, tertiary: SocketConfig) -> [PrototypeTile] { [TriEdge(primary: primary,
                                                                                                                                  secondary: secondary.with(volume: .crown),
                                                                                                                                  tertiary: tertiary.with(volume: .crown)),
    
                                                                                                                          TriEdge(primary: primary,
                                                                                                                                  secondary: secondary.with(volume: .mantle),
                                                                                                                                  tertiary: tertiary.with(volume: .crown)),
    
                                                                                                                          TriEdge(primary: primary,
                                                                                                                                  secondary: secondary.with(volume: .crown),
                                                                                                                                  tertiary: tertiary.with(volume: .mantle))] }
    
    private func grooves(with primary: SocketConfig, secondary: SocketConfig, tertiary: SocketConfig) -> [PrototypeTile] { [TriGroove(primary: primary,
                                                                                                                                      secondary: secondary.with(volume: .crown, type: .corner(.northEast)),
                                                                                                                                      tertiary: tertiary.with(volume: .crown, type: .corner(.southWest))),
                                                                                                                            
                                                                                                                            TriGroove(primary: primary,
                                                                                                                                      secondary: secondary.with(volume: .mantle, type: .corner(.northEast)),
                                                                                                                                      tertiary: tertiary.with(volume: .crown, type: .corner(.southWest))),

                                                                                                                            TriGroove(primary: primary,
                                                                                                                                      secondary: secondary.with(volume: .crown, type: .corner(.northEast)),
                                                                                                                                      tertiary: tertiary.with(volume: .mantle, type: .corner(.southWest))),
                                                                                                                            
                                                                                                                            TriGroove(primary: primary,
                                                                                                                                      secondary: secondary.with(volume: .mantle, type: .corner(.northEast)),
                                                                                                                                      tertiary: tertiary.with(volume: .mantle, type: .corner(.southWest)))] }
}
