//
//  HouseDetailsViewController.swift
//  GoT - My House
//
//  Created by Erin Gaughan on 11/30/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class HouseDetailsViewController: UIViewController {
    
    @IBOutlet var houseNavTitle: UINavigationItem!
    @IBOutlet var name: UILabel!
    @IBOutlet var region: UILabel!
    @IBOutlet var coatOfArms: UILabel!
    @IBOutlet var words: UILabel!
    @IBOutlet var titles: UILabel!
    @IBOutlet var seats: UILabel!
    @IBOutlet var currentLord: UILabel!
    @IBOutlet var heir: UILabel!
    @IBOutlet var founded: UILabel!
    @IBOutlet var founder: UILabel!
    @IBOutlet var swornMembers: UILabel!
    
    var selectedHouse = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let houseData: [String] = selectedHouse.components(separatedBy: "|")
        
        houseNavTitle.title = houseData[0]
        name.text = houseData[0]
        region.text = houseData[1]
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
