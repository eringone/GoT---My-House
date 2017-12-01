//
//  HousesTableViewController.swift
//  GoT - My House
//
//  Created by Erin Gaughan on 11/30/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class HousesTableViewController: UITableViewController {
    
    // Instance Variables
    var arrayOfHouses = [String]()
    var selectedHouse = ""
    var wikiURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Comment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true

        let search = "https://www.anapioficeandfire.com/api/houses"
        let url = URL(string: search)
        
        let jsonData: Data?
        
        do {
            /*
             Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
             Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
             */
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        }
        catch let error as NSError {
            
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
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as! Array<AnyObject>
                
                //print(jsonDataDictionary[0])
                
                for index in 0 ..< jsonDataDictionary.count {
                    
                    // Typecast the returned NSDictionary as Dictionary<String, AnyObject>
                    let houseIndex = jsonDataDictionary[index] as! NSDictionary
                    
                    //*******************
                    // Obtain House Name
                    //*******************
                    
                    var houseName = ""
                    if let path = houseIndex["name"] as? String? {
                        houseName = path!
                    }
                    
                    var houseRegion = ""
                    if let path = houseIndex["region"] as? String? {
                        houseRegion = path!
                    }
                    
                    //***************************************************************
                    // Compose the house string by separting the attributes with "|"
                    //***************************************************************
                    
                    let houseString = houseName + "|" + houseRegion
                    print(houseString)
                    
                    //************************************************
                    // Add the new house string to the array of houses
                    //************************************************
                    
                    arrayOfHouses.append(houseString)
                }
                
            }
            catch let error as NSError {
                
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return
            }
            
        }
        else {
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

    /*
     --------------------------------------
     MARK: - Table View Data Source Methods
     --------------------------------------
     */
    
    // Asks the data source to return the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // Asks the data source to return the number of rows in a section, the number of which is given
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfHouses.count
    }

    //-------------------------------------
    // Prepare and Return a Table View Cell
    //-------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Identify the row number
        let rowNumber: Int = (indexPath as NSIndexPath).row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as UITableViewCell
        
        let houseAtRowNumber = arrayOfHouses[rowNumber]
        
        let houseData: [String] = (houseAtRowNumber as AnyObject).components(separatedBy: "|")
        
        /*
         houseData =
         [0] = houseName
         [1] = houseRegion
         */
        
        // Set House Name
        cell.textLabel!.text = houseData[0]
        cell.detailTextLabel!.text = houseData[1]
        
        return cell
    }

    /*
     -----------------------------------
     MARK: - Table View Delegate Methods
     -----------------------------------
     */
    
    //--------------------------
    // Selection of a Movie (Row)
    //--------------------------
    
    // Tapping a row (movie) displays a map of the city
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedHouse = arrayOfHouses[indexPath.row]
        
        // Perform the segue named MovieYouTube
        performSegue(withIdentifier: "House Details", sender: self)
    }
    
    // This is the method invoked when the user taps the Detail Disclosure button (circle icon with i)
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        // Obtain the youtube key of the movie whose Detail Disclosure button is tapped
        let houseData: [String] = (arrayOfHouses[indexPath.row] as AnyObject).components(separatedBy: "|")
        //youtubeURL = "http://www.youtube.com/embed/\(movieData[8])"
        
        // Perform the segue named SearchedMovieYouTube
        performSegue(withIdentifier: "House Wiki", sender: self)
    }
    
    /*
     -------------------------
     MARK: - Prepare For Segue
     -------------------------
     */
    
    // This method is called by the system whenever you invoke the method performSegue
    // You never call this method. It is invoked by the system.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "House Details" {
            
            // Obtain the object reference of the destination view controller
            let houseDetailsViewController: HouseDetailsViewController = segue.destination as! HouseDetailsViewController
            
            // Pass the data object to the destination view controller
            //searchedMovieDetailsViewController.selectedMoviePassed = selectedMovie
        }
        
        if segue.identifier == "House Wiki" {
            
            // Obtain the object reference of the destination view controller
            let houseWikiViewController: HouseWikiViewController = segue.destination as! HouseWikiViewController
            
            // Pass the data object to the destination view controller
            //searchedMovieYoutubeViewController.youtubeURL = youtubeURL
        }
    }

}
