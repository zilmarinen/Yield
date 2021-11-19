//
//  SocketConfig.swift
//
//  Created by Zack Brown on 03/11/2021.
//

import Foundation
import Meadow

class SocketConfig: ObservableObject {
    
    static let empty = SocketConfig(material: .air, style: .convex, volume: .mantle, type: .plateau)
    
    enum Format: String, CaseIterable, Identifiable {
        
        case corner
        case edge
        
        var id: String { rawValue }
    }
    
    enum SocketType {
        
        case edge(Cardinal)
        case corner(Ordinal)
        case plateau
    }
    
    @Published var material: SurfaceMaterial
    @Published var style: BiscuitStyle
    @Published var volume: Volume
    @Published var type: SocketType
    
    @Published var format: Format = .corner {
        
        didSet {
            
            switch format {
            case .corner: type = .corner(ordinal)
            case .edge: type = .edge(cardinal)
            }
        }
    }
    
    @Published var cardinal: Cardinal = .south {
        
        didSet {
            
            if cardinal != oldValue {
                
                format = .edge
            }
        }
    }
    
    @Published var ordinal: Ordinal = .southEast {
        
        didSet {
            
            if ordinal != oldValue {
                
                format = .corner
            }
        }
    }
    
    init(material: SurfaceMaterial = .dirt,
         style: BiscuitStyle = .convex,
         volume: Volume = .crown,
         type: SocketType = .edge(.north)) {
        
        self.material = material
        self.style = style
        self.volume = volume
        self.type = type
    }
}

extension SocketConfig {
    
    var hasStyle: Bool { false }
    var hasVolume: Bool { false }
    
    func empty(style: BiscuitStyle? = nil, volume: Volume? = nil, type: SocketType? = nil) -> SocketConfig { .init(material: material, style: style ?? self.style, volume: volume ?? self.volume, type: type ?? self.type) }
    
    func with(style: BiscuitStyle? = nil, volume: Volume? = nil, type: SocketType? = nil) -> SocketConfig { .init(material: material, style: style ?? self.style, volume: volume ?? self.volume, type: type ?? self.type) }
}
