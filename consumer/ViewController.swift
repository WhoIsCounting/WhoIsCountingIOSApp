//
//  ViewController.swift
//  consumer
//
//  Created by Luis on 2/23/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit
import AeroGearHttp
import AeroGearOAuth2

class ViewController: UIViewController {
    
    var http: Http!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // google translate
        DataManager.getTopAppsDataFromGoogleWithSuccess { (googleData) -> Void in
            let json = JSON(data: googleData)
            println(json.description)
          
            if let appName = json["timeZoneId"].string {
                println("Y entonces: \(appName)")
                //println(json["error"]["errors"][0]["domain"].string)
                //println(json["error"]["errors"][0]["reason"].string)
            }
            
            
            println("aqui vamos")
            self.http = Http()
            self.consumeAPI()
            println("hola")
        }
        /*
        DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
        // Get the number 1 app using optional binding and NSJSONSerialization
        //1
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
        options: NSJSONReadingOptions.AllowFragments,
        error:&parseError)
        
        //2
        if let topApps = parsedObject as? NSDictionary {
        if let feed = topApps["feed"] as? NSDictionary {
        if let apps = feed["entry"] as? NSArray {
        if let firstApp = apps[1] as? NSDictionary {
        if let imname = firstApp["im:name"] as? NSDictionary {
        if let appName = imname["label"] as? NSString {
        //3
        println("Optional Binding: \(appName)")
        }
        }
        }
        }
        }
        }
        }
        
        */
        
        DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
            // Get #1 app name using SwiftyJSON
            let json = JSON(data: data)
            if let appName = json["feed"]["entry"][0]["im:name"]["label"].string {
                println("SwiftyJSON: \(appName)")
            }
            
        }
        /*
        // Get the #1 app name from iTunes and SwiftyJSON
        DataManager.getTopAppsDataFromItunesWithSuccess { (iTunesData) -> Void in
        let json = JSON(data: iTunesData)
        if let appName = json["feed"]["entry"][0]["im:name"]["label"].string {
        println("NSURLSession: \(appName)")
        }
        
        
        //1
        if let appArray = json["feed"]["entry"].array {
        //2
        var apps = [AppModel]()
        
        //3
        for appDict in appArray {
        var appName: String? = appDict["im:name"]["label"].stringValue
        var appURL: String? = appDict["im:image"][0]["label"].stringValue
        
        var app = AppModel(name: appName, appStoreURL: appURL)
        apps.append(app)
        }
        
        //4
        println(apps)
        }
        }*/
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func consumeAPI() {
        println("Perform photo upload with Google Consume")
        
        let googleConfig = GoogleConfig(
            clientId: "115814606132-24i7f5psvb3547h3g4o67vri014p6nd0.apps.googleusercontent.com",
            scopes:["https://www.googleapis.com/auth/userinfo.email"])
        
        let gdModule = AccountManager.addGoogleAccount(googleConfig)
        self.http.authzModule = gdModule
        self.performUpload("https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/question", parameters: ["category":"Cultura", "question":"Sabes quienes fueron los Mayas?"])
    }
    
    func performUpload(url: String, parameters: [String: AnyObject]?) {
        self.http.POST(url, parameters: parameters, completionHandler: {(response, error) in
            if (error != nil) {
                self.presentAlert("Error", message: error!.localizedDescription)
            } else {
                self.presentAlert("Success", message: "Successfully uploaded!")
            }
        })
    }
    
    func presentAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}