//
//  EggTimer.swift
//  Created on 2021/3/10
//  Description <#文件描述#> 

import Foundation

protocol EggTimerAction: class {
    func timeRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval)
    func timerHadFinished(_ timer: EggTimer)
}

let defaultTimeForEgg: TimeInterval = 600 // 默认计时时间

class EggTimer {
    var timer: Timer?
    var startTime: Date?
    var duration: TimeInterval = defaultTimeForEgg
    var elapsedTime: TimeInterval = 0
    weak var delegate: EggTimerAction?
    
    var isStopped: Bool {
        return timer == nil && elapsedTime == 0
    }
    
    var isPaused: Bool {
        return timer == nil && elapsedTime > 0
    }
    
    @objc func timerAction() {
        guard let startTime = startTime else {
            return
        }
        
        elapsedTime = -startTime.timeIntervalSinceNow
        let secondsRemaining = (duration - elapsedTime).rounded()
        if secondsRemaining <= 0 {
            resetTimer()
            delegate?.timerHadFinished(self)
        } else {
            delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
        }
    }
    
    func startTimer() {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timerAction()
    }
    
    func resumeTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timerAction()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerAction()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        duration = defaultTimeForEgg
        elapsedTime = 0
        timerAction()
    }
}
