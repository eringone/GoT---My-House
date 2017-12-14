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
            loadUserData()
        }
    }
    
    func loadUserData() {
        let houseName: String = applicationDelegate.userData[1] as! String
        if houseName == "" {
            showAlertMessage(messageHeader: "No House Name Found!", messageBody: "Please retake quiz!")
            return
        }
        
        mainLabel.text! = "Congratulations! Your house is " + houseName + "!"
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
        
        sigilImageView.image = UIImage(named: houseName + " Sigil.png")
        startJourneyLabel.text! = "Enjoy your journey and always remember your words '" + houseWords + "'"
        quizButton.setTitle("Retake Quiz", for: .normal)
    }
    
    /*
     -------------------------
     MARK: - Add Corporation Method
     -------------------------
     */
    @objc func addCorporation(_ sender: AnyObject) {
        performSegue(withIdentifier: "Add New Corporation", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "Take Quiz" {
            // do nothing 
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
