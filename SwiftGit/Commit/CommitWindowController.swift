//
//  CommitWindowController.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 29/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Cocoa


class CommitWindowController: NSWindowController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        shouldCascadeWindows = true
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let window = window, let screen = window.screen {
            let offsetFromLeftOfScreen: CGFloat = 100
            let offsetFromTopOfScreen: CGFloat = 100
            let screenRect = screen.visibleFrame
            let newOriginY = screenRect.maxY - window.frame.height - offsetFromTopOfScreen
            window.setFrameOrigin(NSPoint(x: offsetFromLeftOfScreen, y: newOriginY))
        }
    }
    
    override func close() {
        super.close()
        
        NSApplication.shared.stopModal()
    }
    
}
