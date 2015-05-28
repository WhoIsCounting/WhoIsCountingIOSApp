//
//  MasterTableViewController.swift
//  todo3
//
//  Created by Luis on 2/12/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterTableViewController: UITableViewController {
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        master = self
    }

    override func viewDidAppear(animated: Bool) { //Es llamada cada vez que la vista aparece, mientras que viewDidLoad es llamada únicamente la primera vez
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Register custom cell
        var nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Nuevo codigo reloading...
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: nil)
        println("Cell tapped at News Feed TableView Controller") //Debug
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //Esta en la app debe de ser uno porque las secciones son como los encabezados de las letras en la lista de contactos
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Acá debe colocarse el número de preguntas que se quiera mostrar y haya obtenido de la DB.
        println(dataM.NFquestions.count)
        return dataM.NFquestions.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TblVwCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TblVwCell
        cell.tvc = "master"
        //var toDoItem:NSDictionary = toDoItems.objectAtIndex(indexPath.row) as! NSDictionary
        var question = dataM.NFquestions[indexPath.row]
        
        
        cell.labelOLName.text = "# \(question.ido) k"//Cambia segun el objeto
        cell.tvOLName.text = question.question
        cell.tvOLName.userInteractionEnabled = false;
        
        cell.buttonOLName.setTitle("I Did", forState: UIControlState.Normal) //Nombre del boton
        
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
            var detailViewController: DetailViewController = segue!.destinationViewController as! DetailViewController
            detailViewController.row = selectedIndexPath.row
            
        }
    }
}
