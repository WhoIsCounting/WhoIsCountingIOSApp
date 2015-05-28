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

class DataManager {
    
    var http: Http = Http()
    var NFquestions = [Question]()
    var DOquestions = [Question]()
    var MYquestions = [Question]()
    
    init(){
        getAPIAuth()
        getAPIQueryQuestions()
        getAPIGetQuestionsCreated()
    }
  
    func getAPIAuth() {
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
    
    func postAPIData(url: String, parameters: [String: AnyObject]?, success: ((responseData: AnyObject!) -> Void)){
        self.http.POST(url, parameters: parameters, completionHandler: {(response, error) in
            if (error != nil) {
                
                println("Error (lx) " + error!.localizedDescription )
                println(response!)
            } else {
                
                println("Success (lx)")
                println(response!)
                success(responseData: response!)
            }
        })
    }
    
    func getAPIData(url: String,success: ((responseData: AnyObject!) -> Void)){
        self.http.GET(url, completionHandler: {(response, error) in
            println("GET Method getAPIData Done LX")
            if (error != nil) {
                //self.presentAlert("Error", message: error!.localizedDescription)
                println("Error" + error!.localizedDescription)
                success(responseData: nil)
            } else {
                //self.presentAlert("Success", message: "Successfully uploaded!")
                //println("Success \n\(response!)")
                
                success(responseData: response!)
            }
        })
    }
    
    func getAPIQueryQuestions() {
        //GET https://whos-counting-1.appspot.com/_ah/api/whoscounting/v1/questions/ido
        
        postAPIData("https://whos-counting-1.appspot.com/_ah/api/whoscounting/v1/queryQuestions", parameters: Dictionary())  { (googleData) -> Void in
            let json = JSON(googleData)

            if let items = json["items"].array{
                for item in items{
                    self.NFquestions.append(Question(nsmdict: item.object as! NSMutableDictionary))
                }
            }
        }
    }
    
    func getAPIGetQuestionsCreated() {
        postAPIData("https://whos-counting-1.appspot.com/_ah/api/whoscounting/v1/getQuestionsCreated", parameters: Dictionary()) { (googleData) -> Void in
            let json = JSON(googleData)
            
            if let items = json["items"].array{
                for item in items{
                    self.MYquestions.append(Question(nsmdict: item.object as! NSMutableDictionary))
                }
            }
        }
    }
    
    func getAPIProfile(completion: ((responseData: AnyObject!) -> Void)) {
        println("Perform getAPIProfile")
        //self.getAPIAuth()
        self.getAPIData("https://whos-counting-1.appspot.com/_ah/api/whoscounting/v1/profile",
            success:{ (data) in
                completion(responseData: data)
        })
    }
}