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
    var selectedArray = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let houseData: [String] = selectedHouse.components(separatedBy: "|")
        
        // Nav Title
        houseNavTitle.title = houseData[0]
        
        // Name
        name.text = houseData[0]
        
        // Region
        if houseData[1] == "" {
            region.text = "N/A"
        }
        else {
            region.text = houseData[1]
        }
        
        // Coat of Arms
        if houseData[2] == "" {
            coatOfArms.text = "N/A"
        }
        else {
            coatOfArms.text = houseData[2]
        }
        
        // Motto
        if houseData[3] == "" {
            words.text = "N/A"
        }
        else {
            words.text = houseData[3]
        }
        
        // Titles
        if selectedArray[0].isEmpty {
            titles.text = "N/A"
        }
        else {
            var titleString = ""
            for i in 0 ..< selectedArray[0].count - 1 {
                titleString = titleString + selectedArray[0][i] + ", "
            }
            let last = selectedArray[0].count - 1
            titleString = titleString + selectedArray[0][last]
            titles.text = titleString
        }
        
        // Seats
        if selectedArray[1].isEmpty {
            seats.text = "N/A"
        }
        else {
            var seatString = ""
            for i in 0 ..< selectedArray[1].count - 1 {
                seatString = seatString + selectedArray[1][i] + ", "
            }
            let last = selectedArray[1].count - 1
            seatString = seatString + selectedArray[1][last]
            seats.text = seatString
        }
        
        // Current Lord
        if houseData[6] == "" {
            currentLord.text = "N/A"
        }
        else {
            currentLord.text = findCharacter(charId: houseData[6])
        }
        
        // Heir
        if houseData[7] == "" {
            heir.text = "N/A"
        }
        else {
            heir.text = findCharacter(charId: houseData[7])
        }
        
        // Founded
        if houseData[8] == "" {
            founded.text = "N/A"
        }
        else {
            founded.text = houseData[8]
        }
        
        // Founder
        if houseData[9] == "" {
            founder.text = "N/A"
        }
        else {
            founder.text = findCharacter(charId: houseData[9])
        }
        
        // Sworn Members
        if selectedArray[2].isEmpty {
            swornMembers.text = "N/A"
        }
        else {
            swornMembers.text = getSwornMembers(chars: selectedArray[2])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findCharacter(charId: String) -> String {
        var charName = ""
        
        let url = URL(string: charId)
        
        let jsonData: Data?
        
        do {
            /*
             Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
             Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
             */
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        }
        catch let error as NSError {
            print(error)
            return "Error"
        }
        
        if let jsonDataFromApiUrl = jsonData {
            
            // The JSON data is successfully obtained from the API
            
            do {
                /*
                 JSONSerialization class is used to convert JSON and Foundation objects (e.g., NSDictionary) into each other.
                 JSONSerialization class method jsonObject returns an NSDictionary object from the given JSON data.
                 */
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                if let path = jsonDataDictionary["name"] as? String? {
                    charName = path!
                }
            
            }
            catch let error as NSError {
                
                print("Error in JSON Data Serialization: \(error.localizedDescription)")
                return "Error"
            }
            
        }
        else {
        print("Unable to obtain the JSON data file!")
        }
        
        return charName
    }
    
    func getSwornMembers(chars: [String]) -> String {
        
        var charList = ""
        
        for i in 0 ..< chars.count - 1 {
            if i > 9 {
                break
            }
            charList = charList + findCharacter(charId: chars[i]) + ", "
        }
        
        var last = Int()
        if chars.count > 9 {
            last = 10
        }
        else {
            last = chars.count - 1
        }
        charList = charList + findCharacter(charId: chars[last])
        
        return charList
    }

}
