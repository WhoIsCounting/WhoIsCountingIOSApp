//
//  AddViewController.swift
//  todo3
//
//  Created by Luis on 2/12/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    
    @IBOutlet weak var categoryTxtF: UITextView! = UITextView()
    @IBOutlet weak var questionTxtV: UITextView! = UITextView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //questionTxtV //para que tenga el focos al cargar la vista ????
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        
        var jsonStr : [String: AnyObject] = ["category":"\(categoryTxtF.text)", "question":"\(questionTxtV.text)"]
        dataM.consumeAPI("https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/question", dict: jsonStr)  { (googleData) -> Void in
        }
    
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        var dataSet:NSMutableDictionary = NSMutableDictionary()
        dataSet.setObject(questionTxtV.text, forKey: "itemTitle") //Key para la pregunta en UserDefaults
        dataSet.setObject(categoryTxtF.text, forKey: "itemNote") //Key para la categoría en UserDefaults
        dataSet.setObject(0 as Int, forKey: "itemCount") //Key para la cuenta en UserDefaults
        
        
        if ((itemList) != nil){ //data already available
            var newMutableList:NSMutableArray = NSMutableArray()
            
            for dict:AnyObject in itemList! {
                newMutableList.addObject(dict as! NSDictionary)
            }
            userDefaults.removeObjectForKey("itemList")
            newMutableList.addObject(dataSet)
            userDefaults.setObject(newMutableList, forKey: "itemList")
            
        } else { //This is the first todo item in the list
            userDefaults.removeObjectForKey("itemList")
            itemList = NSMutableArray()
            itemList!.addObject(dataSet)
            userDefaults.setObject(itemList, forKey: "itemList")
            
        }
        userDefaults.synchronize()
        
        //Regresa al NavController origen
        self.navigationController?.popToRootViewControllerAnimated(true)
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
