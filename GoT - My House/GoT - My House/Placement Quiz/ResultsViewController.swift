//
//  ResultsViewController.swift
//  GoT - My House
//
//  Created by CloudSD on 12/11/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var resultsLabel: UILabel!
    var houseNamePassed = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.text! = "Congratulations! You are a " + houseNamePassed + "!"
        // Do any additional setup after loading the view.
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
