//
//  Projects.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Cocoa
import Reloaded


class Projects {
    
    static func addProject() {
        let dialog = NSOpenPanel()
        dialog.title = "Add new project ..."
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = true
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            for url in dialog.urls {
                let name = url.lastPathComponent
                let spm = try! Project.new()
                spm.name = name
                spm.path = url.path
                try? spm.save()
            }
        } else {
            return
        }
    }
    
    static func removeAllProjects() {
        Project.all().forEach({ try! $0.delete() })
    }
    
    static func remove(_ project: Project) {
        try! project.delete()
        try! CoreData.saveContext()
    }
    
}
