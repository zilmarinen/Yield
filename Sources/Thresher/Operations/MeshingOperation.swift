//
//  MeshingOperation.swift
//
//  Created by Zack Brown on 07/01/2026.
//

import Euclid
import Foundation
import PeakOperation
import Yield

internal class MeshingOperation: ConcurrentOperation,
                                 ConsumesResult,
                                 ProducesResult,
                                 @unchecked Sendable {
    
    typealias MeshingResult = (files: [String : FileWrapper],
                               folder: String)
    
    internal var input: Result<MeshingResult, Error> = Result { throw ResultError.noResult }
    internal var output: Result<MeshingResult, Error> = Result { throw ResultError.noResult }
    
    internal override func execute() {
        
        print("Generating \(name ?? "") Meshes")
    }
    
    internal override func finish() {
        
        super.finish()
        
        guard let startDate,
              let finishDate else {
            
            return print(" - Finished Generating \(name ?? "") Meshes")
        }
        
        print(" - Finished Generating \(name ?? "") Meshes [\(finishDate.timeIntervalSince(startDate)) seconds]")
    }
}

extension MeshingOperation {
    
    internal func folder() throws -> [String : FileWrapper] {
        
        let contents = Contents.default
        
        let encoder = JSONEncoder.default
        
        let jsonData = try encoder.encode(contents)
        
        let jsonWrapper = FileWrapper(regularFileWithContents: jsonData)
        
        return [Thresher.Constant.contents : jsonWrapper]
    }
    
    internal func fileWrapper(for asset: Asset,
                              mesh: Mesh) throws -> FileWrapper {
        
        let data = Contents.Data.init(filename: asset.id + Thresher.Constant.obj)
        
        let contents = Contents.init(info: .default,
                                     data: [data])
        
        let encoder = JSONEncoder.default
        
        let objData = try encoder.encode(mesh.objString())
        let jsonData = try encoder.encode(contents)
        
        let objWrapper = FileWrapper(regularFileWithContents: objData)
        let jsonWrapper = FileWrapper(regularFileWithContents: jsonData)
        
        let files = [asset.id + Thresher.Constant.obj : objWrapper,
                     Thresher.Constant.contents : jsonWrapper]
        
        return FileWrapper(directoryWithFileWrappers: files)
    }
}
