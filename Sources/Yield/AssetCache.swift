//
//  AssetCache.swift
//
//  Created by Zack Brown on 05/01/2026.
//

import AppKit
import Euclid
import Foundation
import RealityKit

@MainActor
public final class AssetCache {
    
    public static let shared = AssetCache()
    
    internal var meshes: [Asset : Mesh] = [:]
    internal var resources: [Asset : MeshResource] = [:]
}

extension AssetCache {
    
    public func load(mesh asset: Asset) throws -> Mesh {
        
        if let mesh = meshes[asset] {
            
            return mesh
        }
        
        guard let handle = NSDataAsset(name: asset.id,
                                       bundle: .module) else { throw CocoaError(.fileNoSuchFile) }
        
        guard let obj = String(data: handle.data,
                               encoding: .utf8) else { throw CocoaError(.fileReadUnknownStringEncoding) }
        
        guard let mesh = Mesh(objString: obj) else { throw CocoaError(.fileReadUnsupportedScheme) }
        
        meshes[asset] = mesh
        
        return mesh
    }
    
    public func load(resource asset: Asset) throws -> MeshResource {
        
        if let resource = resources[asset] {
            
            return resource
        }
        
        let mesh = try load(mesh: asset)
        
        let resource = MeshResource(mesh: mesh)
        
        resources[asset] = resource
        
        return resource
    }
}
