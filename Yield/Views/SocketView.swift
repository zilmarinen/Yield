//
//  SocketView.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import Meadow
import SceneKit
import SwiftUI

struct SocketMaterialView: View {
    
    let title: String
    
    let material: SurfaceMaterial

    var body: some View {
        
        ToolPropertyView(title: title, color: .pink) {

            BadgeView(model: .init(title: "\(material)", color: (material != .air ? .pink : .gray)))
        }
    }
}

struct SocketVolumeView: View {
    
    let title: String
    
    let volume: SurfaceVolume

    var body: some View {
        
        ToolPropertyView(title: title, color: .pink) {

            BadgeView(model: .init(title: "\(volume)", color: (volume != .empty ? .pink : .gray)))
        }
    }
}

struct SocketsView: View {
    
    @ObservedObject private(set) var prototype: EditorTile

    var body: some View {
        
        ToolPropertySection {

            ToolPropertyGroup(model: .init(title: "Sockets", badge: .init(title: "\(prototype.sockets.count)", color: .pink))) {

                SocketMaterialView(title: "North West", material: prototype.sockets.material(for: .northWest))
                SocketMaterialView(title: "North East", material: prototype.sockets.material(for: .northEast))
                SocketMaterialView(title: "South East", material: prototype.sockets.material(for: .southEast))
                SocketMaterialView(title: "South West", material: prototype.sockets.material(for: .southWest))
            }
            .padding(.bottom, YieldApp.Constants.padding)
            
            ToolPropertyGroup() {
                
                SocketVolumeView(title: "North West", volume: prototype.sockets.volume(for: .northWest))
                SocketVolumeView(title: "North East", volume: prototype.sockets.volume(for: .northEast))
                SocketVolumeView(title: "South East", volume: prototype.sockets.volume(for: .southEast))
                SocketVolumeView(title: "South West", volume: prototype.sockets.volume(for: .southWest))
            }
        }
    }
}
