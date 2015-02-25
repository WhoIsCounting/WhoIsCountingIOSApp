//
//  Question.swift
//  todo3
//
//  Created by Luis on 2/19/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import UIKit

class Question {
   
    var question: String = ""
    var count: String = "0"
    var answered: Bool = false
    
    init(inicio q: String, c: String, a: Bool){
        question = q
        count = c
        answered = a
    }
    
    
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
    
    
    init(diccionario d: NSMutableDictionary){
        question = d.objectForKey("itemTitle") as String
        count = d.objectForKey("itemCount") as String
        answered = true
    }
    
    
    func getDict()-> NSMutableDictionary {
        
        var d: NSMutableDictionary = NSMutableDictionary()
        
        
        return d
    }
}