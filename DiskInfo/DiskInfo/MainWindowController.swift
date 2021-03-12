//
//  MainWindowController.swift
//  Created on 2021/3/11
//  Description <#文件描述#>

import Cocoa

class MainWindowController: NSWindowController {
    
    override func awakeFromNib() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 800)
        window?.setFrame(frame, display: true, animate: window?.isVisible ?? false)
        demoViewController.view.frame = frame
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.contentViewController = demoViewController
    }
    
    lazy var demoViewController: DemoViewController = {
        let vc = DemoViewController(nibName: "DemoViewController", bundle: nil)
        return vc
    }()
    
    
}
