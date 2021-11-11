//
//  PreviewViewController.swift
//
//  Created by Zack Brown on 10/11/2021.
//

import Cocoa
import Euclid
import Quartz
import SceneKit

class PreviewViewController: NSViewController, QLPreviewingController {
    
    let scene = EditorScene()
    
    @IBOutlet weak var sceneView: SCNView!
    
    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
    }
    
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        
        do {
            
            let decoder = JSONDecoder()
        
            let data = try Data(contentsOf: url)
        
            let model = try decoder.decode(Model.self, from: data)
            
            guard let socket = model.tile.sockets.first else { return handler(nil) }
            
            scene.model.geometry = SCNGeometry(model.mesh)
            scene.sockets.setup(sockets: socket)
            
            handler(nil)
        }
        catch {
            
            handler(error)
        }
    }
}
