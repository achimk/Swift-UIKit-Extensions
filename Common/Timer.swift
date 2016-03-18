//
//  Timer.swift
//
//  Created by Joachim Kret on 18/03/16.
//  Copyright © 2016 Joachim Kret. All rights reserved.
//

import Foundation

protocol TimerSchedulable {
    var timeInterval: NSTimeInterval { get }
    var valid: Bool { get }
    func fire()
    func invalidate()
}

extension NSTimer: TimerSchedulable { }

typealias TimerCallback = (TimerSchedulable?) -> (Void)

private class TimerTarget {
    let callback: TimerCallback
    
    init(_ callback: TimerCallback) {
        self.callback = callback
    }
    
    @objc func fire(timer: AnyObject) {
        if let timer = timer as? TimerSchedulable {
            self.callback(timer)
        }
    }
}

class Timer {
    private var timer: NSTimer
    
    required init(timer: NSTimer) {
        self.timer = timer
    }
    
    deinit {
        invalidate()
    }
}

extension Timer: TimerSchedulable {
    var timeInterval: NSTimeInterval {
        return timer.timeInterval
    }
    
    var valid: Bool {
        return timer.valid
    }
    
    func fire() {
        timer.fire()
    }
    
    func invalidate() {
        timer.invalidate()
    }
}

extension Timer {
    class func after(interval: NSTimeInterval, _ callback: TimerCallback) -> Self {
        return self.init(timer: NSTimer.after(interval, callback))
    }
    
    class func every(interval: NSTimeInterval, _ callback: TimerCallback) -> Self {
        return self.init(timer: NSTimer.every(interval, callback))
    }
}

extension NSTimer {
    class func new(after interval: NSTimeInterval, _ callback: TimerCallback) -> Self {
        let target = TimerTarget(callback)
        return self.init(timeInterval: interval, target: target, selector: "fire:", userInfo: nil, repeats: false)
    }
    
    class func new(every interval: NSTimeInterval, _ callback: TimerCallback) -> Self {
        let target = TimerTarget(callback)
        return self.init(timeInterval: interval, target: target, selector: "fire:", userInfo: nil, repeats: true)
    }
    
    class func after(interval: NSTimeInterval, _ callback: TimerCallback) -> Self {
        let timer = new(after:interval, callback)
        timer.start()
        return timer
    }
    
    class func every(interval: NSTimeInterval, _ callback: TimerCallback) -> Self {
        let timer = new(every:interval, callback)
        timer.start()
        return timer
    }
    
    func start(runLoop: NSRunLoop = NSRunLoop.currentRunLoop(), modes: String...) {
        let modes = modes.isEmpty ? [NSDefaultRunLoopMode] : modes
        
        modes.forEach { mode in
            runLoop.addTimer(self, forMode: mode)
        }
    }
}
