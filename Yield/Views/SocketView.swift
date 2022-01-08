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
    
    let occupied: Bool

    var body: some View {
        
        ToolPropertyView(title: title, color: .pink) {

            BadgeView(model: .init(title: "\(occupied ? "o" : "x")", color: (occupied ? .pink : .gray)))
        }
    }
}

struct SocketsView: View {
    
    @ObservedObject private(set) var prototype: EditorTile

    var body: some View {
        
        ToolPropertySection {

            ToolPropertyGroup(model: .init(title: "Materials", badge: .init(title: "\(prototype.sockets.bitmask)", color: .pink))) {

                SocketView(title: "North West", occupied: prototype.sockets.value(for: .northWest).outer)
                SocketView(title: "North East", occupied: prototype.sockets.value(for: .northEast).outer)
                SocketView(title: "South East", occupied: prototype.sockets.value(for: .southEast).outer)
                SocketView(title: "South West", occupied: prototype.sockets.value(for: .southWest).outer)
            }
        }
    }
}
