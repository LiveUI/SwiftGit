//
//  AppDelegate.swift
//  DDDestroyer
//
//  Created by Rafaj Design on 22/03/2017.
//  Copyright © 2017 Rafaj Design. All rights reserved.
//

import Cocoa
import AppKit
import Reloaded


@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    var statusItem: NSStatusItem?
    
    var menuItems: [NSMenuItem] = []
    var subDirectories: [URL] = []
    
    // MARK: Application delegate methods
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusItem?.image = NSImage(named: "icon")
        self.statusItem?.image?.isTemplate = true
        self.statusItem?.image?.size = CGSize(width: 16, height: 16)
        self.statusItem?.action = #selector(didTapStatusBarIcon)
    }
    
    // MARK: Actions
    
    @objc func fetch(_ sender: NSMenuItem) {
        guard let repo = sender.project.repo else {
            return
        }
        
        // TODO: Fetch only selected remote!
        for remote in repo.allRemotes().value ?? [] {
            // TODO: Show results in console!!!
            _ = repo.fetch(remote)
        }
    }
    
    @objc func push(_ sender: NSMenuItem) {
//        guard let repo = sender.project.repo else {
//            return
//        }
//        for remote in repo.allRemotes().value ?? [] {
//
//        }
    }
    
    @objc func pull(_ sender: NSMenuItem) {
//        guard let repo = sender.project.repo else {
//            return
//        }
//
//        fetch(sender)
//        // TODO: Checkout latest commit
    }
    
    @objc func revealInFinder(_ sender: NSMenuItem) {
        guard let info = sender.representedObject as? FileInfo else {
            return
        }
        NSWorkspace.shared.selectFile(info.fullPath, inFileViewerRootedAtPath: info.fullPath)
    }
    
    @objc func removeProject(_ sender: NSMenuItem) {
        Projects.remove(sender.project)
    }
    
    @objc func didTapStatusBarIcon() {
        let menu: NSMenu = NSMenu()
        
        let projects = Project.all()
        if projects.count > 0 {
            menu.add(projects: projects)
            menu.addItem(.separator())
        }
        
        var item = NSMenuItem(title: "Add project ...", action: #selector(addProject(_:)), keyEquivalent: "a")
        menu.addItem(item)
        
        menu.addItem(.separator())
        
        item = NSMenuItem(title: "Quit", action: #selector(exit(_:)), keyEquivalent: "q")
        menu.addItem(item)
        
        self.statusItem?.popUpMenu(menu)
    }
    
    // MARK: Working with derived data
    
    @objc func addProject(_ sender: NSMenuItem) {
        Projects.addProject()
    }
    
    @objc func exit(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
}

