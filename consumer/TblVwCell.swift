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
        var question = dataM.MYquestions[indice.row]
        
        
        var count: Int
        count = question.ido + 1
        
        question.ido = count
        
        if (tvc == "master") {
            master.tableView!.reloadData()
        }
        
        //Debug
        //println("tapped index \(indice.row) and # \(count)")
        //println(" \(question.ido)")
    }

}
