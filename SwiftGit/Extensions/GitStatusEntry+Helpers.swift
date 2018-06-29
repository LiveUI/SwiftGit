//
//  GitStatusEntry+Helpers.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 29/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import SwiftGit2


extension StatusEntry {
    
    var filePath: String {
        return headToIndex?.newFile?.path ??
            headToIndex?.oldFile?.path ??
            indexToWorkDir?.newFile?.path ??
            indexToWorkDir?.oldFile?.path ?? "Unknown path"
    }
    
    var title: String {
        return status.toString() + " " + filePath
    }
    
}
