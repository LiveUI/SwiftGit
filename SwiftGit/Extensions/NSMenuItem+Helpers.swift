//
//  NSMenuItem+Helpers.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Cocoa


extension NSMenuItem {
    
    var project: Project {
        guard let project = representedObject as? Project else {
            fatalError("This should never happen")
        }
        return project
    }
    
}
