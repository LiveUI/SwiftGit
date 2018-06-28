//
//  AppDelegate.swift
//  DDDestroyer
//
//  Created by Rafaj Design on 22/03/2017.
//  Copyright © 2017 Rafaj Design. All rights reserved.
//

import Cocoa
import AppKit


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
        self.statusItem?.action = #selector(didTapStatusBarIcon)
    }
    
    // MARK: Actions
    
    @objc func didTapStatusBarIcon() {
        let menu: NSMenu = NSMenu()
        
        
        
        menu.addItem(.separator())
        
        let item = NSMenuItem(title: "Add project ...", action: #selector(addProject), keyEquivalent: "")
        menu.addItem(item)
        
        self.statusItem?.popUpMenu(menu)
    }
    
    // MARK: Working with derived data
    
    @objc func addProject() {
        
    }
    
}

