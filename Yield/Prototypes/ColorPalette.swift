//
//  ColorPalette.swift
//
//  Created by Zack Brown on 27/10/2021.
//

import Euclid

struct ColorPalette {
    
    let primary: Color
    let secondary: Color
    let tertiary: Color
    let quaternary: Color
}

extension ColorPalette {
    
    static let air = ColorPalette(primary: .clear, secondary: .clear, tertiary: .clear, quaternary: .clear)
    
    static let dirt = ColorPalette(primary: Color(0.776, 0.835, 0.494),
                                   secondary: Color(0.807, 0.989, 0.815),
                                   tertiary: Color(0.764, 0.407, 0.223),
                                   quaternary: Color(0.670, 0.427, 0.137))
    
    static let sand = ColorPalette(primary: Color(0.952, 0.874, 0.537),
                                   secondary: Color(0.941, 0.768, 0.247),
                                   tertiary: Color(0.933, 0.69, 0.027),
                                   quaternary: Color(0.952, 0.878, 0.631))
    
    static let stone = ColorPalette(primary: Color(0.392, 0.423, 0.372),
                                    secondary: Color(0.329, 0.337, 0.333),
                                    tertiary: Color(0.439, 0.345, 0.321),
                                    quaternary: Color(0.313, 0.231, 0.239))
    
    static let undergrowth = ColorPalette(primary: Color(0.541, 0.525, 0.207),
                                          secondary: Color(0.196, 0.313, 0.180),
                                          tertiary: Color(0.282, 0.203, 0.203),
                                          quaternary: Color(0.176, 0.141, 0.141))
}
