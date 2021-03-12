//
//  SubViewController02.swift
//  Created on 2021/3/12
//  Description <#文件描述#>
 

import Cocoa

class SubViewController02: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.green.cgColor
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.delegate = self
    }
}

extension SubViewController02: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        let appDelegate = NSApplication.shared.delegate as? AppDelegate
        appDelegate?.showMainWindowController()
    }
}
