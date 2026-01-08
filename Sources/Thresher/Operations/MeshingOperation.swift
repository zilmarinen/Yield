//
//  MeshingOperation.swift
//
//  Created by Zack Brown on 07/01/2026.
//

import Euclid
import Foundation
import PeakOperation
import Yield

internal class MeshingOperation: AssetCacheOperation,
                                 @unchecked Sendable {
    
    internal let category: Asset.Category
    
    internal init(category: Asset.Category) {
        
        self.category = category
        
        super.init()
        
        self.name = category.id
    }
    
    internal override func execute() {
        
        print("- Meshing \(category.id) Assets")
    }
    
    internal override func finish() {
        
        super.finish()
        
        print(" - Finished Generating \(category.id) Meshes")
        
        guard let startDate,
              let finishDate else { return }
        
        print(String(format: " - %.2f seconds", finishDate.timeIntervalSince(startDate)))
    }
}

extension MeshingOperation {
    
    internal func fileWrapper(for asset: Asset,
                              mesh: Mesh) throws -> FileWrapper {
        
        let data = Contents.Data.init(filename: asset.id + .obj)
        
        let contents = Contents.init(info: .default,
                                     data: [data])
        
        let encoder = JSONEncoder.default
        
        guard let objData = mesh.objString().data(using: .utf8) else { throw CocoaError(.fileWriteUnsupportedScheme) }
        
        let jsonData = try encoder.encode(contents)
        
        let objWrapper = FileWrapper(regularFileWithContents: objData)
        let jsonWrapper = FileWrapper(regularFileWithContents: jsonData)
        
        let files = [asset.id + .obj : objWrapper,
                     .contents : jsonWrapper]
        
        return FileWrapper(directoryWithFileWrappers: files)
    }
}
