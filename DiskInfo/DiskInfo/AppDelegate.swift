import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var mainWindowController: MainWindowController = {
        let windowController = MainWindowController(windowNibName: "MainWindowController")
        return windowController
    }()

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
    
     mainWindowController.showWindow(self)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
}
