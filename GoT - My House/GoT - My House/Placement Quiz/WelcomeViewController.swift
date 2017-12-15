//
//  WelcomeViewController.swift
//  GoT - My House
//
//  Created by CS3714 on 12/9/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var quizButton: UIButton!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var startJourneyLabel: UILabel!
    @IBOutlet var sigilImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if applicationDelegate.userData[0] as! String == "Saved" {
            loadUserData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func quizButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Take Quiz", sender: self)
    }
    
    /*
     ---------------------------
     MARK: - Unwind Segue Method
     ---------------------------
     */
    @IBAction func unwindToWelcomeViewController (segue : UIStoryboardSegue) {

        if segue.identifier == "Save User Data" {
            
            applicationDelegate.userData[0] = "Saved"
            let quizViewController : QuizViewController = segue.source as! QuizViewController
            let countedSet = NSCountedSet(array: quizViewController.valuesFromAnswers)
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
            let arViewController : ARViewController = ARViewController(nibName: nil, bundle: nil)
            loadUserData()
            arViewController.viewDidLoad()
        }
    }
    
    /*
     ---------------------------
     MARK: - Load all user's data if they have already taken the quiz at least once
     ---------------------------
     */
    func loadUserData() {
        let houseName: String = applicationDelegate.userData[1] as! String
        if houseName == "" {
            showAlertMessage(messageHeader: "No House Name Found!", messageBody: "Please retake quiz!")
            return
        }
        
        mainLabel.text! = "Congratulations! You are a member of house " + houseName + "!"
        var houseWords = ""
        switch houseName {
        case "Targaryen" :
            houseWords = "Fire and Blood"
        case "Lannister" :
            houseWords = "Hear me Roar!"
        case "Stark" :
            houseWords = "Winter is Coming"
        case "Baratheon" :
            houseWords = "Ours is the Fury"
        default :
            houseWords = "No house words to be found"
        }
        applicationDelegate.userData[2] = houseName + " Sigil.png"

        sigilImageView.image = UIImage(named: applicationDelegate.userData[2] as! String)
        startJourneyLabel.text! = "Enjoy your journey and always remember your house words, '" + houseWords + "'"
        quizButton.setTitle("Retake Quiz", for: .normal)
        
    }
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "Take Quiz" {
            // do nothing but show
        }
    }
    
    /*
     -----------------------------
     MARK: - Display Alert Message
     -----------------------------
     */
    func showAlertMessage(messageHeader header: String, messageBody body: String) {
        
        let alertController = UIAlertController(title: header, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    

}
