//
//  Projects+MenuItems.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Cocoa


extension Array where Element: Project {
    
    func asMenuItems() -> [NSMenuItem] {
        var items: [NSMenuItem] = []
        for project in self {
            let item = NSMenuItem(title: project.name ?? "Corrupted project", action: nil, keyEquivalent: "")
            item.representedObject = project
            items.append(item)
        }
        return items
    }
    
}
