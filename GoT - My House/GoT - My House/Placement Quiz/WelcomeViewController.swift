//
//  WelcomeViewController.swift
//  GoT - My House
//
//  Created by CS3714 on 12/9/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var quizButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func quizButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Take Quiz", sender: self)
    }
    
//    /*
//     ---------------------------
//     MARK: - Unwind Segue Method
//     ---------------------------
//     */
//    @IBAction func unwindToCorporationsILikeTableViewController (segue : UIStoryboardSegue) {
//
//        if segue.identifier == "AddCorp-Save" {
//
//            // Obtain the object reference of the source view controller
//            let addCorpViewController: AddCorporationViewController = segue.source as! AddCorporationViewController
//
//            let corpSymbolEntered: String = addCorpViewController.corpSymbolTextField.text!
//
//
//            // Input Data Validation
//            if corpSymbolEntered.isEmpty {
//                showAlertMessage(messageHeader: "No Stock Symbol Entered!", messageBody: "Please enter a Stock Symbol!")
//                return
//            }
//
//            // Remove the first and last spaces from the entered values
//            var newCorpSymbol = corpSymbolEntered.trimmingCharacters(in: .whitespacesAndNewlines)
//
//            let apiUrl = "https://api.iextrading.com/1.0/stock/\(newCorpSymbol)/company"
//            let logoUrl = "https://storage.googleapis.com/iex/api/logos/\(newCorpSymbol).png"
//
//            let url = URL(string: apiUrl)
//            let getLogoUrl = URL(string: logoUrl)
//            var jsonData : Data?
//            var logoData : Data?
//
//            do {
//                jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
//                logoData = try Data(contentsOf: getLogoUrl!, options: NSData.ReadingOptions.mappedIfSafe)
//            }
//            catch {
//                showAlertMessage(messageHeader: "Symbol Unrecognized!", messageBody: "No corporation found for the stock symbol \(newCorpSymbol) !")
//                return
//            }
//
//
//            if let validjsonData = jsonData {
//
//                let jsonDict : NSDictionary = try! JSONSerialization.jsonObject(with: validjsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
//                if let symbol = jsonDict["symbol"] as? String {
//                    newCorpSymbol = symbol
//                }
//                if let companyName = jsonDict["companyName"] as? String {
//                    corpDataToAdd[0] = companyName
//                }
//                if let description = jsonDict["description"] as? String {
//                    corpDataToAdd[1] = description
//                }
//                if let website = jsonDict["website"] as? String {
//                    corpDataToAdd[3] = website
//                }
//                if let exchange = jsonDict["exchange"] as? String {
//                    corpDataToAdd[4] = exchange
//                }
//            }
//            corpDataToAdd[2] = logoUrl
//            applicationDelegate.dict_Symbol_Corp.setValue(corpDataToAdd, forKey: newCorpSymbol)
//            corpSymbols = applicationDelegate.dict_Symbol_Corp.allKeys as! [String]
//            corpSymbols.sort { $0 < $1 }
//            // Reload
//            self.tableView.reloadData()
//        }
//
//    }
    
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
            // let quizVC : QuizViewController = segue.destination as! QuizViewController
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
