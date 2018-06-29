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
import SwiftGit2


class CommitViewController: NSViewController, NSTextViewDelegate {
    
    var project: Project!
    
    @IBOutlet var textView: NSTextView!
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var stagingColumn: NSTableColumn!
    @IBOutlet var fileColumn: NSTableColumn!
    
    var commit: ((String) -> Void)?
    var cancel: (() -> Void)?
    var stageAll: (() -> Void)?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        textView.string = project.lastCommitMessage ?? ""
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        // TODO: Restore the view size on new load!!
        UserDefaults.standard.set(NSStringFromRect(view.bounds), forKey: "ViewBounds")
        UserDefaults.standard.synchronize()
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
        
        project.stageAll()
        
        tableView.reloadData()
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


extension CommitViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return project.repo?.status().value?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
        guard let statuses = project.repo?.status().value else {
            return
        }
        let status = statuses[row]
        if let cell = cell as? NSButtonCell {
            cell.state = status.status.isStaged ? .on : .off
        } else if let cell = cell as? NSTextFieldCell {
            cell.stringValue = status.title
        }
    }
    
}
