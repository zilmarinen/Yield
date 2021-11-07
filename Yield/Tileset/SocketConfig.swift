//
//  SocketConfig.swift
//
//  Created by Zack Brown on 03/11/2021.
//

import Foundation
import Meadow

class SocketConfig: ObservableObject {
    
    enum SocketType {
        
        case edge(Cardinal)
        case corner(Ordinal)
        case plateau
    }
    
    @Published var material: SurfaceMaterial
    @Published var style: BiscuitStyle
    @Published var volume: Volume
    @Published var type: SocketType
    
    init(material: SurfaceMaterial = .dirt,
         style: BiscuitStyle = .convex,
         volume: Volume = .crown,
         type: SocketType = .plateau) {
        
        self.material = material
        self.style = style
        self.volume = volume
        self.type = type
    }
}

extension SocketConfig {
    
    var hasStyle: Bool { false }
    var hasVolume: Bool { false }
}
