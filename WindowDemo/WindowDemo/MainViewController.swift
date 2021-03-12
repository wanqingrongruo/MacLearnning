//
//  MainViewController.swift
//  Created on 2021/3/12
//  Description <#文件描述#>

import Cocoa

class MainViewController: NSViewController {
    
    var windowViewController: NSWindowController?
    private var subWindowController01: NSWindowController?
    private var subWindowController02: NSWindowController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btn01Clicked(_ sender: Any) {
        let sub01VC = SubViewController01(nibName: "SubViewController01", bundle: nil)
        let sub01Window = NSWindow(contentViewController: sub01VC)
        sub01Window.styleMask = [.closable, .resizable, .titled]
        subWindowController01 = NSWindowController(window: sub01Window)
        subWindowController01?.showWindow(self)
    }
    
    @IBAction func btn02Clicked(_ sender: Any) {
        let sub02VC = SubViewController02(nibName: "SubViewController02", bundle: nil)
        let sub02Window = NSWindow(contentViewController: sub02VC)
        sub02Window.styleMask = [.closable, .resizable, .titled]
        subWindowController02 = NSWindowController(window: sub02Window)
        subWindowController02?.showWindow(self)
        windowViewController?.close()
    }
}
