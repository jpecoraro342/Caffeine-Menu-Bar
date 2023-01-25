//
//  Caffeine.swift
//  Caffeine Menu Bar
//
//  Created by Joseph Pecoraro on 1/24/23.
//

import Cocoa

class Caffeine {
    var statusItem: NSStatusItem!
    var caffeinateProcess: Process?
    
    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        refreshUI()
    }
    
    func updateMenu() {
        let menu = NSMenu()
        
        let title = caffeinateProcess == nil ? "Caffeinate" : "Stop Caffeinating"

        let caffeinateMenuItem = NSMenuItem(title: title, action: #selector(toggleCaffeination), keyEquivalent: "")
        caffeinateMenuItem.target = self
        
        menu.addItem(caffeinateMenuItem)
        menu.addItem(NSMenuItem.separator())
        
        // TODO: Add more menu items
        // Caffeinate for 1 hour
        // Caffeinate for 3 hours
        // Caffeinate for 12 hours
        // Display sleep?
        // others?
        
        // TODO: Add a way to kill all running caffeine processes
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q"))

        statusItem.menu = menu
    }
    
    func updateStatusIcon() {
        // TODO: Change to filled image for more weight?
        statusItem.button?.image = caffeinateProcess == nil ? NSImage(named: "coffee-cup-cold-white") : NSImage(named: "coffee-cup-hot-white")
    }
    
    func refreshUI() {
        updateStatusIcon()
        updateMenu()
    }
    
    @objc func toggleCaffeination() {
        if let caffeine = caffeinateProcess {
            caffeine.interrupt()
            caffeinateProcess = nil
        } else {
            caffeinate()
        }
        
        refreshUI()
    }
    
    func caffeinate() {
        // TODO: make the caffeinate process a builder (and add test cases)
        let caffeinate = Process()
        caffeinate.launchPath = "/usr/bin/caffeinate"
        
        do {
            try caffeinate.run()
            caffeinateProcess = caffeinate
        } catch {
            displayAlert(error: error)
        }
    }
    
    func displayAlert(error: Error) {
        let alert = NSAlert()
        alert.messageText = "Unable to Caffeinate"
        alert.informativeText = error.localizedDescription
        alert.addButton(withTitle: "Ok")
        alert.alertStyle = .warning
        alert.runModal()
    }
    
    func suspendTasks() {
        caffeinateProcess?.interrupt()
        caffeinateProcess = nil
    }
}
