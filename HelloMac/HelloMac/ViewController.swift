//
//  ViewController.swift
//  Created on 2021/3/8
//  Description <#文件描述#> 

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    @IBOutlet weak var timeTextField: NSTextField!
    @IBOutlet weak var eggImageView: NSImageView!
    
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    
    var eggTimer = EggTimer()
    var prefs = Prefrences()
    var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eggTimer.delegate = self
        registerEvents()
        prepareSound()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButtonClick(_ sender: Any) {
        if eggTimer.isPaused {
            eggTimer.resetTimer()
        } else {
            eggTimer.duration = prefs.selectedTime
            eggTimer.startTimer()
        }
        configureButtonsAndMenus()
    }
    
    @IBAction func stopButtonClick(_ sender: Any) {
        eggTimer.stopTimer()
        configureButtonsAndMenus()
    }
    
    @IBAction func resetButtonClick(_ sender: Any) {
        eggTimer.resetTimer()
        updateDisplay(for: prefs.selectedTime)
        configureButtonsAndMenus()
    }
    
    @IBAction func startTimerMenuItemSelected(_ sender: Any) {
        startButtonClick(sender)
    }

    @IBAction func stopTimerMenuItemSelected(_ sender: Any) {
        stopButtonClick(sender)
    }

    @IBAction func resetTimerMenuItemSelected(_ sender: Any) {
        resetButtonClick(sender)
    }
}

// MARK: - Audio
extension ViewController {
    func prepareSound() {
        guard let audioFileUrl = Bundle.main.url(forResource: "ding", withExtension: "mp3") else {
            return
        }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
            soundPlayer?.prepareToPlay()
        } catch {
            print("Sound Player not available: \(error)")
        }
    }
    
    func playSound() {
        soundPlayer?.play()
    }
}

// MARK: - UI
extension ViewController {
    func updateDisplay(for timeRamaining: TimeInterval) {
        timeTextField.stringValue = textToDisplay(for: timeRamaining)
        eggImageView.image = imageToDisplay(for: timeRamaining)
    }
    
    func checkForResetAfterPrefsChange() {
        if eggTimer.isStopped || eggTimer.isPaused {
            updateFromPrefs()
        } else {
            let alert = NSAlert()
            alert.messageText = "Reset Timer with new settings?"
            alert.informativeText = "This will stop your current timer!"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Reset")
            alert.addButton(withTitle: "Cancel")
            let response = alert.runModal()
            if response == NSApplication.ModalResponse.alertFirstButtonReturn {
                updateFromPrefs()
            } else {
                eggTimer.duration = prefs.selectedTime
            }
        }
    }
}

// MARK: - Events
extension ViewController {
    func configureButtonsAndMenus() {
        let enableStart: Bool
        let enableStop: Bool
        let enableReset: Bool
        
        if eggTimer.isStopped {
            enableStart = true
            enableStop = false
            enableReset = false
        } else if eggTimer.isPaused {
            enableStart = true
            enableStop = false
            enableReset = true
        } else {
            enableStart = false
            enableStop = true
            enableReset = false
        }
        
        startButton.isEnabled = enableStart
        stopButton.isEnabled = enableStop
        resetButton.isEnabled = enableReset
        
        if let appDelegate = NSApplication.shared.delegate as? AppDelegate {
            appDelegate.enableMenus(start: enableStart, stop: enableStop, reset: enableReset)
        }
    }
}

// MARK: - Tool
extension ViewController {
    
    private func registerEvents() {
        updateDisplay(for: prefs.selectedTime)
        let notificationName = NSNotification.Name("PrefsChanged")
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) { (_) in
            self.checkForResetAfterPrefsChange()
        }
    }
    
    private func updateFromPrefs() {
        eggTimer.duration = prefs.selectedTime
        resetButtonClick(self)
    }
    
    private func textToDisplay(for timeRemainig: TimeInterval) -> String {
        if timeRemainig == 0 {
            return "Done!"
        }
        
        let minutesRemaining = floor(timeRemainig / 60)
        let secondsRemaining = timeRemainig - minutesRemaining * 60
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        return timeRemainingDisplay
    }
    
    private func imageToDisplay(for timeRemaining: TimeInterval) -> NSImage? {
        let percentageComplete = 100 - (timeRemaining / prefs.selectedTime * 100)
        if eggTimer.isStopped {
            let stoppedImageName = timeRemaining == 0 ? "100" : "stopped"
            return NSImage(named: stoppedImageName)
        }
        
        let imageName: String
        switch percentageComplete {
        case 0..<25:
            imageName = "0"
        case 25..<50:
            imageName = "25"
        case 50..<75:
            imageName = "50"
        case 75..<100:
             imageName = "75"
        default:
            imageName = "100"
        }
        
        return NSImage(named: imageName)
    }
}

// MARK: - EggTimerAction
extension ViewController: EggTimerAction {
    func timeRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval) {
        updateDisplay(for: timeRemaining)
    }
    
    func timerHadFinished(_ timer: EggTimer) {
        updateDisplay(for: 0)
        playSound()
    }
}
