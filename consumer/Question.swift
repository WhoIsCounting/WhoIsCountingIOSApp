//
//  Question.swift
//  todo3
//
//  Created by Luis on 2/19/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit
import SwiftyJSON

class Question {
   
    var question: String = ""
    var count: String = "0"
    var answered: Bool = false
    var category = [String]()
    var id: String = ""
    var ido: Int = 0
    var popularity: Int = 0
    var askerDisplayName: String = ""
    var websafeKey: String = ""
    
    var diccionario: NSMutableDictionary = NSMutableDictionary()
    
    /*init(inicio q: String, c: String, a: Bool){
        question = q
        count = c
        answered = a
    }*/
    
    
    func plusCount()-> String {
        //Ver si se puede cambiar a let
        var c: Int? = count.toInt()!
        if (c != nil){
            c = c! + 1;
            count = "\(c)";
            answered = true
            return count
        } else {
            return "0"
        }
    }
    
    
    /*init(diccionario d: Dictionary){
        question = d.objectForKey("itemTitle") as! String
        count = d.objectForKey("itemCount")as! String
        answered = true
    }*/
    
    init(nsmdict dict: NSMutableDictionary){
        //Inicializar los atributos de la clase
        diccionario = dict
        
        question = dict.objectForKey("question") as! String
        count = dict.objectForKey("iDo") as! String
        answered = false
        
        category = ["","",""]
        
        id = dict.objectForKey("askerUserId") as! String
        ido = (dict.objectForKey("iDo") as! String).toInt()!
        popularity = (dict.objectForKey("popularity") as! String).toInt()!
        
        askerDisplayName = dict.objectForKey("askerDisplayName") as! String
        websafeKey = dict.objectForKey("websafeKey") as! String
    }
    
    
    func getDict()-> NSMutableDictionary {
        
        var d: NSMutableDictionary = NSMutableDictionary()
        
        
        return d
    }
}