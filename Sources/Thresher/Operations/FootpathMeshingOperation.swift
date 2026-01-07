//
//  FootpathMeshingOperation.swift
//  Yield
//
//  Created by Zack Brown on 07/01/2026.
//

import Deltille
import Euclid
import Foundation
import PeakOperation
import Yield

internal class FootpathMeshingOperation: MeshingOperation,
                                        @unchecked Sendable {
    
    internal override init() {
        
        super.init()
        
        self.name = Asset.Category.footpaths.id
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try folder()
            
            //
            sleep(1)
            
            output = .success((files,
                               Asset.Category.footpaths.id))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
