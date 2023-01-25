//
//  Caffeine_Menu_BarApp.swift
//  Caffeine Menu Bar
//
//  Created by Joseph Pecoraro on 1/24/23.
//

import AppKit
import SwiftUI

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

class AppDelegate: NSObject, NSApplicationDelegate {
    var caffeine: Caffeine?

    func applicationDidFinishLaunching(_ notification: Notification) {
        caffeine = Caffeine();
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        caffeine?.suspendTasks()
    }
    
    // TODO: cleanup background processes on SIGKILL
}
