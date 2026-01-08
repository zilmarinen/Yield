//
//  Yield.swift
//
//  Created by Zack Brown on 06/01/2026.
//

import Foundation

@main
public struct Yield {
    
    public static func main() {
        
        print("\n\u{001B}[94m-------")
        print("[Yield Thresher]")
        print("-------\u{001B}[0m\n")
        
        let thresher = Thresher()
        
        thresher.execute()
    }
}
