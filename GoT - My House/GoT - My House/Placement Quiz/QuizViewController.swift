//
//  QuizViewController.swift
//  GoT - My House
//
//  Created by CS3714 on 12/9/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit
//import <QuartzCore/QuartzCore.h>

class QuizViewController: UIViewController {
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var checkmarkImage: UIImageView!
    
    @IBOutlet var beachButton: UIButton!
    //@IBOutlet var checkmarkImage: UIImageView!
    var valuesFromAnswers = [Int](repeating: 0, count: 5) // = [0, 0, 0, 0, 0]
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
    
    /*
     -----------------------------
     MARK: - Question 1 Button Tapped Handlers
     -----------------------------
     */
    @IBAction func beachButtonTapped(_ sender: Any) {
        valuesFromAnswers[0] = 1
        print("Targaryen")
        beachButton.layer.borderWidth = 2
        beachButton.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction func cityButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[0] = 2
        print("Lannister")
        beachButton.layer.borderWidth = 0
    }
    
    @IBAction func iglooButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[0] = 3
        print("Stark")
    }
    
    @IBAction func forestButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[0] = 4
        print("Baratheon")
    }
    
    /* ----------------------- End Q1 ---------------------------- */
    
    /*
     -----------------------------
     MARK: - Question 2 Button Tapped Handlers
     -----------------------------
     */
    @IBAction func seafoodButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[1] = 1
        print("Targaryen")
    }
    
    @IBAction func burgerButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[1] = 2
        print("Lannister")
    }
    
    @IBAction func turkeyButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[1] = 3
        print("Stark")
    }

    @IBAction func vegetarianButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[1] = 4
        print("Baratheon")
    }
    
    /* ----------------------- End Q2 ---------------------------- */
    
    /*
     -----------------------------
     MARK: - Question 3 Button Tapped Handlers
     -----------------------------
     */
    @IBAction func sleepButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[2] = 1
        print("Targaryen")

    }
    
    @IBAction func totsButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[2] = 2
        print("Lannister")
    }
  
    
    @IBAction func appsButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[2] = 3
        print("Stark")
    }
    
    @IBAction func gamesButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[2] = 4
        print("Baratheon")
    }
    /* ----------------------- End Q3 ---------------------------- */
    
    /*
     -----------------------------
     MARK: - Question 4 Button Tapped Handlers
     -----------------------------
     */
    @IBAction func islandButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[3] = 1
        print("Targaryen")

    }
    
    @IBAction func mansionButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[3] = 2
        print("Lannister")
    }
    
    @IBAction func jetButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[3] = 3
        print("Stark")
    }
    
    @IBAction func carButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[3] = 4
        print("Baratheon")
    }
    /* ----------------------- End Q4 ---------------------------- */
    
    /*
     -----------------------------
     MARK: - Question 5 Button Tapped Handlers
     -----------------------------
     */
    @IBAction func dragonButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[4] = 1
        print("Targaryen")
    }
    
    @IBAction func lionButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[4] = 2
        print("Lannister")
    }
    
    @IBAction func ursulaButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[4] = 3
        print("Stark")
    }
    
    @IBAction func hunterButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[4] = 4
        print("Baratheon")
    }
    
    /* ----------------------- End Q5 ---------------------------- */
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        applicationDelegate.userData[0] = "Saved"
        
        let countedSet = NSCountedSet(array: valuesFromAnswers)
        let mostFrequent = countedSet.max { countedSet.count(for: $0) < countedSet.count(for: $1) } as! Int
        if mostFrequent == 1 {
            applicationDelegate.userData[1] = "Targaryen"
        }
        else if mostFrequent == 2 {
            applicationDelegate.userData[1] = "Lannister"
        }
        else if mostFrequent == 3 {
            applicationDelegate.userData[1] = "Stark"
        }
        else if mostFrequent == 4 {
            applicationDelegate.userData[1] = "Baratheon"
        }
        // most likely add the sigil png to the plist
        
        //performSegue(withIdentifier: "Show Results", sender: self)
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
