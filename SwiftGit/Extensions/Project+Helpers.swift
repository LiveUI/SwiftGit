//
//  Project+Helpers.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Reloaded
import SwiftGit2


extension Project: Entity {
    
    static func all() -> [Project] {
        return (try? Project.query.sort(by: "name").all()) ?? []
    }
    
    var repo: Repository? {
        guard let path = path else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        let repo = Repository.at(url)
        return repo.value
    }
    
}
