//
//  NSMenu+Helpers.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Cocoa


extension NSMenu {
    
    func add(items: [NSMenuItem]) {
        items.forEach({ addItem($0) })
    }
    
    func add(projects: [Project]) {
        add(items: projects.asMenuItems())
    }
    
}
