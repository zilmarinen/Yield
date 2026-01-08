//
//  FootpathMeshingOperation.swift
//  Yield
//
//  Created by Zack Brown on 07/01/2026.
//

import Cobble
import Deltille
import Euclid
import Foundation
import PeakOperation
import Yield

internal class FootpathMeshingOperation: MeshingOperation,
                                        @unchecked Sendable {
    
    internal init() {
        
        super.init(category: .footpath)
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try folder()
            
            //
            sleep(1)
            
            output = .success((files,
                               category.id))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
