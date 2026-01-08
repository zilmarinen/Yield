//
//  AssetCache.swift
//
//  Created by Zack Brown on 05/01/2026.
//

import Euclid
import Foundation

@MainActor
public final class AssetCache {
    
    public static let shared = AssetCache()
    
    internal var meshes: [Asset : Mesh] = [:]
}

extension AssetCache {
    
    public func load(asset: Asset) throws -> Mesh {
        
        if let mesh = meshes[asset] {
            
            return mesh
        }
        
        guard let path = Bundle.main.path(forResource: asset.id,
                                          ofType: "mesh") else { throw CocoaError(.fileNoSuchFile) }
        
        return .empty
    }
}
