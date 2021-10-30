//
//  SocketView.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import SceneKit
import SwiftUI

struct SocketView: View {
    
    let title: String
    
    let socket: SurfaceMaterial

    var body: some View {
        
        ToolPropertyView(title: title, color: .pink) {

            BadgeView(model: .init(title: "\(socket)", color: (socket != .air ? .pink : .gray)))
        }
    }
}

struct SocketsView: View {
    
    @ObservedObject private(set) var tileset: Tileset

    var body: some View {
        
        ToolPropertySection {

            ToolPropertyGroup(model: .init(title: "Sockets", badge: .init(title: "\(tileset.sockets.count)", color: .pink))) {

                SocketView(title: "[nX, pY, pZ]", socket: tileset.sockets.upper.value(for: .northWest))
                SocketView(title: "[pX, pY, pZ]", socket: tileset.sockets.upper.value(for: .northEast))
                SocketView(title: "[pX, pY, nZ]", socket: tileset.sockets.upper.value(for: .southEast))
                SocketView(title: "[nX, pY, nZ]", socket: tileset.sockets.upper.value(for: .southWest))
            }
            .padding(.bottom, YieldApp.Constants.padding)
            
            ToolPropertyGroup() {
                
                SocketView(title: "[nX, nY, pZ]", socket: tileset.sockets.lower.value(for: .northWest))
                SocketView(title: "[pX, nY, pZ]", socket: tileset.sockets.lower.value(for: .northEast))
                SocketView(title: "[pX, nY, nZ]", socket: tileset.sockets.lower.value(for: .southEast))
                SocketView(title: "[nX, nY, nZ]", socket: tileset.sockets.lower.value(for: .southWest))
            }
        }
    }
}
