//
//  DetailViewController.swift
//  todo3
//
//  Created by Luis on 2/12/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit

class QuestionDetailVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField! = UITextField()
    @IBOutlet weak var notesTextView: UITextView! = UITextView()
    
    var row = Int()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var question = dataM.NFquestions[row]
        
        titleTextField.userInteractionEnabled=false
        notesTextView.userInteractionEnabled=false
        
        titleTextField.text = question.question
        notesTextView.text = "hola"//question.category
        // Do any additional setup after loading the view.
    }

    @IBAction func deleteItem(sender: AnyObject) {
        
        var userDefaults:NSUserDefaults = NSUserDefaults()
        var itemListArray:NSMutableArray = userDefaults.objectForKey("itemList") as! NSMutableArray
        var mutableItemList:NSMutableArray = NSMutableArray()
        
        for dict:AnyObject in itemListArray {
         mutableItemList.addObject(dict as! NSDictionary)
            
        }
        
        //mutableItemList.removeObject(toDoData)
        userDefaults.removeObjectForKey("itemList")
        userDefaults.setObject(mutableItemList, forKey: "itemList")
        userDefaults.synchronize()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
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
