//
//  AssetCache.swift
//
//  Created by Zack Brown on 05/01/2026.
//

import Foundation

@MainActor
public final class AssetCache {
    
    public static let shared = AssetCache()
    
    internal init() {
        
        //
    }
}

extension AssetCache {
    
    public func load(asset: Asset) throws {
        
        guard let path = Bundle.main.path(forResource: asset.id,
                                          ofType: "mesh") else { throw CocoaError(.fileNoSuchFile) }
        
        //
    }
}
