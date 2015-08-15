//
//  MasterTableViewController.swift
//  todo3
//
//  Created by Luis on 2/12/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeedTVC: UITableViewController {
    
    var lQuestions = [Question]()
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        master = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register custom cell
        let nib = UINib(nibName: "QuestionTVCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: reusableCell_Id)
        
        //Nuevo codigo reloading...
        lQuestions = dataM.NFquestions
        self.tableView.reloadData()
        
        self.clearsSelectionOnViewWillAppear = true
        //Comentado porque no seran edititable de esa forma las preguntas.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: nil)
        println("Cell tapped at Feed")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lQuestions.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(reusableCell_Id, forIndexPath: indexPath) as! QuestionTVCell
        
        cell.tvc = "master"
        
        //Asginar lista de preguntas
        var question = lQuestions[indexPath.row]
        
        
        cell.qtyLabel.text = "# \(question.ido) k"//Cambia segun el objeto
        cell.questionText.text = question.question
        
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
