//
//  SocketConfig.swift
//
//  Created by Zack Brown on 03/11/2021.
//

import Foundation
import Harvest
import Meadow

class SocketConfig: ObservableObject {
    
    static let empty = SocketConfig(material: .air, style: .convex, volume: .throne, type: .plateau)
    
    enum Shape: String, CaseIterable, Identifiable {
        
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
    @Published var style: SurfaceStyle
    @Published var volume: BiscuitVolume
    @Published var type: SocketType
    
    @Published var shape: Shape = .corner {
        
        didSet {
            
            switch shape {
            case .corner: type = .corner(ordinal)
            case .edge: type = .edge(cardinal)
            }
        }
    }
    
    @Published var cardinal: Cardinal = .south {
        
        didSet {
            
            if cardinal != oldValue {
                
                shape = .edge
            }
        }
    }
    
    @Published var ordinal: Ordinal = .southEast {
        
        didSet {
            
            if ordinal != oldValue {
                
                shape = .corner
            }
        }
    }
    
    init(material: SurfaceMaterial = .dirt,
         style: SurfaceStyle = .convex,
         volume: BiscuitVolume = .crown,
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
    
    func empty(style: SurfaceStyle? = nil, volume: BiscuitVolume? = nil, type: SocketType? = nil) -> SocketConfig { .init(material: .air, style: style ?? self.style, volume: volume ?? self.volume, type: type ?? self.type) }
    
    func with(style: SurfaceStyle? = nil, volume: BiscuitVolume? = nil, type: SocketType? = nil) -> SocketConfig { .init(material: material, style: style ?? self.style, volume: volume ?? self.volume, type: type ?? self.type) }
}
