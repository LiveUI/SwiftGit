//
//  CommitViewController.swift
//  SwiftGit
//
//  Created by Ondrej Rafaj on 29/06/2018.
//  Copyright © 2018 Rafaj Design. All rights reserved.
//

import Foundation
import Cocoa
import Reloaded


class CommitViewController: NSViewController, NSTextViewDelegate {
    
    var project: Project!
    
    @IBOutlet var textView: NSTextView!
    
    var commit: ((String) -> Void)?
    var cancel: (() -> Void)?
    var stageAll: (() -> Void)?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        textView.string = project.lastCommitMessage ?? ""
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        NSApplication.shared.stopModal()
    }
    
    func textDidChange(_ notification: Notification) {
        project.lastCommitMessage = (notification.object as? NSTextView)?.string
        try! project.save()
    }
    
    @IBAction func stageMissing(_ sender: NSButton) {
        stageAll?()
    }
    
    @IBAction func cancelCommit(_ sender: NSButton) {
        project.lastCommitMessage = textView.string
        try! project.save()
        
        cancel?()
    }
    
    @IBAction func makeCommit(_ sender: NSButton) {
        project.lastCommitMessage = ""
        try! project.save()
        
        commit?(textView.string)
    }
    
}
