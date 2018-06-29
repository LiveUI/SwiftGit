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
    
    @objc func commit(_ sender: NSMenuItem) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Commit Window Controller") as! NSWindowController
        if let commitWindow = windowController.window {
            let controller = commitWindow.contentViewController as! CommitViewController
            controller.project = sender.project
            controller.cancel = {
                windowController.close()
            }
            controller.stageAll = {
                print("Stage all yo!")
            }
            controller.commit = { commitMessage in
                print(commitMessage)
            }
            
            NSApplication.shared.runModal(for: commitWindow)
            commitWindow.close()
        }
    }
    
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
    
    let subsAsCatsKey = "SubsAsCats"
    
    @objc func didTapStatusBarIcon() {
        let menu: NSMenu = NSMenu()
        
        var item = NSMenuItem(title: "Configuration", action: nil, keyEquivalent: "")
        let configuration = NSMenu()
        
        // Use subfolders as categories
        let prefix: String
        let subEnabled = UserDefaults.standard.bool(forKey: subsAsCatsKey)
        if subEnabled {
            prefix = "✔ "
        } else {
            prefix = ""
        }
        var config = NSMenuItem(title: prefix + "Use subfolders as categories", action: #selector(toggleSubfolders(_:)), keyEquivalent: "")
        configuration.addItem(config)
        
        // Load all projects
        let projects = Project.all()
        
        // Remove all projects from the app
        let selector: Selector?
        if projects.count > 0 {
            selector = #selector(removeAllProjects(_:))
        } else {
            selector = nil
        }
        config = NSMenuItem(title: "Remove all projects at once ...", action: selector, keyEquivalent: "")
        configuration.addItem(config)
        
        // Go to github homepage
        config = NSMenuItem(title: "Github.com homepage ...", action: #selector(goHome(_:)), keyEquivalent: "")
        configuration.addItem(config)
        
        item.submenu = configuration
        menu.addItem(item)
        
        menu.addItem(.separator())
        
        // Add projects
        if projects.count > 0 {
            menu.add(projects: projects)
            menu.addItem(.separator())
        }
        
        // Add new project
        item = NSMenuItem(title: "Add projects ...", action: #selector(addProject(_:)), keyEquivalent: "a")
        menu.addItem(item)
        
        menu.addItem(.separator())
        
        // Quit app
        item = NSMenuItem(title: "Quit", action: #selector(exit(_:)), keyEquivalent: "q")
        menu.addItem(item)
        
        self.statusItem?.popUpMenu(menu)
    }
    
    // MARK: Working with derived data
    
    @objc func removeAllProjects(_ sender: NSMenuItem) {
        let alert = NSAlert()
        alert.messageText = "Confirmation"
        alert.informativeText = "Are you really sure? Like really, really sure?!"
        alert.addButton(withTitle: "Yes")
        alert.addButton(withTitle: "No")
        
        if alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn {
            Projects.removeAllProjects()
        }
    }
    
    @objc func toggleSubfolders(_ sender: NSMenuItem) {
        let subEnabled = UserDefaults.standard.bool(forKey: subsAsCatsKey)
        UserDefaults.standard.set(!subEnabled, forKey: subsAsCatsKey)
        UserDefaults.standard.synchronize()
    }
    
    @objc func goHome(_ sender: NSMenuItem) {
        guard let url = URL(string: "https://github.com/LiveUI/SwiftGit") else { return }
        NSWorkspace.shared.open(url)
    }
    
    @objc func addProject(_ sender: NSMenuItem) {
        Projects.addProject()
    }
    
    @objc func exit(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
}

