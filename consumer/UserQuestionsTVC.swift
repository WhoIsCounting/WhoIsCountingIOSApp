//
//  TVCUserQuestions.swift
//  consumer
//
//  Created by Luis on 2/25/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserQuestionsTVC: UITableViewController {

    var toDoItems:NSMutableArray = NSMutableArray()
    var json:JSON!
    var rows:Int = 0
    
    var lQuestions = [Question]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        userQ = self
        
        /* Descomentar luego por si funciona...
        dataM.consumeAPI("https://whos-counting-1.appspot.com/_ah/api/whosCounting/v1/getQuestionsCreated", dict: Dictionary()) { (googleData) -> Void in
            self.json = JSON(googleData)
            
            println(self.json.description)
            
            if let displayName = self.json["displayName"].string {
                //self.displayNameTxtF.text = displayName
            }
            if let mainEmail = self.json["mainEmail"].string {
                //self.mainEmailTxtF.text = mainEmail
            }
            if let country = self.json["country"].string {
                //self.countryTxtF.text = country
            }
            if let gender = self.json["gender"].string {
                //self.genderTxtF.text = gender
            }
            
            println(self.json["items"][0]["question"].string!)
            
            if let camino = self.json["items"][0]["ido"].int  {
                println(camino)
            }
            
            
            println(self.json["items"][1]["question"].string!+" espacio")
            println(self.json["items"].count)
            
            //println(self.toDoItems.objectAtIndex(0)["itemCount"])
            //let s: String = self.toDoItems[0]["itemTitle"] as String
            //println(s)
            
            //self.toDoItems = json["items"].array
            self.rows = self.json["items"].count
        }*/
        
    }
    
    /*override init(style: UITableViewStyle) {
    super.init(style: style)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register custom cell
        var nib = UINib(nibName: "QuestionTVCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: reusableCell_Id)
        
        lQuestions = dataM.MYquestions
        
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) { //Es llamada cada vez que la vista aparece, mientras que viewDidLoad es llamada únicamente la primera vez
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        if (itemListFromUserDefaults != nil) {
            //toDoItems = itemListFromUserDefaults!
        }
        
        self.tableView.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: nil)
        println("Cell tapped at UserQuestionsTVC")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lQuestions.count
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TblVwCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as TblVwCell
        var toDoItem:NSDictionary = toDoItems.objectAtIndex(indexPath.row) as NSDictionary
        
    
        var count: Int
        if (toDoItem.objectForKey("itemCount") != nil) {
            count = toDoItem.objectForKey("itemCount") as Int!
        } else { count = 0}
        
        cell.labelOLName.text = "# \(count) k"
        cell.tvOLName.text = toDoItem.objectForKey("itemTitle") as? String
        cell.tvOLName.userInteractionEnabled = false;
        
        cell.buttonOLName.setTitle("I Did", forState: UIControlState.Normal) //Nombre del boton
        
        //Para actualizar la tabla desde la celda
        cell.indice = indexPath
        cell.toDoData = toDoItems.objectAtIndex(indexPath.row) as NSMutableDictionary
        
        return cell
    }
    */
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(reusableCell_Id, forIndexPath: indexPath) as! QuestionTVCell
        cell.tvc = "master"
        
        //Asginar lista de preguntas
        var question = lQuestions[indexPath.row]
        
        
        cell.qtyLabel.text = "# \(question.ido) k"//Cambia segun el objeto
        cell.questionText.text = question.question
        
        cell.askerLabel.text = "@"+question.askerDisplayName
        
        cell.button.setTitle("I Did", forState: UIControlState.Normal) //Nombre del boton
        
        //Para actualizar la tabla desde la celda
        cell.indice = indexPath
        cell.toDoData = question.diccionario
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat { //Método para darle altura a cada fila
        return 100
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if (segue != nil && segue!.identifier == "showDetail") {
            var selectedIndexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            var detailViewController: QuestionDetailVC = segue!.destinationViewController as! QuestionDetailVC
            detailViewController.row = selectedIndexPath.row
        }
    }
    
    
    
}
