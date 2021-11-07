//
//  InnerCornerBiscuit.swift
//
//  Created by Zack Brown on 29/10/2021.
//

import Euclid
import Meadow

struct InnerCornerBiscuit {
    
    let config: SocketConfig
    
    let insets: Insets
    
    var mesh: Mesh {
        
        return OuterCornerBiscuit(config: .init(material: config.material, style: config.style, volume: config.volume, type: config.type), insets: insets.opposite).mesh
    }
}
