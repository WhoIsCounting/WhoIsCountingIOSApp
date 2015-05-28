//
//  DataManager.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation
import AeroGearHttp
import AeroGearOAuth2
import SwiftyJSON


let TopAppURL = "https://itunes.apple.com/us/rss/topgrossingipadapplications/limit=25/json"
let TransURL = "https://maps.googleapis.com/maps/api/timezone/json?location=14.645736,-90.464987&timestamp=1331161200&key=AIzaSyBrSbWmtuiX7r9K-H1mH-h8JnluaZ7fEHc"

class DataManager {
    
    var http: Http!
    var questions = [Question]()
    
    
    init(){
    
    }
  
    class func getTopAppsDataFromGoogleWithSuccess(success: ((googleData: NSData!) -> Void)) {
        println("pilas1")
        //1
        loadDataFromURL(NSURL(string: TransURL)!, completion:{(data, error) -> Void in
            println("pilas2")
            //2
            if let urlData = data {
                //3
                success(googleData: urlData)
                println("pilas3")
                //self.shareWithGoogleDrive()
            }
        })
    }
    
    class func getTopAppsDataFromItunesWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: TopAppURL)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(iTunesData: urlData)
            }
        })
    }
    
  class func getTopAppsDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
    //1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      //2
      let filePath = NSBundle.mainBundle().pathForResource("TopApps",ofType:"json")
   
      var readError:NSError?
      if let data = NSData(contentsOfFile:filePath!,
        options: NSDataReadingOptions.DataReadingUncached,
        error:&readError) {
        success(data: data)
      }
    })
  }
  
  class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
    var session = NSURLSession.sharedSession()
    
    // Use NSURLSession to get data from an NSURL
    let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
      if let responseError = error {
        completion(data: nil, error: responseError)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
          var statusError = NSError(domain:"whos.glx", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
            //println(data.description)
          completion(data: nil, error: statusError)
        } else {
          completion(data: data, error: nil)
            println("pilas4")
        }
      }
    })
    
    loadDataTask.resume()
  }
    
    func post(params : Dictionary<String, String>, url : String) {
        
        /*
        let googleConfig = GoogleConfig(
            clientId: "115814606132-24i7f5psvb3547h3g4o67vri014p6nd0.apps.googleusercontent.com",
            scopes:["https://www.googleapis.com/auth/userinfo.email"])
        
        let gdModule =  OAuth2Module(config: googleConfig)
        var http = Http(baseURL: "https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/question" )
        http.authzModule = gdModule
        
        */
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
    
    
    

    func consumeAPI(url : String, dict : [String: AnyObject]?, success: ((responseData: AnyObject!) -> Void)){
        println("DataM Enter ConsumeAPI Func")
        
        getAPIAuth()
        
        self.postAPIData(url, parameters: dict, success:{ (data) in
            success(responseData: data!)
        })
    }
    
    func presentAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        //self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func postAPIData(url: String, parameters: [String: AnyObject]?, success: ((responseData: AnyObject!) -> Void)){
        self.http.POST(url, parameters: parameters, completionHandler: {(response, error) in
            if (error != nil) {
                //self.presentAlert("Error", message: error!.localizedDescription)
                println("Error " + error!.localizedDescription)
            } else {
                //self.presentAlert("Success", message: "Successfully uploaded!")
                println("Success")
                println(response!)
                success(responseData: response!)
            }
        })
    }
    
    func getAPIGetQuestionsCreated(completion: ((responseData: AnyObject!) -> Void)) {
        println("Perform getAPIProfile")
        self.getAPIAuth()
        self.getAPIData("https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/getQuestionsCreated", success:{ (data) in
            completion(responseData: data)
        })
    }
    
    func getAPIProfile(completion: ((responseData: AnyObject!) -> Void)) {
        println("Perform getAPIProfile")
        self.getAPIAuth()
        self.getAPIData("https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/profile",
            success:{ (data) in
            completion(responseData: data)
        })
    }
    
    func getAPIQueryQuestions(completion: ((responseData: AnyObject!) -> Void)) {
        println("ENTRADA: getAPIQueryQuestions")
        self.getAPIAuth()
        self.getAPIData("https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/queryQuestions",
            success:{ (data) in
                completion(responseData: data)
        })
        /*self.postAPIData("https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/queryQuestions", parameters: dict, success:{ (data) in
            success(responseData: data!)
        })*/
    }
    
    func getAPIData(url: String,success: ((responseData: AnyObject!) -> Void)){
        self.http.GET(url, completionHandler: {(response, error) in
            println("GET Method getAPIData Done LX")
            if (error != nil) {
                self.presentAlert("Error", message: error!.localizedDescription)
                println("Error" + error!.localizedDescription)
                success(responseData: nil)
            } else {
                self.presentAlert("Success", message: "Successfully uploaded!")
                //println("Success \n\(response!)")
                
                success(responseData: response!)
            }
        })
    }
    
    func prueba01API(url : String, dict : [String: AnyObject]?, success: ((responseData: AnyObject!) -> Void)){
        println("DataM Enter  Func")
        
        getAPIAuth()
        
        self.postAPIData(url, parameters: dict, success:{ (data) in
            success(responseData: data!)
        })
    }
    
    
    
    func getAPIAuth() {
        http = Http()
        let googleConfig = GoogleConfig(
            clientId: "115814606132-24i7f5psvb3547h3g4o67vri014p6nd0.apps.googleusercontent.com",
            scopes:["https://www.googleapis.com/auth/userinfo.email"])
        let gdModule = AccountManager.addGoogleAccount(googleConfig)
        self.http.authzModule = gdModule
        /*
        let credential = NSURLCredential(user: "lx.galvez@gmail.com",
        password: "Lum20ggl",
        persistence: .None)
        */
    }
    
    func getQuestions() {
        consumeAPI("https://whos-counting-1.appspot.com/_ah/api/whoscounting/v1/queryQuestions", dict: Dictionary())  { (googleData) -> Void in
            let json = JSON(googleData)

            
            if let items = json["items"].array{
              
                
                for item in items{
                    self.questions.append(Question(nsmdict: item.object as! NSMutableDictionary))
                }
            }
        }
        
    }
}