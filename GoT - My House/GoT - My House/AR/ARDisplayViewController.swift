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

class ARDisplayViewController: UIViewController {
    
    var houseDataPassed: String = ""
    var imageName: String = ""

    @IBOutlet var arsceneView: ARSCNView!
    @IBOutlet var titleNavItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch houseDataPassed {
        case "Stark":
            titleNavItem.title = "House Stark"
           imageName = "starkSigl"
        case "Lannister":
            titleNavItem.title = "House Lannister"
          imageName = "lannSigil"
        case "Baratheon":
            titleNavItem.title = "House Baratheon"
            imageName = "baratSigil"
        default:
            titleNavItem.title = "House Targaryen"
            imageName = "tarSigil"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
