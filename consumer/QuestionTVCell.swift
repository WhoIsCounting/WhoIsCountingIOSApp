//
//  TblVwCell.swift
//  todo3
//
//  Created by Luis on 2/13/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit

class QuestionTVCell: UITableViewCell {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var askerLabel: UILabel!
    
    var indice:NSIndexPath = NSIndexPath()
    var toDoData:NSMutableDictionary = NSMutableDictionary()
    
    var tvc : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        println("tapped index \(indice.row) and # \(count)")
        println(" \(question.ido)")
    }

}
