//
//  GitStatus+Helpers.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 29/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import SwiftGit2


extension SwiftGit2.Diff.Status {
    
    func toString() -> String {
        switch true {
        case self.rawValue == Diff.Status.indexNew.rawValue:
            return "[A]"
        case self.rawValue == Diff.Status.conflicted.rawValue:
            return "[C]"
        case self.rawValue == Diff.Status.indexDeleted.rawValue:
            return "[D]"
        case self.rawValue == Diff.Status.indexModified.rawValue:
            return "[M]"
        case self.rawValue == Diff.Status.workTreeNew.rawValue:
            return "[A]"
        case self.rawValue == Diff.Status.indexTypeChange.rawValue:
            return "[M]"
        case self.rawValue == Diff.Status.workTreeUnreadable.rawValue:
            return "[Unreadable]"
        case self.rawValue == Diff.Status.workTreeDeleted.rawValue:
            return "[D]"
        case self.rawValue == Diff.Status.workTreeModified.rawValue:
            return "[M]"
        case self.rawValue == Diff.Status.workTreeRenamed.rawValue:
            return "[D]"
        case self.rawValue == Diff.Status.workTreeRenamed.rawValue:
            return "[R]"
        case self.rawValue == 256:
            return "[M]"
        case self.rawValue == 257:
            return "[A]"
        case self.rawValue == Diff.Status.ignored.rawValue:
            return "[Ignored]"
        default:
            print(self)
            return "[?]"
        }
    }
    
}
