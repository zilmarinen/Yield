//
//  Inset.swift
//
//  Created by Zack Brown on 04/11/2021.
//

enum Inset {
    
    case inner
    case none
    case outer
    
    var opposite: Inset {
        
        switch self {
            
        case .inner: return .outer
        case .outer: return .inner
        case .none: return .none
        }
    }
}

struct Insets {
    
    let left: Inset
    let right: Inset
    
    init(value: Inset) {
        
        left = value
        right = value
    }
    
    init(left: Inset, right: Inset) {
        
        self.left = left
        self.right = right
    }
    
    var lhs: Insets { .init(value: left) }
    var rhs: Insets { .init(value: right) }
    
    var center: Inset {
        
        switch (left, right) {
            
        case (.inner, .inner): return .inner
        case (.none, .none): return .none
        case (.outer, .outer) : return .outer
        case (.inner, _),
            (_, .inner): return .inner
        case (.outer, _),
            (_, .outer): return .outer
        }
    }
    
    var inner: Bool { left == .inner || right == .inner }
    
    var opposite: Insets { .init(left: left.opposite, right: right.opposite) }
}
