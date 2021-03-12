//
//  DemoViewController.swift
//  Created on 2021/3/12
//  Description <#文件描述#>

//  Copyright © 2021 Huami inc. All rights reserved.
//  @author zhengwenxiang(zhengwenxiang@huami.com)  

import Cocoa

class DemoViewController: NSViewController {
    
    override class func awakeFromNib() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.layer?.backgroundColor = NSColor.red.cgColor
        view.wantsLayer = true
    }
}
