//
//  ARDisplayViewController.swift
//  GoT - My House
//
//  Created by Jordyn Anderson on 12/14/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARDisplayViewController: UIViewController, ARSCNViewDelegate {
    
    var houseDataPassed: String = ""
    var imageName: String = ""
    var imageTag: String = ""
    var sigil: SCNNode!

    @IBOutlet var arsceneView: ARSCNView!
    @IBOutlet var titleNavItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch houseDataPassed {
        case "Stark":
            titleNavItem.title = "House Stark"
            imageName = "starksig1"
            imageTag = "stark"
        case "Lannister":
            titleNavItem.title = "House Lannister"
            imageName = "lansig1"
            imageTag = "lan"
        case "Baratheon":
            titleNavItem.title = "House Baratheon"
            imageName = "barsig1"
            imageTag = "bar"
        default:
            titleNavItem.title = "House Targaryen"
            imageName = "tarsig1"
            imageTag = "tar"
        }
        
        //Set up AR scene
        arsceneView.delegate = self
        arsceneView.showsStatistics = true
        let scene = SCNScene()
        
        /* Place AR into scene */
        
        if sigil == nil {
            if let GOTScene = SCNScene(named: "art.scnassets/\(imageName).dae") {
                sigil = GOTScene.rootNode.childNode(withName: "\(imageTag)", recursively: true)
                sigil.position = SCNVector3Make(0, 0, -0.5)
                //direwolf.movabilityHint = .movable
                scene.rootNode.addChildNode(sigil!)
            }
        }
        
        arsceneView.scene = scene
    }
    
    /*
     ---------------------------------------
     MARK: - AR Scene Configuration
     ---------------------------------------
     */
    
    /*
     * Configure scene for AR
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        arsceneView.session.run(configuration)
    }
    
    /*
     * When view is hindered, pause AR scene
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        arsceneView.session.pause()
    }

}
