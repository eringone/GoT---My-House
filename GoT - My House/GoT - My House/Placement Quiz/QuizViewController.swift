//
//  QuizViewController.swift
//  GoT - My House
//
//  Created by CS3714 on 12/9/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    var checkmarkImage: UIImageView!
    
    @IBOutlet var beachButton: UIButton!
    //@IBOutlet var checkmarkImage: UIImageView!
    var valuesFromAnswers = [Int]()
    /*
     Values will be evaluated at the end of the quiz
     1 = Targaryen
     2 = Lannister
     3 = Stark
     4 = Baratheon
     value with the most duplicates will decide house
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func beachButtonTapped(_ sender: Any) {
        // attempting to overlay a checkmark on the selected button's image, not working right now
        
        //let bgimg = UIImage(named: "Black Sand Beach.jpeg") // The image used as a background
        let bgimgview = UIImageView(frame: CGRect(x: 29, y: 46, width: 100, height: 150)) // Create the view holding the image
        //bgimgview.frame = CGRect(x: 29, y: 46, width: 100, height: 150) // The size of the background image
        bgimgview.image = UIImage(named: "Black Sand Beach.jpeg")
        
        checkmarkImage = UIImageView(frame: CGRect(x: 29, y: 100, width: 30, height: 42))
        checkmarkImage.image = UIImage(named: "checkmark.png")
        //checkmarkImage
        // checkmarkImage.isUserInteractionEnabled = true
        //bgimgview.addSubview(checkmarkImage)
        //self.view.addSubview(checkmarkImage)
        
        valuesFromAnswers.append(1);
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
