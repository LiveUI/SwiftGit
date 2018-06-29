//
//  FileInfo.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 29/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation


struct FileInfo {
    
    let project: Project
    
    let path: String
    
}

extension FileInfo {
    
    var fullPath: String {
        let url = URL(fileURLWithPath: path, relativeTo: URL(fileURLWithPath: project.path!, isDirectory: true))
        return url.path
    }
    
}
