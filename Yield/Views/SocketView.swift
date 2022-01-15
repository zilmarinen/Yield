//
//  SocketView.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import Meadow
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

            ToolPropertyGroup(model: .init(title: "Materials", badge: .init(title: "\(prototype.sockets.bitmask)", color: .pink))) {

                SocketView(title: "North West", material: prototype.sockets.value(for: .northWest).outer ? prototype.material : .air)
                SocketView(title: "North East", material: prototype.sockets.value(for: .northEast).outer ? prototype.material : .air)
                SocketView(title: "South East", material: prototype.sockets.value(for: .southEast).outer ? prototype.material : .air)
                SocketView(title: "South West", material: prototype.sockets.value(for: .southWest).outer ? prototype.material : .air)
            }
        }
    }
}
