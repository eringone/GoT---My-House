
//
//  HouseWikiViewController.swift
//  GoT - My House
//
//  Created by Erin Gaughan on 11/30/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit
import WebKit

class HouseWikiViewController: UIViewController, WKNavigationDelegate {
    
    /*
     Instance variable holding the object reference of the Web View (UIWebView)
     object created in the Storyboard.
     */
    @IBOutlet var webView: WKWebView!
    @IBOutlet var titleLabel: UINavigationItem!
    
    var wikiURL = ""
    var houseTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.title = houseTitle
        
        /*
         URL is a Swift Structure!
         
         "A URL is a Swift [Structure] type that can potentially contain the location of
         a resource on a remote server, the path of a local file on disk, ..." [Apple]
         
         Create an Instance of the URL Structure, initialize it with websiteURL
         and store its unique ID into the local constant "url".
         */
        let url = URL(string: wikiURL)
        
        /*
         URLRequest is a Swift Structure!
         
         Create an Instance of the URLRequest Structure, initialize it with the "url"
         local constant value, and store its unique ID into the local constant "request".
         */
        let request = URLRequest(url: url!)
        
        // Ask the webView object to load the web page for the given URL request
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     ---------------------------------------------
     MARK: - WKNavigationDelegate Protocol Methods
     ---------------------------------------------
     */
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Starting to load the web page. Show the animated activity indicator in the status bar
        // to indicate to the user that the UIWebVIew object is busy loading the web page.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Finished loading the web page. Hide the activity indicator in the status bar.
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        /*
         Ignore this error if the page is instantly redirected via JavaScript or in another way.
         NSURLErrorCancelled is returned when an asynchronous load is cancelled, which happens
         when the page is instantly redirected via JavaScript or in another way.
         */
        
        if (error as NSError).code == NSURLErrorCancelled  {
            return
        }
        
        // An error occurred during the web page load. Hide the activity indicator in the status bar.
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // Create the error message in HTML as a character string and store it into the local constant errorString
        let errorString = "<html><font size=+4 color='red'><p>Unable to Display Webpage: <br />Possible Causes:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>" + error.localizedDescription
        
        // Display the error message within the UIWebView object
        // self. is required here since this method has a parameter with the same name.
        self.webView.loadHTMLString(errorString, baseURL: nil)
    }

}
