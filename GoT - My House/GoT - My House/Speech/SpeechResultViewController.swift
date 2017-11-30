//
//  SpeechResultViewController.swift
//  GoT - My House
//
//  Created by Erin Gaughan on 11/28/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class SpeechResultViewController: UIViewController {
    
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a URL struct data structure from the API query URL string
        let url = URL(string: "https://got-quotes.herokuapp.com/quotes")
        
        let jsonData: Data?
        
        do {
            /*
             Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
             Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
             */
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        } catch let error as NSError {
            
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in retrieving JSON data: \(error.localizedDescription)")
            return
        }
        
        if let jsonDataFromApiUrl = jsonData {
            
            // The JSON data is successfully obtained from the API
            
            do {
                /*
                 JSONSerialization class is used to convert JSON and Foundation objects (e.g., NSDictionary) into each other.
                 JSONSerialization class method jsonObject returns an NSDictionary object from the given JSON data.
                 */
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
                // Typecast the returned NSDictionary as Dictionary<String, AnyObject>
                let dictionaryOfReturnedJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
                
                //*************
                // Obtain Quote
                //*************
                
                var quote = ""
                if let quoteResult = dictionaryOfReturnedJsonData["quote"] as! String? {
                    quote = quoteResult
                }
                
                //*****************
                // Obtain Character
                //*****************
                
                var character = ""
                if let characterResult = dictionaryOfReturnedJsonData["character"] as! String? {
                    character = characterResult
                }
                
                quoteLabel.text = quote
                characterLabel.text = "- " + character
                
            } catch let error as NSError {
                
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return
            }
            
        } else {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Unable to obtain the JSON data file!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     -----------------------------
     MARK: - Display Alert Message
     -----------------------------
     */
    func showAlertMessage(messageHeader header: String, messageBody body: String) {
        
        /*
         Create a UIAlertController object; dress it up with title, message, and preferred style;
         and store its object reference into local constant alertController
         */
        let alertController = UIAlertController(title: header, message: body, preferredStyle: UIAlertControllerStyle.alert)
        
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    
}

