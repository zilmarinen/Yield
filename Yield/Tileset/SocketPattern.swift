//
//  SocketPattern.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Meadow

public struct SocketPattern<T: Codable & Equatable>: Equatable {
    
    public var northWest: T
    public var northEast: T
    public var southEast: T
    public var southWest: T
    
    public init(value: T) {
        
        northWest = value
        northEast = value
        southEast = value
        southWest = value
    }
    
    public init(northWest: T,
                northEast: T,
                southEast: T,
                southWest: T) {
        
        self.northWest = northWest
        self.northEast = northEast
        self.southEast = southEast
        self.southWest = southWest
    }
    
    public mutating func set(value: T) {
        
        northWest = value
        northEast = value
        southEast = value
        southWest = value
    }
    
    public mutating func set(value: T, ordinal: Ordinal) {
        
        switch ordinal {
        
        case .northWest: northWest = value
        case .northEast: northEast = value
        case .southEast: southEast = value
        default: southWest = value
        }
    }
    
    public func value(for ordinal: Ordinal) -> T {
        
        switch ordinal {
        
        case .northWest: return northWest
        case .northEast: return northEast
        case .southEast: return southEast
        default: return southWest
        }
    }
}

extension SocketPattern where T == SurfaceMaterial {
    
    var count: Int {
        
        return  (northWest == .air ? 0 : 1) +
                (northEast == .air ? 0 : 1) +
                (southEast == .air ? 0 : 1) +
                (southWest == .air ? 0 : 1)
    }
    
    func union(pattern: SocketPattern) -> Self {
        
        var result = Self(value: .air)
        
        for ordinal in Ordinal.allCases {
         
            let lhs = value(for: ordinal)
            let rhs = pattern.value(for: ordinal)
            
            result.set(value: lhs.rawValue > rhs.rawValue ? lhs : rhs, ordinal: ordinal)
        }
        
        return result
    }
}
