//
//  TetraTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Harvest
import Meadow
import PeakOperation

class TetraTilesetExportOperation: ConcurrentOperation, ConsumesResult, ProducesResult {
    
    public var input: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        do {
            
            let (tileset, wrappers) = try input.get()
            
            var prototypes: [PrototypeTile] = []
            
            for material in SurfaceMaterial.solids {
                
                prototypes.append(contentsOf: plateau(with: material))
            }
            
            let exportOperation = PrototypeTileExportOperation(type: .tetra, prototypes: prototypes, tileCache: tileset, fileCache: wrappers)
            
            let group = DispatchGroup()
            
            group.enter()
            
            exportOperation.enqueue(on: internalQueue) { [weak self] result in
                
                guard let self = self else { return }
                
                self.output = result
                
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

extension TetraTilesetExportOperation {
    
    typealias TileBuilder = ((_ m0: SurfaceMaterial,
                              _ m1: SurfaceMaterial,
                              _ m2: SurfaceMaterial,
                              _ m3: SurfaceMaterial,
                              _ style: SurfaceStyle,
                              _ volume: Volume) -> ([PrototypeTile]))
    
    private func tiles(with material: SurfaceMaterial, styles: [SurfaceStyle], builder: TileBuilder) -> [PrototypeTile] {
        
        let secondaryMaterials = material.remainder
        
        var tiles: [PrototypeTile] = []
        
        [Volume.crown, .mantle].forEach { volume in
            
            styles.forEach { style in
            
                secondaryMaterials.forEach { secondary in
                    
                    let tertiaryMaterials = secondaryMaterials.filter { $0 != secondary }
                    
                    tertiaryMaterials.forEach { tertiary in
                        
                        let quaternaryMaterials = secondaryMaterials.filter { $0 != secondary && $0 != tertiary }
                        
                        quaternaryMaterials.forEach { quaternary in
                    
                            tiles.append(contentsOf: builder(material, secondary, tertiary, quaternary, style, volume))
                        }
                    }
                }
            }
        }
        
        return tiles
    }
    
    private func plateau(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [SurfaceStyle.concave, .convex]
        
        return tiles(with: material, styles: styles) { m0, m1, m2, m3, style, volume in
            
            plateau(with: .init(material: m0, style: style, volume: volume, type: .corner(.northWest)),
                    secondary: .init(material: m1, style: style, volume: volume, type: .corner(.northEast)),
                    tertiary: .init(material: m2, style: style, volume: volume, type: .corner(.southEast)),
                    quaternary: .init(material: m3, style: style, volume: volume, type: .corner(.southWest)))
        }
    }
}

extension TetraTilesetExportOperation {
    
    private func plateau(with primary: SocketConfig, secondary: SocketConfig, tertiary: SocketConfig, quaternary: SocketConfig) -> [PrototypeTile] { [TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .crown),
                                                                                                                                                                   tertiary: tertiary.with(volume: .crown),
                                                                                                                                                                   quaternary: quaternary.with(volume: .crown)),
    
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .mantle),
                                                                                                                                                                   tertiary: tertiary.with(volume: .crown),
                                                                                                                                                                   quaternary: quaternary.with(volume: .crown)),
                                                                                                                                                      
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .mantle),
                                                                                                                                                                   tertiary: tertiary.with(volume: .mantle),
                                                                                                                                                                   quaternary: quaternary.with(volume: .crown)),
                                                                                                                                                      
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .mantle),
                                                                                                                                                                   tertiary: tertiary.with(volume: .crown),
                                                                                                                                                                   quaternary: quaternary.with(volume: .mantle)),
                                                                                                                                                      
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .crown),
                                                                                                                                                                   tertiary: tertiary.with(volume: .mantle),
                                                                                                                                                                   quaternary: quaternary.with(volume: .mantle))] }
}

