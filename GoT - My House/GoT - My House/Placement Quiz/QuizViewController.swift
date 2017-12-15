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
    
    @IBOutlet var beachButton: UIButton!
    @IBOutlet var iglooButton: UIButton!
    @IBOutlet var forestButton: UIButton!
    @IBOutlet var cityButton: UIButton!
    
    @IBOutlet var burgerButton: UIButton!
    @IBOutlet var seafoodButton: UIButton!
    @IBOutlet var vegetarianButton: UIButton!
    @IBOutlet var turkeyButton: UIButton!
    
    @IBOutlet var gamesButton: UIButton!
    @IBOutlet var sleepButton: UIButton!
    @IBOutlet var totsButton: UIButton!
    @IBOutlet var appsButton: UIButton!
    
    @IBOutlet var islandButton: UIButton!
    @IBOutlet var carButton: UIButton!
    @IBOutlet var jetButton: UIButton!
    @IBOutlet var mansionButton: UIButton!
    
    @IBOutlet var hunterButton: UIButton!
    @IBOutlet var dragonButton: UIButton!
    @IBOutlet var ursulaButton: UIButton!
    @IBOutlet var lionButton: UIButton!

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
        
        beachButton.layer.borderWidth = 4
        beachButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: cityButton, button2: iglooButton, button3: forestButton)
    }
    
    @IBAction func cityButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[0] = 2
        print("Lannister")
        
        cityButton.layer.borderWidth = 4
        cityButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: beachButton, button2: iglooButton, button3: forestButton)
    }
    
    @IBAction func iglooButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[0] = 3
        print("Stark")
        
        iglooButton.layer.borderWidth = 4
        iglooButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: beachButton, button2: cityButton, button3: forestButton)
    }
    
    @IBAction func forestButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[0] = 4
        print("Baratheon")
        
        forestButton.layer.borderWidth = 4
        forestButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: beachButton, button2: iglooButton, button3: cityButton)
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
        
        seafoodButton.layer.borderWidth = 4
        seafoodButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: burgerButton, button2: vegetarianButton, button3: turkeyButton)
    }
    
    @IBAction func vegetarianButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[1] = 2
        print("Baratheon")
        
        vegetarianButton.layer.borderWidth = 4
        vegetarianButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: seafoodButton, button2: burgerButton, button3: turkeyButton)
    }
    
    @IBAction func turkeyButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[1] = 3
        print("Stark")
        
        turkeyButton.layer.borderWidth = 4
        turkeyButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: seafoodButton, button2: vegetarianButton, button3: burgerButton)
    }
    
    @IBAction func burgerButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[1] = 4
        print("Lannister")
        
        burgerButton.layer.borderWidth = 4
        burgerButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: seafoodButton, button2: vegetarianButton, button3: turkeyButton)
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
        
        sleepButton.layer.borderWidth = 4
        sleepButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: totsButton, button2: appsButton, button3: gamesButton)
    }
    
    @IBAction func totsButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[2] = 2
        print("Lannister")
        
        totsButton.layer.borderWidth = 4
        totsButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: sleepButton, button2: appsButton, button3: gamesButton)
    }
  
    
    @IBAction func appsButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[2] = 3
        print("Stark")
        
        appsButton.layer.borderWidth = 4
        appsButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: totsButton, button2: sleepButton, button3: gamesButton)
    }
    
    @IBAction func gamesButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[2] = 4
        print("Baratheon")
        
        gamesButton.layer.borderWidth = 4
        gamesButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: totsButton, button2: appsButton, button3: sleepButton)
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

        islandButton.layer.borderWidth = 4
        islandButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: mansionButton, button2: jetButton, button3: carButton)
    }
    
    @IBAction func mansionButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[3] = 2
        print("Lannister")
        
        mansionButton.layer.borderWidth = 4
        mansionButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: islandButton, button2: jetButton, button3: carButton)
    }
    
    @IBAction func jetButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[3] = 3
        print("Stark")
        
        jetButton.layer.borderWidth = 4
        jetButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: mansionButton, button2: islandButton, button3: carButton)
    }
    
    @IBAction func carButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[3] = 4
        print("Baratheon")
        
        carButton.layer.borderWidth = 4
        carButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: mansionButton, button2: jetButton, button3: islandButton)
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
        
        dragonButton.layer.borderWidth = 4
        dragonButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: lionButton, button2: ursulaButton, button3: hunterButton)
    }
    
    @IBAction func lionButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[4] = 2
        print("Lannister")
        
        lionButton.layer.borderWidth = 4
        lionButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: dragonButton, button2: ursulaButton, button3: hunterButton)
    }
    
    @IBAction func ursulaButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[4] = 3
        print("Stark")
        
        ursulaButton.layer.borderWidth = 4
        ursulaButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: lionButton, button2: dragonButton, button3: hunterButton)
    }
    
    @IBAction func hunterButtonTapped(_ sender: UIButton) {
        valuesFromAnswers[4] = 4
        print("Baratheon")
        
        hunterButton.layer.borderWidth = 4
        hunterButton.layer.borderColor = UIColor.blue.cgColor
        resetSelection(button1: lionButton, button2: ursulaButton, button3: dragonButton)
    }
    
    /* ----------------------- End Q5 ---------------------------- */
    
    /*
     -----------------------------
     MARK: - Remove any red borders, if user has changed their answer
     -----------------------------
     */
    func resetSelection(button1: UIButton, button2: UIButton, button3: UIButton) {
        button1.layer.borderWidth = 0
        button2.layer.borderWidth = 0
        button3.layer.borderWidth = 0
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
