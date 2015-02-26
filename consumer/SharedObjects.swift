//
//  SharedObjects.swift
//  consumer
//
//  Created by Luis on 2/25/15.
//  Copyright (c) 2015 whos. All rights reserved.
//

import Foundation

class SharedObjects{

    var master: MasterTableViewController
    
    init(){
        let coder : NSCoder = NSCoder()
        master = MasterTableViewController(coder: coder)
    }


}