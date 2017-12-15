//
//  HousesTableViewController.swift
//  GoT - My House
//
//  Created by Erin Gaughan on 11/30/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit

class HousesTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let MINT_CREAM = UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    let OLD_LACE = UIColor(red: 253.0/255.0, green: 245.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    // Instance Variables
    var arrayOfHouses = [String]()
    var arrayOfHousesArray = [[[String]]]()
    var selectedHouse = ""
    var selectedArray = [[String]]()
    var wikiURL = ""
    
    // These two instance variables are used for Search Bar functionality
    var searchResults = [String]()
    var searchResultsArray = [[[String]]]()
    var searchResultsController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Comment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        
        for i in 1 ..< 10{

            let search = "https://www.anapioficeandfire.com/api/houses?page=" + String(i) + "&pageSize=50"
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
                    
                    for index in 0 ..< jsonDataDictionary.count {
                        
                        // Typecast the returned NSDictionary as Dictionary<String, AnyObject>
                        let houseIndex = jsonDataDictionary[index] as! NSDictionary
                        
                        var houseName = ""
                        if let path = houseIndex["name"] as? String? {
                            houseName = path!
                        }
                        
                        var houseRegion = ""
                        if let path = houseIndex["region"] as? String? {
                            houseRegion = path!
                        }
                        
                        var coatOfArms = ""
                        if let path = houseIndex["coatOfArms"] as? String? {
                            coatOfArms = path!
                        }
                        
                        var words = ""
                        if let path = houseIndex["words"] as? String? {
                            words = path!
                        }
                        
                        var titles: [String] = []
                        if let path = houseIndex["titles"] as? [String]? {
                            titles = path!
                        }
                        
                        var seats: [String] = []
                        if let path = houseIndex["seats"] as? [String]? {
                            seats = path!
                        }
                        
                        var currentLord = ""
                        if let path = houseIndex["currentLord"] as? String? {
                            currentLord = path!
                        }
                        
                        var heir = ""
                        if let path = houseIndex["heir"] as? String? {
                            heir = path!
                        }
                        
                        var founded = ""
                        if let path = houseIndex["founded"] as? String? {
                            founded = path!
                        }
                        
                        var founder = ""
                        if let path = houseIndex["founder"] as? String? {
                            founder = path!
                        }
                        
                        var swornMembers: [String] = []
                        if let path = houseIndex["swornMembers"] as? [String]? {
                           swornMembers = path!
                        }
                        
                        //***************************************************************
                        // Compose the house string by separting the attributes with "|"
                        //***************************************************************
                        
                        let houseString = houseName + "|" + houseRegion + "|" + coatOfArms + "|" + words + "|" + "titles" +
                            "|" + "seats" + "|" + currentLord + "|" + heir + "|" + founded + "|" + founder + "|" + "swornMembers"
                        
                        let houseNameArray = [houseName]
                        let houseArray = [titles, seats, swornMembers, houseNameArray]
                        
                        //************************************************
                        // Add the new house string to the array of houses
                        //************************************************
                        
                        arrayOfHouses.append(houseString)
                        arrayOfHousesArray.append(houseArray)
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
        
        createSearchResultsController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     ---------------------------------------------
     MARK: - Creation of Search Results Controller
     ---------------------------------------------
     */
    func createSearchResultsController() {
        /*
         Instantiate a UISearchController object and store its object reference into local variable: controller.
         Setting the parameter searchResultsController to nil implies that the search results will be displayed
         in the same view used for searching (under the same UITableViewController object).
         */
        let controller = UISearchController(searchResultsController: nil)
        
        /*
         We use the same table view controller (self) to also display the search results. Therefore,
         set self to be the object responsible for listing and updating the search results.
         Note that we made self to conform to UISearchResultsUpdating protocol.
         */
        controller.searchResultsUpdater = self
        
        /*
         The property dimsBackgroundDuringPresentation determines if the underlying content is dimmed during
         presentation. We set this property to false since we are presenting the search results in the same
         view that is used for searching. The "false" option displays the search results without dimming.
         */
        controller.dimsBackgroundDuringPresentation = false
        
        controller.searchBar.delegate = self
        controller.searchBar.placeholder = "Search Houses"
        
        // Resize the search bar object based on screen size and device orientation.
        controller.searchBar.sizeToFit()
        
        /***************************************************************************
         No need to create the search bar in the Interface Builder (storyboard file).
         The statement below creates it at runtime.
         ***************************************************************************/
        
        // Set the tableHeaderView's accessory view displayed above the table view to display the search bar.
        self.tableView.tableHeaderView = controller.searchBar
        
        /*
         Set self (Table View Controller) define the presentation context so that the Search Bar subview
         does not show up on top of the view (scene) displayed by a downstream view controller.
         */
        self.definesPresentationContext = true
        
        /*
         Set the object reference (controller) of the newly created and dressed up UISearchController
         object to be the value of the instance variable searchResultsController.
         */
        searchResultsController = controller
    }
    
    /*
     -----------------------------------------------
     MARK: - UISearchResultsUpdating Protocol Method
     -----------------------------------------------
     
     This UISearchResultsUpdating protocol required method is automatically called whenever the search
     bar becomes the first responder or changes are made to the text or scope of the search bar.
     You must perform all required filtering and updating operations inside this method.
     */
    func updateSearchResults(for searchController: UISearchController)
    {
        // Empty the instance variable searchResults array without keeping its capacity
        searchResults.removeAll(keepingCapacity: false)
        
        // Set searchPredicate to search for any character(s) the user enters into the search bar.
        // [c] indicates that the search is case insensitive.
        //let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        // Obtain the university names that contain the character(s) the user types into the Search Bar.
        //let listOfHousesFound = (arrayOfHouses as NSArray).filtered(using: searchPredicate)
        
        var listOfHousesFound = [String]()
        let searchPredicate = searchController.searchBar.text!.lowercased()
        for i in 0 ..< arrayOfHouses.count {
            let houseData: [String] = (arrayOfHouses[i] as AnyObject).components(separatedBy: "|")
            if houseData[0].lowercased().contains(searchPredicate) {
                listOfHousesFound.append(arrayOfHouses[i])
            }
        }
        
        // Obtain the search results as an array of type String
        searchResults = listOfHousesFound
        
        // Reload the table view to display the search results
        self.tableView.reloadData()
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
        
        return searchResultsController.isActive ? searchResults.count : arrayOfHouses.count
    }

    //-------------------------------------
    // Prepare and Return a Table View Cell
    //-------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Identify the row number
        let rowNumber: Int = (indexPath as NSIndexPath).row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as UITableViewCell
        
        let houseAtRowNumber = searchResultsController.isActive ? searchResults[rowNumber] : arrayOfHouses[rowNumber]
        
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
        
        selectedHouse = searchResultsController.isActive ? searchResults[(indexPath as NSIndexPath).row] : arrayOfHouses[indexPath.row]
        
        if searchResultsController.isActive {
            let houseData: [String] = (selectedHouse as AnyObject).components(separatedBy: "|")
            let house = houseData[0]
            
            for j in 0 ..< arrayOfHousesArray.count {
                if arrayOfHousesArray[j][3][0] == house {
                    selectedArray = arrayOfHousesArray[j]
                }
            }
            
        }
        else {
            selectedArray = arrayOfHousesArray[indexPath.row]
        }
        
        // Perform the segue named MovieYouTube
        performSegue(withIdentifier: "House Details", sender: self)
    }
    
    // This is the method invoked when the user taps the Detail Disclosure button (circle icon with i)
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let houseChosen = searchResultsController.isActive ? searchResults[(indexPath as NSIndexPath).row] : arrayOfHouses[indexPath.row]
        
        // Obtain the youtube key of the movie whose Detail Disclosure button is tapped
        let houseData: [String] = (houseChosen as AnyObject).components(separatedBy: "|")
        let house: [String] = (houseData[0] as AnyObject).components(separatedBy: " ")
        
        let houseName = house[0] + "_" + house[1]
        wikiURL = "http://awoiaf.westeros.org/index.php/" + houseName
        
        // Perform the segue named SearchedMovieYouTube
        performSegue(withIdentifier: "House Wiki", sender: self)
    }
    
    // alternate row colors
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).row % 2 == 0 {
            cell.backgroundColor = MINT_CREAM
        } else {
            
            cell.backgroundColor = OLD_LACE
        }
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
            houseDetailsViewController.selectedHouse = selectedHouse
            houseDetailsViewController.selectedArray = selectedArray
        }
        
        if segue.identifier == "House Wiki" {
            
            // Obtain the object reference of the destination view controller
            let houseWikiViewController: HouseWikiViewController = segue.destination as! HouseWikiViewController
            
            // Pass the data object to the destination view controller
            houseWikiViewController.wikiURL = wikiURL //"http://awoiaf.westeros.org/index.php/House_Algood"
        }
    }

}
