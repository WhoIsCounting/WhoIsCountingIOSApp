//
//  TblVwCell.swift
//  todo3
//
//  Created by Luis on 2/13/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit

class TblVwCell: UITableViewCell {

    required init(coder aDecoder: NSCoder) {
        //self.tabla = MasterTableViewController(coder: aDecoder)
        super.init(coder: aDecoder)
        
    }
    

    //@IBOutlet weak var buttonOLName: UIButton!
    @IBOutlet weak var labelOLName: UILabel!
    @IBOutlet weak var tvOLName: UITextView!
    @IBOutlet weak var buttonOLName: UIButton!
    
    var indice:NSIndexPath = NSIndexPath()
    var toDoData:NSMutableDictionary = NSMutableDictionary()
    
    var tvc : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func iDoAction(sender: AnyObject) {
        
        
        var selectedIndexPath: NSIndexPath = indice
        
        
        var userDefaults:NSUserDefaults = NSUserDefaults()
        var itemListArray:NSMutableArray = userDefaults.objectForKey("itemList") as! NSMutableArray
        var mutableItemList:NSMutableArray = NSMutableArray()
        
        for dict:AnyObject in itemListArray {
            mutableItemList.addObject(dict as! NSDictionary)
            
        }
        
        var count: Int?
        if (toDoData.objectForKey("itemCount") != nil) {
            count = toDoData.objectForKey("itemCount") as? Int
            count = count! + 1
        } else { count = 1}
        
        var dataSet:NSMutableDictionary = NSMutableDictionary()
        dataSet.setObject(toDoData.objectForKey("itemTitle")!, forKey: "itemTitle")
        dataSet.setObject(toDoData.objectForKey("itemNote")!, forKey: "itemNote")
        dataSet.setObject(count!, forKey: "itemCount")
        
        mutableItemList.insertObject(dataSet, atIndex: indice.row)
        mutableItemList.removeObject(toDoData)
        
        userDefaults.removeObjectForKey("itemList")
        userDefaults.setObject(mutableItemList, forKey: "itemList")
        userDefaults.synchronize()
        
        
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        if (tvc == "master") {
            var fromUserDefaults:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
            if (fromUserDefaults != nil) {
                master.toDoItems = fromUserDefaults!
                master.tableView!.reloadData()
            }
        }
        
        //Debug
        println("tapped index \(indice.row) and # \(count!)")
    }

}
