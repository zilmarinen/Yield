//
//  Thresher.swift
//
//  Created by Zack Brown on 06/01/2026.
//

import Foundation
import Yield

@main
public struct Thresher {
    
    internal enum Constant {
        
        static let assets = "Thresher.xcassets"
        static let contents = "Contents.json"
        static let directory = "/Sources/Yield/"
    }
    
    public static func main() {
        
        print("[Yield Thresher]")
        
        let fileManager = FileManager.default
        
        let path = fileManager.currentDirectoryPath + Constant.directory + Constant.assets
        
        let contents = Contents.default
        let encoder = JSONEncoder.default
        
        do {
            
            let url = URL(fileURLWithPath: path)
            
            if fileManager.fileExists(atPath: path) {
                
                try fileManager.removeItem(at: url)
            }
            
            let data = try encoder.encode(contents)
            
            let json = FileWrapper(regularFileWithContents: data)
            let folder = FileWrapper(directoryWithFileWrappers: [Constant.contents : json])
            
            let fileWrapper = FileWrapper(directoryWithFileWrappers: [Constant.contents : json,
                                                                      "Type": folder])
            
            try fileWrapper.write(to: url,
                                  originalContentsURL: url)
        }
        catch {
            
            print("Error: \(error.localizedDescription)")
        }
    }
}

extension Thresher {
    
    
}
