//
//  WriteOperation.swift
//
//  Created by Zack Brown on 26/09/2021.
//

import Foundation
import Harvest
import PeakOperation

class WriteOperation: ConcurrentOperation, ConsumesResult, ProducesResult {
    
    public var input: Result<([SurfaceTilesetTile], [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    public var output: Result<Void, Error> = Result { throw ResultError.noResult }
    
    let url: URL
    
    init(url: URL) {
        
        self.url = url
        
        super.init()
    }
    
    override func execute() {
        
        do {
            
            var (tileset, wrappers) = try input.get()
            
            let data = try JSONEncoder().encode(tileset)
            
            wrappers["surface_tilemap.json"] = FileWrapper(regularFileWithContents: data)
            
            let wrapper = FileWrapper(directoryWithFileWrappers: wrappers)
            
            try wrapper.write(to: url, options: .atomic, originalContentsURL: url)
            
            output = .success(())
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
