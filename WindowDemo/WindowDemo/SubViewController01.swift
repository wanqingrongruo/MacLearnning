//
//  SubViewController01.swift
//  Created on 2021/3/12
//  Description <#文件描述#>

import Cocoa

class SubViewController01: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
    }
}
