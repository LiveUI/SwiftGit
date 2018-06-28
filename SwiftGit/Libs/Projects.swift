//
//  Projects.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Cocoa


class Projects {
    
    static func addProject() {
        let dialog = NSOpenPanel()
        dialog.title = "Add new project ..."
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let name = dialog.url!.lastPathComponent
            let spm = try! Project.new()
            spm.name = name
            spm.path = dialog.url!.path
            try? spm.save()
        } else {
            return
        }
    }
    
    @objc func aaaa() {
        
    }
    
}
