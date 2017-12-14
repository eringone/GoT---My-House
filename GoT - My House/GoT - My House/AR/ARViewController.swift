//
//  ARViewController.swift
//  GoT - My House
//
//  Created by Jordyn Anderson on 12/14/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class ARViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var GotHousesPicker: UIPickerView!
    
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var quizTaken: Bool = true;
    var myHouse: String = ""
    var houseDataToPass: String = ""
    
    /* Array to hold names of GoT houses to display in picker view */
    let housesPickerData = ["Targaryen", "Stark", "Baratheon", "Lannister"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Show the pickerView middle roas as the selected one
        GotHousesPicker.selectRow(Int(housesPickerData.count / 2), inComponent: 0, animated: false)
        
        //Get the house result from the
        myHouse = applicationDelegate.userData[0] as! String
        if myHouse == "Unsaved" {
            quizTaken = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func myARButtonTapped(_ sender: Any) {
        //If the quiz has not been completed and results save, throw error
        if !quizTaken {
            showErrorMessage(title: "No AR Results", message: "Please complete My House quiz before displaying AR!")
            return;
        }
        houseDataToPass = myHouse
        performSegue(withIdentifier: "ARSCN", sender: self)
    }
    
    @IBAction func pickedARButtonTapped(_ sender: Any) {
        //Get the house that was selected
        let rowIndex = GotHousesPicker.selectedRow(inComponent: 0)
        houseDataToPass = housesPickerData[rowIndex]
        performSegue(withIdentifier: "ARSCN", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
     ---------------------------------------
     MARK: - Picker View Data Source Methods
     ---------------------------------------
     */
    
    // Specifies how many components in the Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Specifies how many rows in the Picker View component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // Tag number is set in the Storyboard: 1 for dietLabelPickerView and 2 for healthLabelPickerView
        // We use Swift's ternary conditional operator:
        
        return housesPickerData.count
    }
    
    /*
     --------------------------------------------
     MARK: - UIPickerViewDelegate Protocol Method
     --------------------------------------------
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return housesPickerData[row]
    }
    
    /*
     -------------------------
     MARK: - Prepare For Segue
     -------------------------
     */
    
    // This method is called by the system whenever you invoke the method performSegue
    // You never call this method. It is invoked by the system.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ARSCN" {
            
            // Obtain the object reference of the destination view controller
            let arDisplayViewController: ARDisplayViewController = segue.destination as! ARDisplayViewController
            
            // Pass the data object to the destination view controller
            arDisplayViewController.houseDataPassed = houseDataToPass
        }
    }
    
    func showErrorMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //Create the alert object and add to the alert controller
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Present the alter controller by calling the presentViewController method
        present(alertController, animated: true, completion: nil)
    }

}
