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
            // Sort out submenu
            let action: Selector?
            let submenu: NSMenu?
            let repo = project.repo
            var hasChanges: Bool = false
            if let repo = repo {
                action = nil
                submenu = NSMenu()
                if let statuses = repo.status().value {
                    //print(status)
                    hasChanges = statuses.count > 0
                    
                    if hasChanges {
                        var item = NSMenuItem(title: "Commit all changes ...", action: #selector(AppDelegate.commit(_:)), keyEquivalent: "")
                        item.target = NSApplication.shared.delegate
                        item.representedObject = project
                        submenu?.addItem(item)
                        
                        item = NSMenuItem(title: "Changes", action: nil, keyEquivalent: "")
                        
                        let changes = NSMenu()
                        
//                        let allFiles = FileManager.default.contents(atPath: project.path!)
                        
                        for change in statuses {
                            print(change)
                            let path = change.headToIndex?.newFile?.path ??
                                change.headToIndex?.oldFile?.path ??
                                change.indexToWorkDir?.newFile?.path ??
                                change.indexToWorkDir?.oldFile?.path ?? "Unknown path"
                            let info = FileInfo.init(project: project, path: path)
                            let title = change.status.toString() + " " + path
                            let changeItem = NSMenuItem(title: title, action: #selector(AppDelegate.revealInFinder(_:)), keyEquivalent: "")
                            changeItem.target = NSApplication.shared.delegate
                            changeItem.representedObject = info
                            changes.addItem(changeItem)
                        }
                        
                        item.submenu = changes
                        
                        submenu?.addItem(item)
                        
                        submenu?.addItem(.separator())
                    }
                }
                
                
                
                submenu?.addItem(.separator())
                
                var item = NSMenuItem(title: "Fetch", action: #selector(AppDelegate.fetch(_:)), keyEquivalent: "")
                item.target = NSApplication.shared.delegate
                item.representedObject = project
                submenu?.addItem(item)
                
                item = NSMenuItem(title: "Pull", action: #selector(AppDelegate.push(_:)), keyEquivalent: "")
                item.target = NSApplication.shared.delegate
                item.representedObject = project
                submenu?.addItem(item)
                
                item = NSMenuItem(title: "Push", action: #selector(AppDelegate.pull(_:)), keyEquivalent: "")
                item.target = NSApplication.shared.delegate
                item.representedObject = project
                submenu?.addItem(item)
                
                submenu?.addItem(.separator())
                
                item = NSMenuItem(title: "Remove project", action: #selector(AppDelegate.removeProject(_:)), keyEquivalent: "")
                item.target = NSApplication.shared.delegate
                item.representedObject = project
                submenu?.addItem(item)
            } else {
                action = nil
                submenu = nil
            }
            
            // Create project item
            let item = NSMenuItem(title: project.name ?? "Corrupted project", action: action, keyEquivalent: "")
            item.representedObject = project
            
            if hasChanges {
                item.makeBold()
            }
            
            // Add submenu and itself
            item.submenu = submenu
            items.append(item)
        }
        return items
    }
    

    
}
