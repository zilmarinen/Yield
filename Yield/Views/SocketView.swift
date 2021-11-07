//
//  SocketView.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import SceneKit
import SwiftUI

struct SocketView: View {
    
    let title: String
    
    let material: SurfaceMaterial

    var body: some View {
        
        ToolPropertyView(title: title, color: .pink) {

            BadgeView(model: .init(title: "\(material)", color: (material != .air ? .pink : .gray)))
        }
    }
}

struct SocketsView: View {
    
    @ObservedObject private(set) var prototype: EditorTile

    var body: some View {
        
        ToolPropertySection {

            ToolPropertyGroup(model: .init(title: "Sockets", badge: .init(title: "\(prototype.sockets.count)", color: .pink))) {

                SocketView(title: "[nX, pY, pZ]", material: prototype.sockets.upper.value(for: .northWest))
                SocketView(title: "[pX, pY, pZ]", material: prototype.sockets.upper.value(for: .northEast))
                SocketView(title: "[pX, pY, nZ]", material: prototype.sockets.upper.value(for: .southEast))
                SocketView(title: "[nX, pY, nZ]", material: prototype.sockets.upper.value(for: .southWest))
            }
            .padding(.bottom, YieldApp.Constants.padding)
            
            ToolPropertyGroup() {
                
                SocketView(title: "[nX, nY, pZ]", material: prototype.sockets.lower.value(for: .northWest))
                SocketView(title: "[pX, nY, pZ]", material: prototype.sockets.lower.value(for: .northEast))
                SocketView(title: "[pX, nY, nZ]", material: prototype.sockets.lower.value(for: .southEast))
                SocketView(title: "[nX, nY, nZ]", material: prototype.sockets.lower.value(for: .southWest))
            }
        }
    }
}
