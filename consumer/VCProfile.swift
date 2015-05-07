//
//  VCProfile.swift
//  consumer
//
//  Created by Luis on 2/24/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit

class VCProfile: UIViewController {
    
    @IBOutlet weak var displayNameTxtF: UITextField! = UITextField()
    @IBOutlet weak var mainEmailTxtF: UITextField! = UITextField()
    @IBOutlet weak var countryTxtF: UITextField! = UITextField()
    @IBOutlet weak var genderTxtF: UITextField! = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataM.getAPIProfile() { (googleData) -> Void in
            println("hola \(googleData)")
            let json = JSON(googleData)
            
            println(json.description)
            
            if let displayName = json["displayName"].string {
                self.displayNameTxtF.text = displayName
            }
            if let mainEmail = json["mainEmail"].string {
                self.mainEmailTxtF.text = mainEmail
            }
            if let country = json["country"].string {
                self.countryTxtF.text = country
            }
            if let gender = json["gender"].string {
                self.genderTxtF.text = gender
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
