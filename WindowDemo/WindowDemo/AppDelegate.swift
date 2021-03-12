//
//  AppDelegate.swift
//  Created on 2021/3/12
//  Description <#文件描述#>

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowControler: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        let mainWindow = NSWindow(contentViewController: mainViewController)
        mainWindowControler = NSWindowController(window: mainWindow)
        mainViewController.windowViewController = mainWindowControler
        mainWindowControler?.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            mainWindowControler?.showWindow(self)
        }
        
        return true
    }
}

extension AppDelegate {
    func showMainWindowController() {
        if let visible = mainWindowControler?.window?.isVisible, visible {
            return
        }
        mainWindowControler?.showWindow(self)
    }
}
